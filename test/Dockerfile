FROM cf-d-base:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
RUN apt-get install -y ruby1.9.3 make

RUN gem install cucumber

ADD tests /home/foundry/tests

