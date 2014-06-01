FROM ubuntu:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
# Set up the basics
RUN apt-get update
RUN apt-get install -y ssh vim ansible 
RUN mkdir /var/run/sshd
# Add out standard user
RUN useradd -d /home/foundry -m -p awesome -s /bin/bash foundry
# And configure passwordless between the containers
ADD ssh /home/foundry/.ssh
RUN chown -R foundry:foundry /home/foundry/.ssh/
RUN chmod 700 /home/foundry/.ssh
RUN chmod 600 /home/foundry/.ssh/*
# and make ssh available.
EXPOSE 22
RUN mkdir /vcap/
CMD /usr/sbin/sshd -D
