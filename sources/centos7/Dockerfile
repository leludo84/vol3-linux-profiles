FROM centos:7

COPY centos7/CentOS-Base.repo /etc/yum.repos.d/ 
RUN yum install lsb yum-utils -y
RUN yum-config-manager --enable base-debuginfo

COPY ../dwarf2json ../profilator-alma.sh ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh

