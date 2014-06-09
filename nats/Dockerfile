FROM cfd/gobase:latest
MAINTAINER Orson Kent (orson@orsonkent.com)

ADD gnatsd /go/src/github.com/apcera/gnatsd

EXPOSE 4222

RUN go install github.com/apcera/gnatsd

ADD config /vcap/config
CMD /etc/init.d/ssh start && cd /go/src/github.com/apcera/gnatsd && go run gnatsd.go -c /vcap/config/gnatsd.conf & /bin/bash
