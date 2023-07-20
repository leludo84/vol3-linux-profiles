#!/bin/bash

cd sources
docker build ./ -f ubuntu16/Dockerfile -t profilator-ubuntu16
docker build ./ -f ubuntu18/Dockerfile -t profilator-ubuntu18
docker build ./ -f ubuntu20/Dockerfile -t profilator-ubuntu20
docker build ./ -f ubuntu22/Dockerfile -t profilator-ubuntu22

