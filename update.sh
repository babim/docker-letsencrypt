#!/bin/bash
set -e
cd /letsencrypt/src
git pull
exec "$@"
