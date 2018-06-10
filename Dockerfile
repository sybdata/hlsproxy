FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive LANG=ru_RU.UTF-8 LANGUAGE=ru_RU:ru LC_ALL=ru_RU.UTF-8
WORKDIR /tmp

# set ports
EXPOSE 8621 62062 9944 6878 8048

RUN \
apt-get update && apt-get upgrade -y && \
apt-get update -y && \
apt-get install -y \
build-essential \
python-dev \
python2.7 \
gcc \
curl \
python-libxslt1 \
wget \
git \
mc \
nano \
net-tools \
iputils-ping \
tzdata \
locales \
htop && \
# Set the locale
locale-gen ru_RU.UTF-8 && \
wget http://launchpadlibrarian.net/229774470/python-m2crypto_0.22.6~rc4-1ubuntu1_amd64.deb && \
dpkg -i python-m2crypto_0.22.6~rc4-1ubuntu1_amd64.deb && \
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
python get-pip.py && \
pip install --upgrade psutil && \
pip install --user https://github.com/rogerbinns/apsw/releases/download/3.23.1-r1/apsw-3.23.1-r1.zip --global-option=fetch --global-option=--version --global-option=3.23.1 --global-option=--all --global-option=build --global-option=--enable-all-extensions && \
pip install setuptools cffi 'cython>=0.27' git+git://github.com/gevent/gevent.git#egg=gevent && \
apt-get purge git python-dev gcc build-essential -y && \
apt-get autoremove -y && \

#acestream
wget -o - http://dl.acestream.org/linux/acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
tar -zxvf acestream_3.1.16_ubuntu_16.04_x86_64.tar.gz && \
mv acestream_3.1.16_ubuntu_16.04_x86_64 /opt/acestream && \

# install hlsproxy
wget -o - https://sybdata.de/files/public-docs/hls-proxy-4.8.1.linux-x64.zip -O hlsproxy.zip && \
unzip hlsproxy.zip -d /opt/hlsp/ && \

# set /tmp on tmpfs
echo "tmpfs /tmp tmpfs rw,nosuid,nodev 0 0" | tee -a /etc/fstab && \

# clean up
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/acestream/data/plugins/* \
/usr/share/man /usr/share/groff /usr/share/info \
/usr/share/lintian /usr/share/linda /var/cache/man /usr/share/doc/*
ADD /start.sh /start.sh
ADD /default.json /opt/hlsp/default.json
RUN chmod +x /start.sh
RUN chmod +x /opt/hlsp/hls-proxy
WORKDIR /
