#!/bin/bash
set -e
cd /letsencrypt/src
git pull
cd /letsencrypt/ns
git pull
exec "$@"
