FROM cfd-base:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
ADD cloud_controller_ng /vcap/cloud_controller_ng
ADD config /vcap/config
RUN apt-get -y install ruby ruby-bundler git 
RUN apt-get -y install libmysql-ruby libmysqlclient-dev
RUN cd /vcap/cloud_controller_ng && bundle install
