#!/usr/bin/env bash

docker build -t greetings .
docker run greetings rake spec