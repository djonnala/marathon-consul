FROM gliderlabs/alpine:edge
MAINTAINER Brian Hicks <brian@brianthicks.com>

RUN apk add --update ca-certificates bash
COPY launch.sh /launch.sh

COPY tmo.crt /usr/local/share/ca-certificates/

COPY . /go/src/github.com/CiscoCloud/marathon-consul
RUN apk add go libc-dev git mercurial \
	&& cd /go/src/github.com/CiscoCloud/marathon-consul \
	&& export GOPATH=/go \
	&& go get -t \
  && go test ./... \
	&& go build -o /bin/marathon-consul \
	&& apk del --purge go git mercurial

ENTRYPOINT ["/launch.sh"]
