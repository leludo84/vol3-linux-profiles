#!/bin/bash
set -e -x

OS=$(lsb_release -is)
VERSION=$(lsb_release -rs)
ARCH=$(uname -m)

if [ "$OS" = "Ubuntu" ]
then
        filter="dbgsym"
else
        filter="dbg"
fi

python=python
test -e /usr/bin/python3 && python=python3

#linux-image-6.1.0-10-amd64-dbg/stable 6.1.38-1 amd64
apt update -o Acquire::Check-Valid-Until=false

# Get all versions
apt list -a | grep linux-image-.*-$filter/ | grep -v kvm > version.txt

# Get all packages
aptitude -F "%p;%I;%V" search linux-image-.*-$filter | tr -d ' ' |  grep -v kvm | while read line
do
        echo $line
        pkg=$(echo $line | cut -d\; -f1)
        size=$(echo $line | cut -d\; -f2)

        # Paquet ne contenant pas de noyau
        echo $size | grep -E -e "[0-9]B" -e "kB" -e "KB" && continue || true

        for version in $(grep $pkg/ version.txt | cut -f2 -d\  )
        do
                file=$pkg\_$version\_$ARCH\.json
                file_xz=$file\.xz

                # Paquet déj�|  traité
                test -e profiles/$file_xz && continue

                apt install $pkg=$version -y
                ./dwarf2json linux --elf /usr/lib/debug/boot/vmlinux-* > /tmp/$file
                $python ./banner.py /tmp/$file > /tmp/banner.json
		xz /tmp/$file

                apt remove $pkg -y
                apt autoremove -y
                apt clean

                mv /tmp/$file_xz profiles/
		cat /tmp/banner.json >> profiles/banners.json
        done
done

