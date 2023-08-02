#!/bin/bash

START=all
END=all

test "$1" != "" && START="$1"
test "$2" != "" && END="$2"

while true
do
	docker run -it --rm -v ./profiles/debian-snapshot:/root/profiles -e "START_VERSION=$START" -e "END_VERSION=$END" profilator-debian-snapshot
	echo sleeping ...
	sleep 3600
done
