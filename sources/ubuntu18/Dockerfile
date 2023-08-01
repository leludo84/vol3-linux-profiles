FROM ubuntu:18.04

# Installer les repos
#

RUN apt update && apt install lsb-release ubuntu-dbgsym-keyring zutils aptitude -y
RUN echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse"           >  /etc/apt/sources.list.d/ddebs.list \
    && echo "deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse"   >> /etc/apt/sources.list.d/ddebs.list \
    && echo "deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse"  >> /etc/apt/sources.list.d/ddebs.list

COPY ../dwarf2json ../profilator.sh ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator.sh


