FROM babim/debianbase:cron

# install
RUN apt-get update && apt-get install python git python-pip curl -y && \
    git clone https://github.com/letsencrypt/letsencrypt /letsencrypt && \
    git clone --recursive https://github.com/ryancbutler/ns-letsencrypt /ns-letsencrypt && \
    cp /ns-letsencrypt/domains.txt.example /ns-letsencrypt/domains.txt && cp /ns-letsencrypt/config.sh.example /ns-letsencrypt/config.sh && \
    /letsencrypt/letsencrypt-auto --os-packages-only && /letsencrypt/letsencrypt-auto --help
# clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
# make data
ADD run.sh /run.sh
RUN mkdir /letsencrypt-start && mv /letsencrypt /letsencrypt-start/src && mv /ns-letsencrypt /letsencrypt-start/ns && \
    ln -sf /letsencrypt-start /letsencrypt && \
    mkdir -p /letsencrypt-start/etc && \
    ln -sf /letsencrypt/etc /etc/letsencrypt && chmod +x /run.sh
# make update file
ADD update.sh /letsencrypt/update.sh
RUN chmod +x /letsencrypt/update.sh

VOLUME /letsencrypt/
WORKDIR /letsencrypt/src
ENTRYPOINT ["/run.sh"]
CMD ["bash"]
EXPOSE 80 443
