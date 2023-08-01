FROM debian:12

# Installer les repos
#

RUN apt update && apt install zutils binutils python3 python3-requests python3-packaging wget vim -y

COPY ../dwarf2json ../profilator-debsnapshot.sh ../profilator-debsnapshot.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

ENV START_VERSION=all
ENV END_VERSION=all

CMD cd /root && ./profilator-debsnapshot.py

