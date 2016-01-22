# INGM Bioinformatics
#
# DESCRIPTION: DeNovoHuman Installation of PASA
# VERSION               0.0.1

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common

RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer


# Installing GMAP 2015-07-23

#ADD http://research-pub.gene.com/gmap/src/gmap-gsnap-2015-07-23.tar.gz /opt/
ADD gmap-gsnap-2015-07-23.tar.gz /opt/

    #tar xzvf gmap-gsnap-2015-07-23.tar.gz &&\
RUN cd /opt &&\
    cd gmap-2015-07-23 &&\
    mkdir -p /gmapdb &&\
    ./configure --with-gmapdb=/gmapdb &&\
    make &&\
    make install

# Installing BLAT

#ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/blat/blat /usr/bin/
ADD blat /usr/bin/

RUN chmod +x /usr/bin/blat

# Installing Fasta

#ADD http://faculty.virginia.edu/wrpearson/fasta/fasta36/fasta-36.3.8a.tar.gz /opt/
ADD fasta-36.3.8a.tar.gz /opt/

    #tar xzvf fasta-36.3.8a.tar.gz &&\
RUN cd /opt &&\
    cd fasta-36.3.8a/src &&\
    make -f ../make/Makefile.linux64 all &&\
    rm /opt/fasta-36.3.8a/bin/README &&\
    cp /opt/fasta-36.3.8a/bin/* /usr/bin/ &&\
    cd /usr/bin &&\
    ln -s fasta36 fasta

# Installing PASA

RUN apt-get install -y libdbd-mysql-perl

ADD https://github.com/PASApipeline/PASApipeline/archive/v2.0.2.tar.gz /opt/

RUN cd /opt &&\
    tar xzvf v2.0.2.tar.gz &&\
    cd PASApipeline-2.0.2 &&\
    make

RUN cd /opt/PASApipeline-2.0.2/seqclean &&\
    tar xzvf seqclean.tar.gz

RUN echo 'PATH=/opt/PASApipeline-2.0.2/bin:/opt/PASApipeline-2.0.2/seqclean/seqclean:/opt/PASApipeline-2.0.2/seqclean/bin:$PATH' >> /root/.bashrc
RUN echo 'PATH=/opt/PASApipeline-2.0.2/bin:/opt/PASApipeline-2.0.2/seqclean/seqclean:/opt/PASApipeline-2.0.2/seqclean/bin:$PATH' >> /root/.profile

ADD http://ftp.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz /opt/
# ADD ruby-2.2.3.tar.gz /opt/

RUN cd /opt &&\
    tar xzvf ruby-2.2.3.tar.gz &&\
    cd /opt/ruby-2.2.3 &&\
    ./configure &&\
    make &&\
    sudo make install

COPY conf.txt /opt/PASApipeline-2.0.2/pasa_conf/

COPY pasa.annotationCompare.erb /opt/PASApipeline-2.0.2/pasa_conf/

COPY pasa.alignAssembly.erb /opt/PASApipeline-2.0.2/pasa_conf/

COPY entrypoint.sh /sbin/

RUN apt-get update --fix-missing && apt-get install -y mysql-client

RUN apt-get update --fix-missing && apt-get install -y liburi-perl

ENTRYPOINT ["/sbin/entrypoint.sh"]
#RUN apt-get install -y ncbi-blast+

#RUN addgroup --gid 10513 bioinfousers &&\
#    adduser --uid 11247 --gid 10513 bioinfo

#USER bioinfo

