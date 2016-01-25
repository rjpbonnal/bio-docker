# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of FastQC
# VERSION               0.11.2
# CREATE 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python unzip

RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java7-installer

RUN cd /opt &&\
    wget -O fastqc.zip "http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.2.zip" && \
    unzip fastqc.zip

RUN cd /opt/FastQC && \
    chmod 755 fastqc

ENV PATH /opt/FastQC:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
