#!/bin/bash

# Give server time to boot, then setup proxy on port 9091
if [[ ! -z $UPSTREAM_PROXY ]]; then
    UPSTREAM_PARAMS="&httpProxy=$UPSTREAM_PROXY&httpsProxy=$UPSTREAM_PROXY"
fi
(sleep 3 && curl -sSX POST -d "port=9091&bindAddress=$(cat /etc/hosts | grep $(hostname) | cut -f1)${UPSTREAM_PARAMS}" http://0.0.0.0:9090/proxy) &

exec /browsermob-proxy-2.0-beta-9/bin/browsermob-proxy -port 9090
