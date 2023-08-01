FROM ubuntu:16.04

# Installer les repos
#

RUN apt update && apt install lsb-release zutils aptitude -y
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F2EDC64DC5AEE1F6B9C621F0C8CAB6595FDFF622
RUN echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse"		>  /etc/apt/sources.list.d/ddebs.list \
    && echo "deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse"	>> /etc/apt/sources.list.d/ddebs.list \
    && echo "deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse"	>> /etc/apt/sources.list.d/ddebs.list

COPY ../dwarf2json ../profilator.sh ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator.sh


