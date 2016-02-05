# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of TopHat
# VERSION               2.1.0
# CREATE 2016-02-05

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python unzip

RUN cd /opt &&\
    wget https://ccb.jhu.edu/software/tophat/downloads/tophat-2.1.0.Linux_x86_64.tar.gz &&\
    tar xzvf tophat-2.1.0.Linux_x86_64.tar.gz

RUN wget -O bowtie2-2.2.6-linux-x86_64.zip "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.6/bowtie2-2.2.6-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie2%2F2.2.6%2F&ts=1453458192&use_mirror=netcologne" && \
   unzip bowtie2-2.2.6-linux-x86_64.zip && \
   mv bowtie2-2.2.6 /opt/

ENV PATH /opt/tophat-2.1.0.Linux_x86_64:/opt/bowtie2-2.2.6:$PATH
