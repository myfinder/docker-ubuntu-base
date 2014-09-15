FROM ubuntu:trusty
MAINTAINER myfinder medianetworks at gmail.com

ENV DEBIAN_FRONTEND noninteractive

# update and upgrade
RUN apt-get update && apt-get -y upgrade

# install basic packages
RUN apt-get -y install curl git nginx npm supervisor daemontools daemontools-run redis-server redis-tools mysql-client mysql-server mysql-common libmysqlclient-dev expat libexpat1-dev

# install fluentd
RUN curl -O http://packages.treasure-data.com/debian/RPM-GPG-KEY-td-agent && apt-key add RPM-GPG-KEY-td-agent && rm RPM-GPG-KEY-td-agent
RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh

# install perl
ENV PLENV_ROOT /opt/perl5
RUN mkdir -p /opt/perl5
RUN git clone git://github.com/tokuhirom/plenv.git ${PLENV_ROOT}
RUN git clone git://github.com/tokuhirom/Perl-Build.git ${PLENV_ROOT}/plugins/perl-build/
RUN ${PLENV_ROOT}/bin/plenv install 5.18.2
RUN ${PLENV_ROOT}/bin/plenv rehash
RUN ${PLENV_ROOT}/bin/plenv global 5.18.2 
RUN ${PLENV_ROOT}/bin/plenv install-cpanm
RUN ${PLENV_ROOT}/bin/plenv rehash
RUN ${PLENV_ROOT}/bin/plenv exec cpanm Carton
