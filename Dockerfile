FROM ubuntu:19.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

# set ports
EXPOSE 8621 62062 6878 8085

RUN \
apt-get update && apt-get upgrade -y && \
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
mv acestream.engine/ /opt/ && \

# install hlsproxy
wget -o - https://www.hls-proxy.com/downloads/5.4.1/hls-proxy-5.4.1.linux-x64.zip -O hlsproxy.zip && \
unzip hlsproxy.zip -d /opt/hlsp/ && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*
COPY root/ /
RUN chmod +x /opt/acestream.engine/start.sh
RUN chmod +x /opt/hlsp/hls-proxy
CMD ["/opt/acestream.engine/start.sh"]

