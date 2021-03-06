#!/bin/bash
# Validate environment variables

# start auto
if [ ! -n "${DOMAIN:-}" ]; then
read -p "Type Domain (example: video.matmagoc.com audio.matmagoc.com matmagoc.com): " DOMAIN
fi
if [ ! -n "${EMAIL:-}" ]; then
read -p "Type Email: " EMAIL
fi
if [ ! -n "${STAGING:-}" ]; then
read -p "STAGING Server (Type 1 or enter to skip): " STAGING
fi

MISSING=""

[ -z "${DOMAIN}" ] && MISSING="${MISSING} DOMAIN"
[ -z "${EMAIL}" ] && MISSING="${MISSING} EMAIL"

if [ "${MISSING}" != "" ]; then
  echo "Missing required environment variables:" >&2
  echo " ${MISSING}" >&2
  echo " Check and Try again!" >&2
  exit 1
fi

# Default other parameters

SERVER=""
[ -n "${STAGING:-}" ] && SERVER="--server https://acme-staging.api.letsencrypt.org/directory"

# for begin
	for isubDOMAIN in $DOMAIN;do
	lastDOMAIN=$(echo $isubDOMAIN | awk -F':' '{ print $1 }')
	done
	for isubDOMAIN in $DOMAIN;do
	ilastsubDOMAIN=$(echo $isubDOMAIN | awk -F':' '{ print $1 }')
	echo "--domain $ilastsubDOMAIN" >> tempdomainname
	done
	lastsubDOMAIN=$(tr '\n' ' ' < tempdomainname)
	rm tempdomainname
	
# Initial certificate request, but skip if cached
if [ ! -f /etc/letsencrypt/live/${lastDOMAIN}/fullchain.pem ]; then
  letsencrypt certonly \
   $lastsubDOMAIN \
   --authenticator standalone \
    ${SERVER} \
    --email "${EMAIL}" --agree-tos
fi

# Template a cronjob to reissue the certificate with the webroot authenticator
if [ ! -f "/etc/periodic/monthly/reissue" ]; then
cat <<EOF >/etc/periodic/monthly/reissue
#!/bin/sh
set -euo pipefail
# Certificate reissue
letsencrypt certonly --renew-by-default \
   $lastsubDOMAIN \
  --authenticator webroot \
  --webroot-path /etc/letsencrypt/webrootauth/ ${SERVER} \
  --email "${EMAIL}" --agree-tos
EOF
chmod +x /etc/periodic/monthly/reissue
fi

if [ -f "/etc/periodic/monthly/reissue" ]; then
cat <<EOF >>/etc/periodic/monthly/reissue
#!/bin/sh
set -euo pipefail
# Certificate reissue
letsencrypt certonly --renew-by-default \
   $lastsubDOMAIN \
  --authenticator webroot \
  --webroot-path /etc/letsencrypt/webrootauth/ ${SERVER} \
  --email "${EMAIL}" --agree-tos
EOF
fi
