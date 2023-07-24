#/bin/bash

while true
do
	for distrib in centos6 centos7 almalinux8 almalinux9 ubuntu16 ubuntu18 ubuntu20 ubuntu22
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
		git add ./profiles/$distrib
		git commit -m"Add new $distrib vol3 profiles batch." ./profiles
		git push
	done

	echo "Sleep for a long time ....."
	sleep 20000
done

