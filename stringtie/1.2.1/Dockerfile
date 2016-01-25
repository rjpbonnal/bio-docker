# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of StringTie
# VERSION               1.2.1
# CREATE 2015-10-01

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common unzip

ADD jellyfish-2.2.3.tar.gz /opt/

RUN cd /opt/jellyfish-2.2.3 &&\
    ./configure &&\
    make &&\
    make install

ADD superreads.pl /usr/local/bin/

ADD stringtie-1.2.1.tar.gz /opt/

RUN cd /opt/stringtie-1.2.1 &&\
    make release &&\
    cp stringtie /usr/local/bin/

RUN apt-get update --fix-missing && apt-get install -y bzip2 libbz2-dev

ADD /MaSuRCA-3.1.3.tar.gz /opt/

RUN cd /opt/MaSuRCA-3.1.3 &&\
    ./install.sh 

ADD https://ccb.jhu.edu/software/hisat2/downloads/hisat2-2.0.0-beta-Linux_x86_64.zip /opt/

RUN cd /opt &&\
    unzip hisat2-2.0.0-beta-Linux_x86_64.zip

ADD entrypoint.sh /sbin/
RUN chmod 755 /sbin/entrypoint.sh

RUN addgroup --gid 10513 bioinfousers &&\
    adduser --disabled-password --gecos '' --uid 11247 --gid 10513 bioinfo

RUN echo 'PATH=/opt/hisat2-2.0.0-beta:/opt/MaSuRCA-3.1.3/bin:/opt/jellyfish-2.2.3/bin:$PATH' >> /home/bioinfo/.bashrc
RUN echo 'PATH=/opt/hisat2-2.0.0-beta:/opt/MaSuRCA-3.1.3/bin:/opt/jellyfish-2.2.3/bin:$PATH' >> /home/bioinfo/.profile
USER bioinfo
ENTRYPOINT ["/sbin/entrypoint.sh"]
