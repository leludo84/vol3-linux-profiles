#/bin/bash

while true
do
	update_global_banners=0
	for distrib in centos8 almalinux8 almalinux9 debian10 debian11 debian12 ubuntu16 ubuntu18 ubuntu20 ubuntu22 ubuntu24 debian-snapshot
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
		git pull
		git add ./profiles/$distrib
		git diff --exit-code ./profiles/$distrib || update_global_banners=1
		git commit -m"Add new $distrib vol3 profiles batch." ./profiles/$distrib
		git push
	done
	if [ "$update_global_banners" = "1" ]
	then
		# Update global banners files
		./make-banners.sh profiles/
		./bannersToISL.py
		git commit -m"Banners updates" banners.ndjson banners-isl.json
		git push

	fi

	echo "Sleep for a long time ....."
	sleep 20000
done

