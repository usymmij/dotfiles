#!/bin/bash

# this script turns on syncthing with a cronjob
# run the following 

# $ chmod +x path/sync.sh
# $ crontab -e
# @reboot path/sync.sh

syncthing -gui-address="0.0.0.0:8443"
