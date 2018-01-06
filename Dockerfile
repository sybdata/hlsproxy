FROM debian:stable-slim
			

# install packages
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /tmp
RUN apt-get update -y && \
    apt-get install -y \
    wget \
    unzip \
    nano \
    mc && \
    mkdir -p opt/tv && \
	
 # install hlsproxy
 wget -o - https://916.s50.online/tv/hls-proxy-4.1.2.linux-x64.zip -O hlsproxy.zip && \
 unzip hlsproxy.zip -d /opt/tv && \

RUN chmod +x /opt/tv/hls-proxy
ADD local.json /opt/tv/local.json
RUN rm -rf /tmp/*
WORKDIR /

# ports and volumes
EXPOSE 8060
