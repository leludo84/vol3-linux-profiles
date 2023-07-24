FROM centos:7

RUN yum install lsb yum-utils -y
RUN yum-config-manager --enable base-debuginfo

COPY ../dwarf2json ../profilator-alma.sh /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh

