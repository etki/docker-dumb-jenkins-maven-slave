FROM maven:3
MAINTAINER Etki <etki@etki.name>

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y openssh-server
RUN useradd -m -d /var/jenkins -s /bin/bash jenkins
RUN echo 'jenkins:jenkins' | chpasswd
# shameless ripoff of evarga/jenkins-slave
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
