#!/bin/bash

for i in `cat /home/RK/user.txt`
do
        ssh $i "hostname" >> /home/user.txt
        echo "---------------" >> /home/user.txt
        ssh $i "cat /etc/passwd | cut -d ":" -f 1" >> /home/user.txt
done
