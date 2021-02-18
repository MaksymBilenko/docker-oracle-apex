docker-apex
============================
[![Docker Repository on Quay](https://quay.io/repository/maksymbilenko/docker-oracle-apex/status "Docker Repository on Quay")](https://quay.io/repository/maksymbilenko/docker-oracle-apex)

Apex 4.2.6 upgrade package for sath89/oracle-xe-11g and sath89/oracle-12c

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/sath89/apex/) of [Docker Registry](https://registry.hub.docker.com/).

### Installation

    docker pull quay.io/maksymbilenko/docker-oracle-apex:4.2.6

Run this to upgrade APEX on you Oracle database container:

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database quay.io/maksymbilenko/docker-oracle-apex:4.2.6 install
    #In that case build woud be with default settings and credentials

Run with custom parameters and credentials:

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database -e PASS=SomePassWorD quay.io/maksymbilenko/docker-oracle-apex:4.2.6 install

The default list of ENV variables is:

    USER=sys
    PASS=oracle
    HOST=oracle-database
    PORT=1521
    SID=XE
    HTTP_PORT=8080

Upgrade might take 10-20 Minutes (Depends on hardware).
