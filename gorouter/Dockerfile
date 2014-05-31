FROM ubuntu:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
RUN apt-get update
RUN apt-get install -y ssh
RUN mkdir /var/run/sshd 
RUN echo 'root:foundry' |chpasswd
EXPOSE 22
CMD /usr/sbin/sshd -D