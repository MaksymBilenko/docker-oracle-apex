docker-apex
============================
[![](https://badge.imagelayers.io/sath89/apex:latest.svg)](https://imagelayers.io/?images=sath89/apex:latest 'Get your own badge on imagelayers.io')

Apex 5.1.2 upgrade package for sath89/oracle-xe-11g and sath89/oracle-12c

This **Dockerfile** is a [trusted build](https://registry.hub.docker.com/u/sath89/apex/) of [Docker Registry](https://registry.hub.docker.com/).

### Installation

    docker pull sath89/apex

Run this to upgrade APEX on you Oracle database container:

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database sath89/apex install
    #In that case build woud be with default settings and credentials

Run with custom parameters and credentials:

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database -e PASS=SomePassWorD sath89/apex install

The default list of ENV variables is:

    USER=sys
    PASS=oracle
    HOST=oracle-database
    PORT=1521
    SID=XE
    HTTP_PORT=8080

Upgrade might take 10-20 Minutes (Depends on hardware).
