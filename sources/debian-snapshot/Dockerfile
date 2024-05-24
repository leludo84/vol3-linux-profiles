FROM debian:12

# Installer les repos
#

RUN apt update && apt install zutils binutils python3 python3-requests python3-apt wget vim -y

COPY ../dwarf2json ../profilator-debsnapshot.sh ../profilator-debsnapshot.py ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

ENV START_VERSION=4
ENV END_VERSION=all

CMD cd /root && ./profilator-debsnapshot.py

