# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of StringTie
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python

RUN cd /opt &&\
    wget -O cutadapt-1.8.tar.gz "https://pypi.python.org/packages/source/c/cutadapt/cutadapt-1.8.tar.gz" && \
    tar xzvf cutadapt-1.8.tar.gz

ENV PATH /opt/cutadapt-1.8/bin:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
