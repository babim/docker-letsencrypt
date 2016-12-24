#!/bin/bash
set -e
/letsencrypt/ns/ns-cronjob.sh
exec "$@"
