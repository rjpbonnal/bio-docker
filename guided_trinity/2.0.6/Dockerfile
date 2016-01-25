# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman
# VERSION               2.0.6
# CREATE 2015-10-01

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y inotify-tools nano wget links curl rsync bc git git-core apt-transport-https libxml2 libxml2-dev libcurl4-openssl-dev openssl sqlite3 libsqlite3-dev gawk libreadline6-dev libyaml-dev autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev make m4 git build-essential software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java7-installer

RUN apt-get clean

RUN curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -

ADD wget https://github.com/trinityrnaseq/trinityrnaseq/archive/v2.0.6.tar.gz /opt/
#Download Trinity
RUN cd /opt &&\
    tar xzvf v2.0.6.tar.gz
    cd /opt/trinityrnaseq-2.0.6 &&\
    make &&\
    make plugins

RUN apt-get install -y liburi-perl

RUN cd /opt &&\
    git clone https://github.com/samtools/htslib &&\
    cd htslib &&\
    autoconf &&\
    ./configure &&\
    make &&\
    make install

RUN cd /opt &&\
    git clone https://github.com/samtools/samtools &&\
    cd samtools &&\
    make &&\
    make install 

RUN cd /opt &&\
    wget https://github.com/BenLangmead/bowtie2/archive/v2.2.5.tar.gz &&\
    tar xzvf v2.2.5.tar.gz

RUN cd /opt/bowtie2-2.2.5 &&\
    make &&\
    cp bowtie2 /usr/bin &&\
    cp bowtie2-align-s /usr/bin &&\
    cp bowtie2-align-l /usr/bin &&\
    cp bowtie2-build /usr/bin &&\
    cp bowtie2-build-s /usr/bin &&\
    cp bowtie2-build-l /usr/bin &&\
    cp bowtie2-inspect /usr/bin &&\
    cp bowtie2-inspect-s /usr/bin &&\
    cp bowtie2-inspect-l  /usr/bin

RUN cd /opt &&\
    wget https://github.com/BenLangmead/bowtie/archive/v1.1.2.tar.gz &&\
    tar xzvf v1.1.2.tar.gz

RUN cd /opt/bowtie-1.1.2 &&\
    make &&\
    cp bowtie /usr/bin &&\
    cp bowtie-align-l /usr/bin &&\
    cp bowtie-align-s /usr/bin &&\
    cp bowtie-build /usr/bin &&\
    cp bowtie-build-l /usr/bin &&\
    cp bowtie-build-s /usr/bin &&\
    cp bowtie-inspect /usr/bin &&\
    cp bowtie-inspect-l /usr/bin &&\
    cp bowtie-inspect-s /usr/bin

RUN apt-get install -y python

RUN cd /opt &&\
    wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.0.4.tar.gz &&\
    tar xzvf stringtie-1.0.4.tar.gz &&\
    cd stringtie-1.0.4 &&\
    make release &&\
    cp stringtie /usr/bin

RUN echo 'PATH=/opt/trinityrnaseq-2.0.6:$PATH' >> /root/.bashrc
RUN echo 'PATH=/opt/trinityrnaseq-2.0.6:$PATH' >> /root/.profile

RUN addgroup --gid 10513 bioinfousers &&\
    adduser --uid 11247 --gid 10513 bioinfo

USER bioinfo


ADD guided_trinity /usr/bin/

ENTRYPOINT ["/usr/bin/guided_trinity"]

# Creates this user when run docker inside the INGM infra.

#ADD superreads.pl /usr/bin/

#building the container
# docker build -t helios/denovo_human_trinity:1.0 .
#running docker for a specific sample
#running trinity with previously aligned BAM
#docker run -v /mnt/rnd/projects/atlas_h_lympho/cd4_th1/SQ_0007:/sample -ti trinity /bin/bash
#cd /sample
# Trinity on INGM facility
#Trinity --genome_guided_sort_buffer 120G --genome_guided_CPU 5 --GMAP_CPU 8 --seqType fq --JM 100G --CPU 8  --genome_guided_max_intron 1000 --genome_guided_bam sort_by_name/SQ_0007.bam --max_memory 10G --output denovo_trinity
# Please refer to the notes.txt file in the repository for details.
