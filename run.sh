#/bin/bash


while true
do
	for $distrib in ubuntu16 ubuntu18 ubuntu20 ubuntu22
	do
		docker run -it --rm -v ./profiles/$distrib:/root/profiles profilator-$distrib
	done

	git add ./profiles
	git commit -m"Add new profiles batch." ./profiles
	git push
	echo "Sleep for a long time ....."
	sleep 1000
done

