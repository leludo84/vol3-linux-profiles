#!/bin/bash
set -e -x

# TESTING !!!!

# TODO: old versions

yum clean all
repoquery search kernel-debug-debuginfo* --qf '%{NAME};%{evr}' | while read line
do
	pkg=$(echo $line | cut -d\; -f1)
	version=$(echo $line | cut -d\; -f2)

	

	test -e ./profiles/kernel-$version\.json.xz && continue

	yum install -y $pkg-$version
        
	./dwarf2json linux --elf /usr/lib/debug/lib/modules/$version\.x86_64+debug/vmlinux > /tmp/kernel-$version\.json
	xz /tmp/kernel-$version\.json

	yum remove kernel-debuginfo-common kernel-debug-debuginfo -y

        mv /tmp/kernel-$version\.json.xz profiles/
done

