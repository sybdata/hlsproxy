FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

# set ports
EXPOSE 8624 62064 6878 8048

RUN \
apt-get update && apt-get upgrade -y && \
apt-get update -y && \
apt-get install -y \
wget \
mc \
nano \
tzdata && \
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
dpkg-reconfigure --frontend noninteractive tzdata && \
apt-get autoremove -y && \

#acestream
mkdir -p /opt/acestream/ && \
wget -o - https://sybdata.de/data/acestream/acestream_3.1.33.1_x86_wbUI.tar.gz && \
tar -zxvf acestream_3.1.33.1_x86_wbUI.tar.gz && \
mv androidfs /opt/acestream/androidfs && \

# install hlsproxy
wget -o - https://www.hls-proxy.com/downloads/5.3.0/hls-proxy-5.3.0.linux-x64.zip -O hlsproxy.zip && \
unzip hlsproxy.zip -d /opt/hlsp/ && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*
COPY root/ /
RUN chmod +x /start.sh
RUN chmod +x /opt/hlsp/hls-proxy
CMD ["/opt/acestream.engine/start.sh"]

