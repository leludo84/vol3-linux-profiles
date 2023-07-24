#!/bin/bash
set -e -x

cd sources
docker build ./ -f centos8/Dockerfile -t profilator-centos8
docker build ./ -f centos7/Dockerfile -t profilator-centos7
docker build ./ -f centos6/Dockerfile -t profilator-centos6
docker build ./ -f almalinux8/Dockerfile -t profilator-almalinux8
docker build ./ -f almalinux9/Dockerfile -t profilator-almalinux9
docker build ./ -f ubuntu16/Dockerfile -t profilator-ubuntu16
docker build ./ -f ubuntu18/Dockerfile -t profilator-ubuntu18
docker build ./ -f ubuntu20/Dockerfile -t profilator-ubuntu20
docker build ./ -f ubuntu22/Dockerfile -t profilator-ubuntu22

