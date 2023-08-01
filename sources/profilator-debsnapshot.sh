#!/bin/bash
set -e -x

test "$1" = "" && exit 1
test "$2" = "" && exit 1

pkg=$1
url=$2


file=${pkg%\.deb}.json
file_xz=$file\.xz

# Test if exist
test -e profiles/$file_xz && exit 0

# Clean all
rm -f *.deb
rm -rf tmp

# Processing
wget "$url"
mkdir tmp
cd tmp

ar -x ../$pkg
test -e data.tar.xz  && tar -xJf data.tar.xz ./usr/lib/debug/boot/
test -e data.tar.gz  && tar -xzf data.tar.gz ./usr/lib/debug/boot/
test -e data.tar.bz2 && tar -xjf data.tar.bz2 ./usr/lib/debug/boot/

../dwarf2json linux --elf ./usr/lib/debug/boot/vmlinux-* > $file
xz $file

mv $file_xz ../profiles/

