#!/bin/bash

# Check state existence
if [ ! -e domain.state ]; then
    echo "Invalid domain.state"
    exit 1
fi

if [ ! -e bluegreen.state ]; then
    echo "Invalid bluegreen.state"
    exit 1
fi

if [ ! -e https.state ]; then
    echo "Invalid https.state"
    exit 1
fi

# Get domain
domain="$(cat domain.state)"

# Get inactive
if [ "xblue" == "x$(cat bluegreen.state)" ]; then
    inactive="green"
elif [ "xgreen" == "x$(cat bluegreen.state)" ]; then
    inactive="blue"
else
    echo "Invalid bluegreen.state"
    exit 1
fi

# Get https mode
if [ "xhttp" == "x$(cat https.state)" ]; then
    mode=http
elif [ "xhttps" == "x$(cat https.state)" ]; then
    mode=https
else
    echo "Invalid https.state"
    exit 1
fi

# Regenerate and reload config
if [ "x$mode" == "xhttp" ]; then
    ./create-http-server.sh $domain $inactive
else
    ./create-https-server.sh $domain $inactive
fi
./reload-config.sh
