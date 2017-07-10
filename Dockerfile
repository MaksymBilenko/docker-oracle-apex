FROM ubuntu

MAINTAINER Maksym Bilenko <sath891@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LD_LIBRARY_PATH /instantclient_12_1
ENV USER sys
ENV PASS oracle
ENV HOST oracle-database
ENV PORT 1521
ENV SID XE
ENV HTTP_PORT 8080
ENV APEX_VERSION 5.1.2

RUN apt-get update && apt-get -y install libaio1 unzip && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ADD instantclient-* /tmp/
ADD apex* /apex_5.1.2/
ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
