#/bin/bash


while true
do
	for distrib in ubuntu18 ubuntu20 ubuntu22
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
		git add ./profiles/$distrib
	done

	git commit -m"Add new profiles batch." ./profiles
	git push
	echo "Sleep for a long time ....."
	sleep 1000
done

