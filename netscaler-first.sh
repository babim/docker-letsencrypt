#!/bin/bash
set -e
/letsencrypt/ns/dehydrated/dehydrated -c -f /letsencrypt/ns/config.sh -k /letsencrypt/ns/ns-firstrunhook.sh
exec "$@"
