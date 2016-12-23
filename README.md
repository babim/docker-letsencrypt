[![](https://images.microbadger.com/badges/image/babim/letsencrypt.svg)](https://microbadger.com/images/babim/letsencrypt "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/babim/letsencrypt.svg)](https://microbadger.com/images/babim/letsencrypt "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/letsencrypt:ssh.svg)](https://microbadger.com/images/babim/letsencrypt:ssh "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/babim/letsencrypt:ssh.svg)](https://microbadger.com/images/babim/letsencrypt:ssh "Get your own version badge on microbadger.com")

# docker-letsencrypt
letsencrypt on Debian

```
docker run --name letsencrypt -p 80:80 -p 443:443 -v /data/letsencrypt-data:/letsencrypt babim/letsencrypt
```
volume: /letsencrypt /letsencrypt/etc
SSH password: -e SSHPASS=pass or default root

## start with bash

go to console and use by command 
```
./letsencrypt-auto
or
/letsencrypt/src/letsencrypt-auto
```

## config crontab
```
For this example I run the job once a month on the 1st day of the month at 12AM.
0 0 1 * * /letsencrypt/src/letsencrypt-auto renew
0 0 1 * * /letsencrypt/ns/ns-cronjob.sh
```

## document Let's Encrypt

https://www.linode.com/docs/security/ssl/install-lets-encrypt-to-create-ssl-certificates

## document ns-letsencrypt

http://techdrabble.com/citrix/18-letsencrypt-san-certificate-with-citrix-netscaler-take-2
