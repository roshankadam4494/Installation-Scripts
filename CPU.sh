#!/bin/bash
HN=PROD-1
HIP=$(hostname -I)
TIME=$(date +"%m-%d-%Y_%H:%M:%S")
Tomail=team@gmail.com
Fromail=abc@gmail.com
CRIT=80
[ ! -z ${CRIT} ] || usage

CPU_USAGE="$(vmstat 1 2|tail -1)"
CPU_USER="$(echo ${CPU_USAGE} | awk '{print $13}')"
CPU_SYSTEM="$(echo ${CPU_USAGE} | awk '{print $14}')"
CPU_IOWAIT="$(echo ${CPU_USAGE} | awk '{print $16}')"
CPU_ST="$(echo ${CPU_USAGE} | awk '{print $17}')"

if [[ ${CPU_USER} -gt ${CRIT} || ${CPU_SYSTEM} -gt ${CRIT} || ${CPU_IOWAIT} -gt ${CRIT} || ${CPU_ST} -gt ${CRIT} ]]
then
        mail -s "$HN CPU alert"  -r $Fromail $Tomail << EOF

CPU utilization reached to threshold.

        Date_Time: $TIME
              Host: $HN
                 IP: $HIP

CPU Usage: USER=${CPU_USER}; SYSTEM=${CPU_SYSTEM}; IOWAIT=${CPU_IOWAIT}; ST=${CPU_ST}
EOF

fi
