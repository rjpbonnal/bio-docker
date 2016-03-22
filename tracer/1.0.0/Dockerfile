# INGM Bioinformatics
#
# DESCRIPTION: TCR analyse with TraCeR
# VERSION               1.0.0
# CREATE 2016-03-22

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y inotify-tools nano wget links curl rsync bc git git-core apt-transport-https libxml2 libxml2-dev libcurl4-openssl-dev openssl sqlite3 libsqlite3-dev gawk libreadline6-dev libyaml-dev autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev make m4 git build-essential software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update

RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java7-installer

RUN apt-get clean

RUN curl -sSL https://rvm.io/mpapis.asc | sudo gpg --import -

RUN cd /opt &&\ 
    wget https://github.com/trinityrnaseq/trinityrnaseq/archive/v2.1.1.tar.gz
#Download Trinity
RUN cd /opt &&\
    tar xzvf v2.1.1.tar.gz &&\
    cd /opt/trinityrnaseq-2.1.1 &&\
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
    wget https://github.com/BenLangmead/bowtie2/archive/v2.2.7.tar.gz &&\
    tar xzvf v2.2.7.tar.gz

RUN cd /opt/bowtie2-2.2.7 &&\
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

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-2.4.1-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-2.4.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-2.4.1-Linux-x86_64.sh

RUN /opt/conda/bin/conda install -y matplotlib
RUN /opt/conda/bin/conda install -y seaborn
RUN /opt/conda/bin/conda install -y -c https://conda.anaconda.org/anaconda biopython
RUN /opt/conda/bin/conda install -y -c https://conda.anaconda.org/cgat pysam
RUN /opt/conda/bin/conda install -y -c https://conda.anaconda.org/barnybug prettytable
RUN /opt/conda/bin/conda install -y -c https://conda.anaconda.org/faircloth-lab python-levenshtein
RUN /opt/conda/bin/conda install -y networkx
RUN /opt/conda/bin/conda install -c https://conda.anaconda.org/anaconda graphviz

RUN cd /opt/ && \
    wget ftp://ftp.ncbi.nih.gov/blast/executables/igblast/release/1.4.0/ncbi-igblast-1.4.0-x64-linux.tar.gz && \
    tar xzvf ncbi-igblast-1.4.0-x64-linux.tar.gz


RUN cd /opt && \
    wget https://github.com/pachterlab/kallisto/releases/download/v0.42.4/kallisto_linux-v0.42.4.tar.gz && \
    tar xzvf kallisto_linux-v0.42.4.tar.gz

RUN cd /opt && \
    git clone https://github.com/Teichlab/tracer && \
    cd tracer && \
    git checkout f3b648f

COPY tracer.conf /opt/tracer/

RUN cd /opt/tracer && \
    git config --global user.email "bonnal@ingm.org" && \
    git config --global user.name "Raoul Jean Pierre Bonnal" && \
    git add tracer.conf && \
    git commit -m 'docker config'

ENV PATH /opt/trinityrnaseq-2.1.1:/opt/conda/bin:/opt/bowtie2-2.2.7:/opt/bowtie-1.1.2:/opt/ncbi-igblast-1.4.0/bin/:/opt/kallisto_linux-v0.42.4:/opt/samtools:/opt/tracer:$PATH
ENV PYTHONPATH /opt/conda/pkgs
ENV LANG C.UTF-8

RUN cd /opt/tracer && \
    PATH=/opt/trinityrnaseq-2.1.1:/opt/conda/bin:/opt/bowtie2-2.2.7:/opt/bowtie-1.1.2:/opt/ncbi-igblast-1.4.0/bin/:/opt/kallisto_linux-v0.42.4:/opt/samtools:/opt/tracer:$PATH  tracer test


#ADD entrypoint.sh /usr/bin/

#ENTRYPOINT ["/usr/bin/entrypoint.sh"]

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
