FROM cloudtogo/gitlab-ce:8.16.4.1
MAINTAINER <CloudToGo>

# COPY gitlab-ce_8.16.4-ce.0_amd64.deb /home/

RUN gitlab-ctl reconfigure

#   apt-get install gitlab-ce=8.16.4-ce.0
#    cd /home && dpkg -i gitlab-ce_8.16.4-ce.0_amd64.deb && \

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]
