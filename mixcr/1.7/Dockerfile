# INGM Bioinformatics
#
# DESCRIPTION Installation of MIXCR
# VERSION             1.7
# CREATION 2016-02-10

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

RUN apt-get update && apt-get install -y golang git libxml2-utils

RUN cd /opt &&\
    wget "https://github.com/milaboratory/mixcr/releases/download/v1.7/mixcr-1.7.zip" && \
    unzip mixcr-1.7.zip

RUN mkdir /opt/go

RUN GOPATH=/opt/go go get github.com/ericchiang/pup

ENV PATH /opt/mixcr-1.7:/opt/go/bin:$PATH

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
