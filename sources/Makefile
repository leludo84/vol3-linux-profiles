IMAGES = debian-snapshot debian10 debian11 debian12 centos8 centos7 almalinux8 almalinux9 ubuntu16 ubuntu18 ubuntu20 ubuntu22 ubuntu24

build:
	$(foreach dist,$(IMAGES), docker build ./ -f $(dist)/Dockerfile -t profilator-$(dist) && ) true
	#docker build ./ -f centos6/Dockerfile -t profilator-centos6

