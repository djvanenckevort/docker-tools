# OpenLDAP 
# 
# VERSION 0.0.2 
# 
# 0.0.1 : initial creation of image with OpenLdap based von debian:jessie
# 0.0.2 : second attempt of initial creation of image with OpenLdap based von debian:jessie

FROM debian:jessie 

MAINTAINER Robert Reihs <robert.reihs@gmail.com>

RUN apt-get update \
    && apt-get -y upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y slapd \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y ldap-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD scripts /opt/scripts
WORKDIR /opt/scripts
RUN chmod a+x *.sh

ENTRYPOINT ["/opt/scripts/entrypoint.sh"]
