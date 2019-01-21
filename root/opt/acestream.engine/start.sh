#!/bin/sh

/opt/acestream.engine/start_acestream_chroot.sh >/dev/null 2>&1 &

/opt/hlsp/hls-proxy >/dev/null 2>&1 &

while true; do
        sleep 600
        rm -rf /opt/acestream.engine/androidfs/acestream.engine/.ACEStream/collected_torrent_files/*
done
