#!/bin/bash
set -e -x

ARCH=$(uname -p)

yum clean all
repoquery search kernel-debuginfo --qf '%{VERSION}-%{RELEASE}' --show-duplicates | while read version
do
	test -e ./profiles/kernel-$version\.$ARCH\.json.xz && continue

	yum install -y kernel-debuginfo-$version
        
	./dwarf2json linux --elf /usr/lib/debug/lib/modules/$version\.$ARCH/vmlinux > /tmp/kernel-$version\.$ARCH\.json
	xz /tmp/kernel-$version\.$ARCH\.json

	yum remove kernel-debuginfo-common kernel-debuginfo -y

        mv /tmp/kernel-$version\.$ARCH\.json.xz profiles/
done

