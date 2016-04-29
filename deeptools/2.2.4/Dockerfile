# INGM Bioinformatics
#
# DESCRIPTION: TCR analyse with TraCeR
# VERSION               1.0.0
# CREATE 2016-03-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y inotify-tools nano wget links curl rsync bc git git-core apt-transport-https libxml2 libxml2-dev libcurl4-openssl-dev openssl sqlite3 libsqlite3-dev gawk libreadline6-dev libyaml-dev autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev make m4 git build-essential software-properties-common

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-2.4.1-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-2.4.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-2.4.1-Linux-x86_64.sh

RUN /opt/conda/bin/conda config --add channels r
RUN /opt/conda/bin/conda config --add channels bioconda
RUN /opt/conda/bin/conda install -y deeptools=2.2.4

ENV PATH /opt/conda/bin:$PATH
ENV PYTHONPATH /opt/conda/pkgs
ENV LANG C.UTF-8

#ADD entrypoint.sh /usr/bin/

#ENTRYPOINT ["/usr/bin/entrypoint.sh"]

