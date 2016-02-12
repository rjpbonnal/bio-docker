# INGM Bioinformatics
#
# DESCRIPTION: Installation of eXpress
# VERSION               1.5.1
# CREATE: 2015-02-12

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python

RUN cd /opt && \ 
    wget http://bio.math.berkeley.edu/eXpress/downloads/express-1.5.1/express-1.5.1-linux_x86_64.tgz && \
    tar xzvf express-1.5.1-linux_x86_64.tgz

ENV PATH /opt/express-1.5.1-linux_x86_64:$PATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
