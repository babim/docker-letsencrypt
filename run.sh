#!/bin/bash
set -e
# make data
if [ -z "`ls /letsencrypt`" ]; then cp -R /letsencrypt-start/* /letsencrypt; fi
# update
if [ -f "/letsencrypt/update.sh" ]; then /letsencrypt/update.sh; fi
# cron
service cron start

# start auto
if [ -n "${AUTO:-}" ]; then /letsencrypt/auto.sh; fi

exec "$@"
