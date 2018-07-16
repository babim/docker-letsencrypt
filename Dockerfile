FROM babim/debianbase

# install
RUN apt-get update && apt-get install git -y && \
    git clone https://github.com/letsencrypt/letsencrypt /letsencrypt && \
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
RUN mkdir /letsencrypt-start && mv /letsencrypt /letsencrypt-start/src && \
    ln -sf /letsencrypt-start /letsencrypt && \
    mkdir -p /letsencrypt-start/etc && \
    ln -sf /letsencrypt/etc /etc/letsencrypt && chmod +x /run.sh
# make update file
COPY sh /letsencrypt-start/
RUN chmod +x /letsencrypt-start/*.sh

VOLUME /letsencrypt/
WORKDIR /letsencrypt/src
ENTRYPOINT ["/run.sh"]
CMD ["bash"]
EXPOSE 80 443
