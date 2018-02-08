FROM ubuntu:16.04
MAINTAINER <CloudToGo>

# COPY gitlab-ce_8.16.4-ce.0_amd64.deb /home/

RUN apt-get install curl openssh-server ca-certificates apt-transport-https ruby ruby-dev postfix && \
    wget https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu/pool/xenial/main/g/gitlab-ce/gitlab-ce_8.16.4-ce.0_amd64.deb && \
    dpkg -i gitlab-ce_8.16.4-ce.0_amd64.deb && \
    initctl start gitlab-runsvdir

#   apt-get install gitlab-ce=8.16.4-ce.0
#    cd /home && dpkg -i gitlab-ce_8.16.4-ce.0_amd64.deb && \

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

CMD ["gitlab-ctl", "reconfigure"]
