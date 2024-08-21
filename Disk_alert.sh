#!/bin/bash

CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=75
Server=test-1

IP=`ifconfig | grep -i "inet" | head -n 1 | awk {'print $2'}`
TIME=$(date +"%m-%d-%Y_%H:%M:%S")
ToMAIL=team@gmail.com
FromMail=abc@gmail.com

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
        mail -s "'$HOSTNAME' Disk Space Alert" -r $FromMail $ToMAIL << EOF

Root partition is critical.
                   Date: $TIME
                   Host: $Server
                     IP: $HOSTNAME
                   Used: $CURRENT%
EOF
fi
