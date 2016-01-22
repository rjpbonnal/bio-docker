#!/bin/bash


export REFFILE=$1 
export SAMPLE=$2
export CPU=$3


if [ ! -n "${CPU}" ]; then
  export CPU=2
fi

if [ ! -r "/gtf/${REFFILE}" ]; then
  echo "Error: reference file (${REFFILE}) does not exist."
  exit 1
fi

export TIMESTAMP=`date +%s`


cd /sample
cufflinks -g /gtf/${REFFILE} -p ${CPU} -o denovo-cufflinks-${TIMESTAMP} ${SAMPLE}