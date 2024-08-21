#!/bin/bash
CONTAINER=mqttcontainer
TIME=$(date +"%m-%d-%Y_%H:%M:%S")
IP=$(hostname -I)
fromail=no-team@gmail.com
tomail=abc@gmail.com
HN=PROD-1

echo "$TIME"
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

#Step 1: checking if container exists
if [ $? -eq 1 ]; then
    echo "$CONTAINER does not exist." >> /tmp/containerlogs.txt
    mail -s "$HN - $IP Docker container alert"  -r $fromail $T=tomail << EOF
    Host Name : $HN
    IP        : $IP
    Time      : $TIME
    Message   : $CONTAINER does not exist
EOF
    exit 3
fi


#Step 2: checking status of the container
if [ "$RUNNING" == "false" ]; then
   echo "CRITICAL - $CONTAINER is not running." >> /tmp/containerlogs.txt
   mail -s "$HN - $IP Docker container alert"  -r $fromail $tomail << EOF
   Host Name : $HN
   IP        : $IP
   Time      : $TIME
   Message   : $CONTAINER IS NOT RUNNING
EOF
   exit 2
fi

#Step 2: checking status of the container
if [ "$RUNNING" == "true" ]; then
   echo "$CONTAINER is running." >> /tmp/containerlogs.txt
fi

echo "End of Script" >> /tmp/containerlogs.txt
echo "$TIME" >> /tmp/containerlogs.txt
echo "==========================" >> /tmp/containerlogs.txt
