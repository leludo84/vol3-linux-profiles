#!/bin/bash

START=all
END=all
DEST=./profiles/debian-snapshot

test "$1" != "" && START="$1"
test "$2" != "" && END="$2"

docker run -it --rm -v $DEST:/root/profiles -e "START_VERSION=$START" -e "END_VERSION=$END" profilator-debian-snapshot

