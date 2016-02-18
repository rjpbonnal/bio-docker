#!/usr/bin/env bash
cd /opt/data
tar xzvf Han-Glanville-2014-example-data.tgz
rm Han-Glanville-2014-example-data.tgz
joined="miseq-09-23-2013-example.fa"
fasta-demux.pl --dnafile=$joined
parallel fasta-vdj-pipeline.pl --file={} ::: *-[0-9][A-Z][0-9].fa *-[0-9][0-9][A-Z][0-9].fa *-[0-9][A-Z][0-9][0-9].fa *-[0-9][0-9][A-Z][0-9][0-9].fa
#for file in *-[0-9][A-Z][0-9].fa *-[0-9][0-9][A-Z][0-9].fa *-[0-9][A-Z][0-9][0-9].fa *-[0-9][0-9][A-Z][0-9][0-9].fa
#do
#  fasta-vdj-pipeline.pl --file=$file
#done
