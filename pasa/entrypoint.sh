#!/bin/bash



#if [ -n ${MYSQL_PORT_3306_TCP_ADDR} ]; then
#  erb -T - /opt/PASApipeline-2.0.2/pasa_conf/pasa_config.erb > /opt/PASApipeline-2.0.2/pasa_conf/conf.txt
#fi

export PROJECT=$1 #pasatest
export REFFILE=$2 #Homo_sapiens.GRCh38.80.dna.chromosomes.fa
export CPU=$3

if [ ! -n "${CPU}" ]; then
  export CPU=2
fi

if [ -n "${PROJECT}" ]; then
  erb -T - /opt/PASApipeline-2.0.2/pasa_conf/pasa.annotationCompare.erb > /pasa/annotCompare.config
  erb -T - /opt/PASApipeline-2.0.2/pasa_conf/pasa.alignAssembly.erb > /pasa/alignAssembly.config
  #mysql -h pasa_db -u pasadmin -ppasapass -e "CREATE DATABASE IF NOT EXISTS \`${PROJECT}\` DEFAULT CHARACTER SET \`utf8\` COLLATE \`utf8_unicode_ci\`;"
else
  echo "Error: please provide a project/database name"
  exit 1
fi 

if [ ! -r "/genome/${REFFILE}" ]; then
  echo "Error: reference file (${REFFILE}) does not exist."
  exit 1
fi



cd /pasa
/opt/PASApipeline-2.0.2/scripts/Launch_PASA_pipeline.pl -c /pasa/alignAssembly.config -C -R -g /genome/"${REFFILE}" -t /assembly/Trinity-GG.fasta --ALIGNERS blat,gmap --CPU "${CPU}"

