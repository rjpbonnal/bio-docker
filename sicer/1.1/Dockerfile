# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of sicer
# VERSION               1.1
# CREATE 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python


RUN cd /opt &&\
    wget http://home.gwu.edu/~wpeng/SICER_V1.1.tgz && \
    tar xzvf SICER_V1.1.tgz

RUN chmod 755 /opt/SICER_V1.1/SICER/SICER.sh


ENV PATH /opt/SICER_V1.1/SICER:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
