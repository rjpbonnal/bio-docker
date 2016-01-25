# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of bcftools
# VERSION               1.2
# CREATE: 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python
RUN apt-get install -y bzip2


RUN cd /opt &&\
    wget "https://github.com/samtools/bcftools/releases/download/1.2/bcftools-1.2.tar.bz2" && \
    tar xjvf bcftools-1.2.tar.bz2 && \
    cd bcftools-1.2 && \
    make && \
    make install

#ENV PATH /opt/bedtools2/bin:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
