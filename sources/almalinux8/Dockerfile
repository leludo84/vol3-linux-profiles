FROM almalinux:8

RUN yum install lsb yum-utils -y
RUN yum-config-manager --enable baseos-debuginfo 

COPY ../dwarf2json ../profilator-alma.sh /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh
