FROM almalinux:9

RUN yum install yum-utils -y
#RUN yum-config-manager --enable baseos-debuginfo 
ADD almalinux9/almalinux-debug.repo /etc/yum.repos.d/ 

COPY ../dwarf2json ../profilator-alma.sh /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh
