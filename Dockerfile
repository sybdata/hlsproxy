FROM alpine:3.7
			

# install packages and symlink libs
RUN \
 apk add --no-cache \
  wget \
  unzip \
	nano \
	mc && \
 mkdir -p \
	/opt/tv && \
	
 # install hlsproxy
 wget -o - https://916.s50.online/tv/hls-proxy-3.6.4.linux-x64.zip -O hlsproxy.zip && \
 unzip hlsproxy.zip -d /opt/tv && \

# cleanup
 rm -rf \
	/tmp/*

# ports and volumes
EXPOSE 8060
