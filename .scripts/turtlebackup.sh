#!/bin/bash

dockpath=/mnt/scratch/dock
zfsdataset=turtleshell/backup

# check checksum
cd ${dockpath}
echo $dockpath
for file in ${dockpath}/*; do
    gzfile=$(basename -- "$file")

    if [[ $gzfile =~ "base" || $gzfile =~ "md5" ]]; then # base should be checked manually
        continue
    fi

    snapshotname=${gzfile:0:17}
    echo $snapshotname

    # uhhhhhhhhhhhhhhhh
    cat "${snapshotname}.gz" | md5sum > ".${snapshotname}.md5"
    if [[ $(diff "$snapshotname.md5" ".$snapshotname.md5") ]]; then
        # Different
        msg="$(date +"%Y-%m-%d") [TURTLEBACKUP]: there was an issue with the checksum of $snapshotname.gz, backup aborted"
        echo $msg >> /home/jimmy/announcement
        rm ".$snapshotname.md5"
        exit
    else
        echo "$gzfile matched checksum"
        rm ".$snapshotname.md5"
    fi

    # zfs recv
    # skip this snapshot is older than what we have
    latest=$(zfs list -t snapshot -o name | tail -1 | grep -oP '(?<=@).{8}')
    if [[ "$latest" -ge "${snapshotname: -8}" ]]; then
        continue
    fi
    cat "$file"| gunzip | zfs recv -F $zfsdataset

    if [[ ! $? -eq 0 ]]; then
        printf "\nzfs  recv of $snapshotname into backup failed\n" >> /home/jimmy/announcement
        exit
    fi
done

# keep last 6 snapshots
snaps_to_delete=$(zfs list -t snapshot -o name | tail +2 | head -n -6)
for snap in $snaps_to_delete; do 
    delsnapdate=${snap: -8}

    #if [ $(($(date +"%Y%m%d") - $(echo $delsnapdate))) -gt 99 ]; then
    #fi
    rm ${dockpath}/*-$delsnapdate.md5
    rm ${dockpath}/*-$delsnapdate.gz
    zfs destroy -r $snap
done

# check for stragglers
oldest=$(zfs list -t snapshot -o name | head -2 | tail -1 | grep -oP '(?<=@).{8}')


for file in ${dockpath}/*; do
    filename=$(basename -- "$file")
    date=${filename:0:8}
    if [[ "$oldest" -gt "$date" ]]; then
        rm $file
    fi
done
