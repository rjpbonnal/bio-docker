# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of vcftools
# VERSION               0.1.14
# CREATE 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python

RUN apt-get install -y pkg-config

RUN cd /opt &&\
    wget "https://github.com/vcftools/vcftools/releases/download/v0.1.14/vcftools-0.1.14.tar.gz" && \
    tar xzvf vcftools-0.1.14.tar.gz && \
    cd vcftools-0.1.14 && \
    ./configure && \
    make && \
    make install

#ENV PATH /opt/bedtools2/bin:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
