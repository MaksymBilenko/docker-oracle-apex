docker-apex
============================
[![Docker Repository on Quay](https://quay.io/repository/maksymbilenko/docker-oracle-apex/status "Docker Repository on Quay")](https://quay.io/repository/maksymbilenko/docker-oracle-apex)

Apex 5.1.2 upgrade package for quay.io/maksymbilenko/oracle-xe-11g and quay.io/maksymbilenko/oracle-12c

### Installation

    docker pull quay.io/maksymbilenko/docker-oracle-apex

Run this to upgrade APEX on you Oracle database container:

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database quay.io/maksymbilenko/docker-oracle-apex install
    #In that case build woud be with default settings and credentials

Run with custom parameters and credentials:

    docker run -it --rm --volumes-from ${DB_CONTAINER_NAME} --link ${DB_CONTAINER_NAME}:oracle-database -e PASS=SomePassWorD quay.io/maksymbilenko/docker-oracle-apex install

The default list of ENV variables is:

    USER=sys
    PASS=oracle
    HOST=oracle-database
    PORT=1521
    SID=XE
    HTTP_PORT=8080

Upgrade might take 10-20 Minutes (Depends on hardware).
