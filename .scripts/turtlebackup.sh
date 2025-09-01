#!/bin/bash

# copy to /mnt/scratch/backups
# base should be done using physical drives cuz its just so slow
rsync -av -e "ssh -i $HOME/.ssh/turtle" --exclude "base*" $TURTLEIP:/tank/backups/ /mnt/scratch

# check checksum
cd /mnt/scratch/
for file in /mnt/scratch/*; do
    gzfile=${file:13}
    if [[ $gzfile =~ "base" || $gzfile =~ "md5" ]]; then # base should be checked manually
        continue
    fi
    
    filename=${gzfile:0:17}
    echo $filename

    cat "$filename.gz" | md5sum > ".$filename.md5"
    if [[ $(diff "$filename.md5" ".$filename.md5") ]]; then
        # Different
        msg="$(date +"%Y-%m-%d") [TURTLEBACKUP]: there was an issue with the checksum of $filename.gz, backup aborted"
        echo $msg >> /home/jimmy/announcement
        exit
    fi

    # zfs recv
    result=$(cat "/mnt/scratch/$gzfile"| gunzip | zfs recv -F turtleshell/backup 2>&1)
done

# TODO: only keep last 8 compressed backup files
# TODO: only keep last 8 recv'd snapshots
