FROM ubuntu:16.04
MAINTAINER <CloudToGo>

# COPY gitlab-ce_8.16.4-ce.0_amd64.deb /home/

RUN apt-get install curl 
RUN apt-get install openssh-server 
RUN apt-get install ca-certificates 
RUN apt-get install apt-transport-https 
RUN apt-get install ruby 
RUN apt-get install ruby-dev 
RUN apt-get install postfix
RUN wget https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/pool/xenial/main/g/gitlab-ce/gitlab-ce_8.16.4-ce.0_amd64.deb
RUN dpkg -i gitlab-ce_8.16.4-ce.0_amd64.deb
RUN initctl start gitlab-runsvdir

#   apt-get install gitlab-ce=8.16.4-ce.0
#    cd /home && dpkg -i gitlab-ce_8.16.4-ce.0_amd64.deb && \

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

CMD ["gitlab-ctl", "reconfigure"]
