#!/bin/sh
docker build . -t prikkeduden && docker run -p 80:80 prikkeduden
