# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of StringTie
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common python


ADD https://github.com/alexdobin/STAR/archive/2.5.1a.tar.gz /opt/

RUN cd /opt && \
    tar xzvf 2.5.1a.tar.gz && \
    cd STAR-2.5.1a && \
    make STAR

#RUN cd /opt &&\
#    wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz &&\
#    tar xzvf cufflinks-2.2.1.Linux_x86_64.tar.gz

#COPY entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh

ENV PATH /opt/STAR-2.5.1a/source/:$PATH
#COPY README.md /README.md

#ENTRYPOINT ["/sbin/entrypoint.sh"]
