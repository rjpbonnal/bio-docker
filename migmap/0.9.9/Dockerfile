# INGM Bioinformatics
#
# DESCRIPTION Installation of migmap
# VERSION             0.9.9
# CREATION 2016-02-18

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python unzip


# Install Java 8
# source https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN cd /opt &&\
    wget "https://github.com/mikessh/migmap/releases/download/0.9.9/migmap-0.9.9.zip" && \
    unzip migmap-0.9.9.zip

RUN cd /opt && \
    wget ftp://ftp.ncbi.nih.gov/blast/executables/igblast/release/1.4.0/ncbi-igblast-1.4.0-x64-linux.tar.gz && \
    tar xzvf ncbi-igblast-1.4.0-x64-linux.tar.gz

ENV PATH /opt/migmap-0.9.9:/opt/ncbi-igblast-1.4.0/bin/:$PATH

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN chmod -R a+w /opt/migmap-0.9.9/data/
