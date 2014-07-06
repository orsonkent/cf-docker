FROM cfd-rubybase:latest
MAINTAINER Orson Kent (orson@orsonkent.com)
ADD cloud_controller_ng /vcap/cloud_controller_ng
ADD config /vcap/config
RUN apt-get -y install libmysqlclient-dev libpq-dev libsqlite3-dev
RUN cd /vcap/cloud_controller_ng && bundle install
CMD /etc/init.d/ssh start && /var/vcap/cloud_controller_ng/bin/cloud_controller -c /vcap/config/cloud_controller.yml; /bin/bash

