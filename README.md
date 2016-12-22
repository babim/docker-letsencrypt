# docker-letsencrypt
letsencrypt on Debian

```
docker run --name letsencrypt -p 80:80 -p 443:443 -v /data/letsencrypt-data:/letsencrypt babim/letsencrypt
```
volume: /letsencrypt /letsencrypt/etc

start with bash

go to console and use by command ./letsencrypt-auto or /letsencrypt/letsencrypt-auto
