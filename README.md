# docker-letsencrypt
letsencrypt on Debian

```
docker run --name letsencrypt -p 80:80 -p 443:443 -v /data/letsencrypt-data:/letsencrypt babim/letsencrypt
```
volume: /letsencrypt /letsencrypt/etc

## start with bash

go to console and use by command ./letsencrypt-auto or /letsencrypt/letsencrypt-auto

## config crontab
```
For this example I run the job once a month on the 1st day of the month at 12AM.
0 0 1 * * /letsencrypt/src/letsencrypt-auto renew
0 0 1 * * /letsencrypt/ns/ns-cronjob.sh
```
