#!/bin/bash
now=$(date -d '-1 day' +'%m%d%Y_%H%M%S')

cp -r /var/www/services/logs_api/service_log /var/www/services/logs_api/service_log.$now
> /var/www/services/logs_api/service_log

cd /var/www/services/logs_api/service_log
find . -type f -name "service_log.*" -mtime +31 -exec rm -f {} \;
