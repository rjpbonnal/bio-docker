
# INGM Bioinformatics
#
# DESCRIPTION DeNovoHuman Installation of Java Genomics Toolkit
# VERSION             12.10.18
# CREATION 2016-02-19

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common


# Install Java 7
# source https://github.com/dockerfile/java/blob/master/oracle-java7/Dockerfile
RUN \
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk7-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

RUN cd /opt && \
    wget https://github.com/downloads/timpalpant/java-genomics-toolkit/jgt-20121018.linux64.tar.gz && \
    tar xzvf jgt-20121018.linux64.tar.gz

ENV PATH /opt/java_genomics_toolkit:$PATH

ENTRYPOINT ["/opt/java_genomics_toolkit/toolRunner.sh"]
