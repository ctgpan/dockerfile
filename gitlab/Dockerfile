FROM ubuntu:14.04
MAINTAINER <CloudToGo>

# Install required packages
RUN apt-get install -y curl openssh-server ca-certificates && \
  apt-get install -y postfix && \
  curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash &&
  apt-get install gitlab-ce=8.16.4-ce.0

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]
