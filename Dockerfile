FROM babim/debianbase:cron

# install
RUN apt-get update && apt-get install git -y && \
    git clone https://github.com/letsencrypt/letsencrypt /letsencrypt && \
    /letsencrypt/letsencrypt-auto --os-packages-only
#clean
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /build && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
#make data
ADD run.sh /run.sh
RUN mv /letsencrypt /letsencrypt-start && \
    ln -sf /letsencrypt-start /letsencrypt && \
    mkdir -p /letsencrypt-start/etc && \
    ln -sf /letsencrypt-start/etc /etc/letsencrypt && chmod +x /run.sh

VOLUME /letsencrypt/
WORKDIR /letsencrypt
ENTRYPOINT ["/run.sh"]
CMD ["bash"]
EXPOSE 80 443
