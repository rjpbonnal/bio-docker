# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of StringTie
# VERSION               0.0.1
# CREATE 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python

RUN cd /opt &&\
    wget -O bedtools-2.24.0.tar.gz "https://github.com/arq5x/bedtools2/releases/download/v2.24.0/bedtools-2.24.0.tar.gz" && \
    tar xzvf bedtools-2.24.0.tar.gz

RUN cd /opt/bedtools2 && \
    make 

ENV PATH /opt/bedtools2/bin:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
