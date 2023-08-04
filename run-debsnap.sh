#!/bin/bash

START=all
END=all
DEST=./profiles/debian-snapshot

test "$1" != "" && START="$1"
test "$2" != "" && END="$2"
test "$3" != "" && DEST="$3"

while true
do
	docker run -it --rm -v $DEST:/root/profiles -e "START_VERSION=$START" -e "END_VERSION=$END" profilator-debian-snapshot
	echo sleeping ...
	sleep 3600
done
