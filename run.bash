#! /bin/bash

docker build --no-cache -t flutter-web-app .

docker run -p "80:80" flutter-web-app 