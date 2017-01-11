#!/bin/bash
set -e

# make data
if [ -z "`ls /letsencrypt`" ]; then cp -R /letsencrypt-start/* /letsencrypt;fi

# start cron
if [ -f "/runcron.sh" ]; then /runcron.sh; fi

# start auto
if [ -n "${AUTO:-}" ]; then /letsencrypt/auto.sh; fi

echo Ready

exec "$@"
