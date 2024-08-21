#!/bin/bash

cd /var/www/services/service_name
ls -td service_name-* | tail -n +6 | xargs rm -rf
