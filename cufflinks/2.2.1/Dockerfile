# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of Cufflinks
# VERSION               2.2.1
# CREATE 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python

RUN cd /opt &&\
    wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz &&\
    tar xzvf cufflinks-2.2.1.Linux_x86_64.tar.gz

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

COPY README.md /README.md

ENTRYPOINT ["/sbin/entrypoint.sh"]
