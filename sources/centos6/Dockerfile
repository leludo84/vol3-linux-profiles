FROM centos:6

COPY centos6/CentOS-Base.repo /etc/yum.repos.d/
RUN yum install lsb yum-utils -y
RUN yum-config-manager --enable base-debuginfo 
# && yum-config-manager --enable 7.8.2003-base \ 
# && yum-config-manager --enable 7.8.2003-updates \
# && yum-config-manager --enable 7.8.2003-centosplus \
# && yum-config-manager --disable base \
# && yum-config-manager --disable updates \
# && yum-config-manager --disable extras

COPY ../dwarf2json ../profilator-alma.sh /root/
RUN chmod +x /root/* && mkdir /root/profiles

CMD cd /root && ./profilator-alma.sh
