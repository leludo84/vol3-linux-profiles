FROM debian:11

# Installer les repos
#

RUN apt update && apt install lsb-release zutils aptitude -y

COPY ../dwarf2json ../profilator.sh /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator.sh


