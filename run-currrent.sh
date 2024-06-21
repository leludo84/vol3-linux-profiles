#/bin/bash

while true
do
	for distrib in centos8 almalinux8 almalinux9 debian10 debian11 debian12 ubuntu16 ubuntu18 ubuntu20 ubuntu22 ubuntu24 debian-snapshot
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
		git pull
		git add ./profiles/$distrib
		git commit -m"Add new $distrib vol3 profiles batch." ./profiles/$distrib
		git push
	done

	echo "Sleep for a long time ....."
	sleep 20000
done

