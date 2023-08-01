FROM debian:12

# Installer les repos
#

RUN apt update && apt install lsb-release zutils aptitude -y

COPY ../dwarf2json ../profilator.sh ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator.sh


