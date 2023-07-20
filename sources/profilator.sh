#!/bin/bash
set -e -x

OS=$(lsb_release -is)
VERSION=$(lsb_release -rs)


apt update
apt -o apt::cmd::use-format=1 -o apt::cmd::format='${Package}' -qq search linux-image.*dbgsym | grep -v kvm | while read pkg
do
        echo $pkg

        # Paquet ne contenant pas de noyau
        size=$(apt show $pkg | grep "Installed-Size")
        echo $size | grep " B" && continue  || true
        echo $size | grep " kB" && continue || true
        echo $size | grep " KB" && continue || true

        # Paquet déjà traité
        test -e profiles/$pkg\.json && continue

        apt install $pkg -y

        ./dwarf2json linux --elf /usr/lib/debug/boot/* > /tmp/$pkg\.json

        apt remove $pkg -y
        apt autoremove -y
        apt clean

        mv /tmp/$pkg\.json profiles/$pkg\.json
done
