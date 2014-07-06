FROM cfd-base:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
RUN apt-get update
RUN apt-get install -y ruby1.9.3 make ruby1.9.1-dev gcc g++ libpq-dev 

RUN gem install nats --pre
RUN gem install pg

ADD tests /vcap/tests

CMD /etc/init.d/ssh start && /vcap/tests/all.rb
