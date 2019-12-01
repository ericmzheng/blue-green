#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Invalid number of arguments"
    exit 1
fi

domain="$1"

if [ "$2" == "blue" ]; then
    active="blue"
    inactive="green"
elif [ "$2" == "green" ]; then
    active="green"
    inactive="blue"
else
    echo "Second argument must be 'blue' or 'green'"
    exit 1
fi

mkdir -p nginx
echo "
    server {
        listen 80;
        server_name $domain;

        location / {
            try_files \$uri @app;
        }

        location @app {
            include uwsgi_params;
            uwsgi_pass $active:5000;
        }
    }

    server {
        listen 28378;
        server_name $domain;

        location / {
            try_files \$uri @app;
        }

        location @app {
            include uwsgi_params;
            uwsgi_pass $inactive:5000;
        }
    }
" > nginx/app.conf

echo "$1" > domain.state
echo "$2" > bluegreen.state
echo "http" > https.state

