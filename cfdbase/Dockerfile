FROM ubuntu:latest
MAINTAINER Orson Kent (orson@orsonkent.com)

# Set up the basics
RUN apt-get update
RUN apt-get install -y ssh vim ansible 
RUN mkdir /var/run/sshd

# Add our standard user

RUN addgroup foundry
RUN useradd -d /home/foundry -g users -G sudo -m -s /bin/bash foundry

# And configure passwordless between the containers
ADD ssh /home/foundry/.ssh
RUN chown -R foundry:foundry /home/foundry/.ssh/
RUN chmod 700 /home/foundry/.ssh
RUN chmod 600 /home/foundry/.ssh/authorized_keys

# and make ssh available.
EXPOSE 22
RUN mkdir /vcap/
CMD /usr/sbin/sshd -D


