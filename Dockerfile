FROM alpine:latest

RUN apk add --no-cache tar ca-certificates \
  && apk add --no-cache --virtual .build-deps curl
  
COPY sqlcmd-linux.tar.gz /tmp/sqlcmd-linux.tar.gz

RUN mkdir -p /opt/sqlcmd \
  && tar -xzf /tmp/sqlcmd-linux.tar.gz -C /opt/sqlcmd \
  && ln -s /opt/sqlcmd/sqlcmd /usr/local/bin/sqlcmd

# RUN apk --no-cache add libc6-compat

ENV PATH="/opt/sqlcmd:${PATH}"

ENTRYPOINT ["sqlcmd"]
