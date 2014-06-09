FROM cfd/base:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
RUN apt-get install -y ruby1.9.3 make ruby1.9.1-dev gcc g++

RUN gem install nats --pre

ADD tests /vcap/tests

CMD /vcap/tests/all.rb

