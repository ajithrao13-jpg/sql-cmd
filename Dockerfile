FROM alpine:latest

RUN apk add --no-cache tar ca-certificates bzip2

COPY sqlcmd-linux-amd64.tar.bz2 /tmp/sqlcmd-linux-amd64.tar.bz2

RUN mkdir -p /opt/sqlcmd \
  && tar -xjf /tmp/sqlcmd-linux-amd64.tar.bz2 -C /opt/sqlcmd \
  && ln -s /opt/sqlcmd/sqlcmd /usr/local/bin/sqlcmd

ENV PATH="/opt/sqlcmd:${PATH}"

ENTRYPOINT ["sqlcmd"]
