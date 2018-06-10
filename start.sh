#!/bin/bash

/opt/acestream/start-engine --client-console --bind-all --access-token $1 --live-cache-type memory --allow_remote_access --state-dir /tmp/state/.ACEStream --cache-dir /tmp/state/.ACEStream --live-cache-size 524288000 --core-sandbox-max-peers 15 --live-buffer 25 --vod-buffer 10 --vod-drop-max-age 120 --stats-report-peers --port 9944 --service-remote-access --log-file /tmp/acestream.log >/dev/null 2>&1 &

/opt/hlsp/hls-proxy >/dev/null 2>&1 &

while true; do
        sleep $2
        rm -rf /tmp/state/.ACEStream/.acestream_cache/* /tmp/state/.ACEStream/collected_torrent_files/*
done
