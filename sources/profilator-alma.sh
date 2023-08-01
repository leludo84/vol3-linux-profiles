#!/bin/bash
set -e -x

ARCH=$(uname -p)

python=python
test -e /usr/bin/python3 && python=python3

yum clean all
repoquery search kernel-debuginfo --qf '%{VERSION}-%{RELEASE}' --show-duplicates | while read version
do
	test -e ./profiles/kernel-$version\.$ARCH\.json.xz && continue

	yum install -y kernel-debuginfo-$version
        
	./dwarf2json linux --elf /usr/lib/debug/lib/modules/$version\.$ARCH/vmlinux > /tmp/kernel-$version\.$ARCH\.json
	$python ./banner.py /tmp/kernel-$version\.$ARCH\.json > /tmp/banner.json
	xz /tmp/kernel-$version\.$ARCH\.json

	yum remove kernel-debuginfo-common kernel-debuginfo -y

        mv /tmp/kernel-$version\.$ARCH\.json.xz profiles/
	cat /tmp/banner.json >> profiles/banners.json
done

