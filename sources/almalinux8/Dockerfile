FROM almalinux:8

RUN yum install lsb yum-utils -y
#RUN yum-config-manager --enable baseos-debuginfo 
ADD almalinux8/almalinux-debug.repo /etc/yum.repos.d/ 

COPY ../dwarf2json ../profilator-alma.sh ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh
