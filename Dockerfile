FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp

# set ports
EXPOSE 8621 62062 9944 6878 8048

RUN \
apt-get update && apt-get upgrade -y && \
apt-get update -y && \
apt-get install -y \
wget \
mc \
nano \
tzdata \
htop && \
apt-get autoremove -y && \

#acestream
mkdir -p /opt/acestream/ && \
wget -o - https://sybdata.de/files/public-docs/acestream_3.1.31_webUI_x86.tar.gz && \
tar -zxvf acestream_3.1.31_webUI_x86.tar.gz && \
mv androidfs /opt/acestream/androidfs && \
find /opt/acestream/androidfs/system -type d -exec chmod 755 {} \; && \
find /opt/acestream/androidfs/system -type f -exec chmod 644 {} \; && \
chmod 755 /opt/acestream/androidfs/system/bin/* /opt/acestream/androidfs/acestream.engine/python/bin/python && \

# install hlsproxy
wget -o - https://sybdata.de/files/public-docs/hls-proxy-5.0.2.linux-x64.zip -O hlsproxy.zip && \
unzip hlsproxy.zip -d /opt/hlsp/ && \

# set /tmp on tmpfs
echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*
ADD /start.sh /start.sh
ADD /default.json /opt/hlsp/default.json
ADD acestream.start /opt/acestream/acestream.start
ADD acestream.start /opt/acestream/acestream.stop
RUN chmod +x /start.sh
RUN chmod +x /opt/acestream/acestream.start
RUN chmod +x /opt/acestream/acestream.stop
RUN chmod +x /opt/hlsp/hls-proxy
WORKDIR /
