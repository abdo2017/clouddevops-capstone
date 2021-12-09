#!/usr/bin/env bash


docker build -t clouddevops .


docker images

# running the app
docker run -p 80:80 clouddevops