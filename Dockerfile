FROM  python:3.9-alpine
LABEL maintainer="Roberto Melendez [https://github.com/rcmelendez/duologsync-docker]"

ARG   BUILD_DATE
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Duo Log Sync image" \
      org.label-schema.description="Python utility for fetching logs from Duo to feed Devo (or another SIEM)" \
      org.label-schema.version="2.0.0"

WORKDIR /usr/src/app

RUN apk update && apk upgrade \
    && apk add git \
    && git clone https://github.com/duosecurity/duo_log_sync.git

WORKDIR /usr/src/app/duo_log_sync

RUN python setup.py install

ENTRYPOINT ["duologsync"]
CMD ["--help"]
