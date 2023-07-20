FROM ubuntu:20.04

# Installer les repos
#

RUN apt update && apt install lsb-release ubuntu-dbgsym-keyring -y
RUN echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse \
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse \
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
tee -a /etc/apt/sources.list.d/ddebs.list

COPY ../dwarf2json ../profilator.sh /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator.sh


