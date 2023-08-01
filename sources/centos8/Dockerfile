FROM centos:8

RUN rm -f /etc/yum.repos.d/* && yum clean all
COPY centos8/repos.repo /etc/yum.repos.d/

RUN yum install yum-utils -y

COPY ../dwarf2json ../profilator-alma.sh ../banner.py /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh

