# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of TopHat
# VERSION               2.1.0
# CREATE 2016-02-05

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python

RUN cd /opt &&\
    wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz &&\
    tar xzvf tophat-2.1.0.Linux_x86_64.tar.gz

ENV PATH /opt/tophat-2.1.0.Linux_x86_64/:$PATH
