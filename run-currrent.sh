#/bin/bash

while true
do
	update_global_banners=0
	for distrib in centos8 almalinux8 almalinux9 almalinux10 ubuntu16 ubuntu18 ubuntu20 ubuntu22 ubuntu24 debian-snapshot
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
		git pull
		git diff --exit-code ./profiles/$distrib || update_global_banners=1
		git add ./profiles/$distrib
		git commit -m"Add new $distrib vol3 profiles batch." ./profiles/$distrib
		git push
	done
	if [ "$update_global_banners" = "1" ]
	then
		echo "################################"
		echo " Update global banners files"
		echo "################################"
		./make-banners.sh profiles/
		./bannersToISF.py
		git commit -m"Banners updates" banners.ndjson banners-isf.json
		git push
	fi

	echo "Sleeping for a long time ....."
	sleep 43200
done

