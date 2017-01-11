[![](https://images.microbadger.com/badges/image/babim/letsencrypt.svg)](https://microbadger.com/images/babim/letsencrypt "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/babim/letsencrypt.svg)](https://microbadger.com/images/babim/letsencrypt "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/letsencrypt:ssh.svg)](https://microbadger.com/images/babim/letsencrypt:ssh "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/babim/letsencrypt:ssh.svg)](https://microbadger.com/images/babim/letsencrypt:ssh "Get your own version badge on microbadger.com")

# docker-letsencrypt
letsencrypt on Alpine Linux

thanks https://github.com/CognitiveScale/lets-alpine

```
docker run --name letsencrypt -p 80:80 -p 443:443 -v /data/letsencrypt-data:/letsencrypt babim/letsencrypt
```
volume: /letsencrypt /letsencrypt/etc

## start with bash

go to console and use by command 
```
letsencrypt
```
or set `-e AUTO=1` to run auto.sh when start
```
-e DOMAIN="video.abc.com audio.abc.com abc.com"
-e EMAIL=abc@abc.com
```
## document Let's Encrypt

https://www.linode.com/docs/security/ssl/install-lets-encrypt-to-create-ssl-certificates

## document ns-letsencrypt

http://techdrabble.com/citrix/18-letsencrypt-san-certificate-with-citrix-netscaler-take-2
