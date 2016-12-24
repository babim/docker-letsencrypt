#!/bin/bash
set -e
cd /letsencrypt/src
git pull
cd /letsencrypt/ns
git pull
git submodule update --init --recursive
exec "$@"
