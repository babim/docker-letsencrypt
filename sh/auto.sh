#!/bin/bash
# Validate environment variables

read -p "Type Domain (example: video.matmagoc.com audio.matmagoc.com matmagoc.com): " DOMAIN
read -p "Type Email: " EMAIL
read -p "STAGING Server (Type 1 or enter to skip): " STAGING

MISSING=""

[ -z "${DOMAIN}" ] && MISSING="${MISSING} DOMAIN"
[ -z "${EMAIL}" ] && MISSING="${MISSING} EMAIL"

if [ "${MISSING}" = "" ]; then

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
