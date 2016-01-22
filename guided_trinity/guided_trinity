#!/bin/bash -l


if [ "$#" -ne 3 ]; then
    echo "You must enter exactly 3 command line arguments, SAMPLE, MEMORY and CPUS"
    exit 1
fi

SAMPLE=$1
MEMORY=$2
CPUS=$3
PROCESS=denovo_trinity-${SAMPLE}-${MEMORY}-${CPUS}
cd /sample
# date is stored in epoch
START=`date +%s`
echo "Genome Guided Trinity started on `date -d @${START}`" > ${PROCESS}.log
echo "Parameters:[${SAMPLE},${MEMORY},${CPUS}]"

if [ ! -f ${SAMPLE}.bai ]; then
  echo "Start indexing sample `date`" >> ${PROCESS}.log
  time samtools index ${SAMPLE}
  echo "Finished indexing sample `date`" >> ${PROCESS}.log
fi

time Trinity --seqType fq --genome_guided_bam ${SAMPLE} --max_memory ${MEMORY} --output ${PROCESS} --genome_guided_max_intron 10000 --CPU ${CPUS} >>${PROCESS}.log 2>&1 
STOP=`date +%s`
echo "Genome Guided Trinity finished on `date -d@${STOP}`" >> ${PROCESS}.log
TOTALSECONDS=$(echo "${STOP} - ${START}" | bc)
echo "Total seconds: ${TOTALSECONDS}" >> ${PROCESS}.log
