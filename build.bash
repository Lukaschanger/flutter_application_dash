#!/bin/bash

flutter pub get 

flutter build web --web-renderer html --release

docker build --no-cache -t flutter-web-app .