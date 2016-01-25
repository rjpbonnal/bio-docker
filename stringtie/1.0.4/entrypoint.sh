#!/bin/bash

export REFFILE=$1 
export SAMPLE=$2
export OUTPUT=$3
export CPU=$4


if [ ! -n "${CPU}" ]; then
  export CPU=2
fi

if [ ! -r "${REFFILE}" ]; then
  echo "Error: reference file (${REFFILE}) does not exist."
  exit 1
fi

if [ ! -r "${SAMPLE}" ]; then
  echo "Error: reference file (${SAMPLE}) does not exist."
  exit 1
fi


export TIMESTAMP=`date +%s`


# cd /sample
# cufflinks -g /gtf/${REFFILE} -p ${CPU} -o denovo-cufflinks-${TIMESTAMP} ${SAMPLE}
stringtie ${SAMPLE} -p ${CPU} -G ${REFFILE} -o ${OUTPUT}



# # SuperReads computation 
# mkdir -p /mnt/rnd/projects/unicredit/sample/stringtieSR
# docker run -it --name stringy -v /mnt/cdata/ngs/demux/collab/Til/RNAseq/I/SQ_0334:/input -v /mnt/rnd/projects/unicredit/sample/stringtieSR:/output helios/stringtie /bin/bash

# superreads.pl /input/R1.fastq.gz /input/R2.fastq.gz /opt/MaSuRCA-3.1.3  -l /output/LongReads.fq -t 10 -j 20000000000




# stringtie can not create the directory hierarchy
# mkdir -p /mnt/rnd/projects/unicredit/sample/stringtie


# docker run -it -v /mnt/rnd/projects/unicredit/sample:/input -v /mnt/rnd/projects/unicredit/sample/stringtie:/output -v /mnt/cdata/db/genome/ensembl/release-80/gtf/homo_sapiens/:/gtf helios/stringtie stringtie /input/SQ_0334.bam -p 25 -G /gtf/Homo_sapiens.GRCh38.80.nohaplo_noMT.gtf -o /output/SQ_0334.gtf


# docker run -it -v /mnt/rnd/projects/unicredit/sample:/input -v /mnt/rnd/projects/unicredit/sample/stringtie:/output -v /mnt/cdata/db/genome/ensembl/release-80/gtf/homo_sapiens/:/gtf helios/stringtie /bin/bash

# stringtie /input/SQ_0334.bam -p 25 -G /gtf/Homo_sapiens.GRCh38.80.nohaplo_noMT.gtf -o /output/SQ_0334.gtf
