# INGM Bioinformatics
#
# DESCRIPTION: Installation of gffcompare form github
# VERSION               0.9.6f
# CREATE 2016-04-29

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python git

RUN cd /opt &&\
    wget https://github.com/gpertea/gffcompare/archive/v0.9.6f.tar.gz && \
    git clone https://github.com/gpertea/gclib && \
    tar xzvf v0.9.6f.tar.gz && \
    cd gffcompare-0.9.6f && \
    make release

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/gffcompare-0.9.6f/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/gffcompare-0.9.6f/:$PATH' >> /root/.profile
ENV PATH "/opt/gffcompare-0.9.6f:$PATH"
#COPY README.md /README.md

ENTRYPOINT ["/sbin/entrypoint.sh"]
