#/bin/bash

while true
do
	for distrib in centos7 centos8 almalinux8 almalinux9 debian10 debian11 debian12 ubuntu16 ubuntu18 ubuntu20 ubuntu22
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
		git pull
		git add ./profiles/$distrib
		git commit -m"Add new $distrib vol3 profiles batch." ./profiles
		git push
	done

	echo "Sleep for a long time ....."
	sleep 20000
done

