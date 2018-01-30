FROM ubuntu:14.04
MAINTAINER <CloudToGo>

# Install required packages
RUN apt-get update
RUN apt-get install -y curl openssh-server ca-certificates
RUN apt-get install -y postfix
RUN curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
RUN apt-get install gitlab-ce=8.16.4-ce.0

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]
