# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of MACS2
# VERSION               2.1.0
# CREATE 2016-01-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-2.4.1-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-2.4.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-2.4.1-Linux-x86_64.sh

RUN cd /opt &&\
    wget -O macs2.tar.gz "https://pypi.python.org/packages/source/M/MACS2/MACS2-2.1.0.20150731.tar.gz" && \
    tar xzvf macs2.tar.gz

RUN cd /opt/MACS2-2.1.0.20150731 && \
    PYTHONPATH=/opt/conda/pkgs /opt/conda/bin/python setup.py install 

ENV PATH /opt/conda/bin:$PATH
ENV PYTHONPATH /opt/conda/lib/python2.7/site-packages:/opt/conda/pkgs:$PYTHONPATH

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.bashrc
#RUN echo 'PATH=/opt/cufflinks-2.2.1.Linux_x86_64/:$PATH' >> /root/.profile

#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
