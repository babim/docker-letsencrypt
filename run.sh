#!/bin/bash
set -e
# make data
if [ -z "`ls /letsencrypt`" ]; then cp -R /letsencrypt-start/* /letsencrypt; fi
# ssh
if [ -f "/runssh.sh" ]; then /runssh.sh; fi
# cron
service cron start
exec "$@"
