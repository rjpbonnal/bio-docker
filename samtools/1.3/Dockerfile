# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of samtools
# VERSION               1.3

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python
RUN apt-get install -y bzip2
RUN apt-get install -y libncurses5-dev

RUN cd /opt &&\
    wget "https://github.com/samtools/samtools/releases/download/1.3/samtools-1.3.tar.bz2" && \
    tar xjvf samtools-1.3.tar.bz2 && \
    cd samtools-1.3 && \
    make && \
    make install

#ENV PATH /opt/bedtools2/bin:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
