#!/bin/bash
set -e
# make data
if [ -z "`ls /letsencrypt`" ]; then cp -R /letsencrypt-start/* /letsencrypt; fi
# cron
service cron start
exec "$@"
