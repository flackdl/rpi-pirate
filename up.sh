#! /bin/bash

services=$@

docker-compose up -d -t 120 $services

