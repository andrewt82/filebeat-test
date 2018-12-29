############################################################
# Dockerfile to nginx and filebeat services
# Based on centos
############################################################

# Set the base image to centos
FROM centos:centos7

# File Author / Maintainer
MAINTAINER TestName

# Update the repository
RUN yum -y update; yum clean all && \
    yum -y install initscripts && yum clean all && \
    yum -y install systemd; yum clean all && \
# Add the EPEL-Release yum repository, which will have NGINX for us
    yum -y install epel-release && \
    mkdir -p /etc/nginx/logs/
# Sets the working directory
WORKDIR filebeat

# Copy filebeat rpm package
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-x86_64.rpm

#Install filebeat rpm Package
RUN rpm -Uvh --nodeps filebeat-6.2.4-x86_64.rpm

COPY fcgi-server-access-1.log /etc/nginx/logs/
COPY filebeat.yml /etc/filebeat/
COPY start_filebeat.py .

# Environment variable to enable systemd for docker container
ENV container docker

# Creates a mount point for systemd
VOLUME [ "/sys/fs/cgroup" ]

# Run command to enable systemd
ENTRYPOINT python start_filebeat.py && exec /usr/sbin/init