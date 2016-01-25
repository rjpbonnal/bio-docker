#!/usr/bin/perl

use strict;
use Getopt::Long;
use File::Basename;
use Cwd;

# ********************************************************************
# usage: superreads.pl <pair_read1_fq_file> <pair_read2_fq_file> <masurca_package_directory> [options]
# ********************************************************************

# ********************************************************************
# Description: this script runs MaSuRCA and prepares the super-reads 
# and unassembled reads files  that need to be aligned by a spliced 
# alignment program
# ********************************************************************



my $usage = q/Usage:
 superreads.pl <pair_read_R1>[.gz|.gz2] <pair_read_R2>[.gz|.gz2] <masurca_package_directory> [options]
Options:
 -t <num_threads>                number of threads to use (default: 10)
 -j <jf_size>                    jellyfish hash size (default: 2500000000)
 -s <step>                       step to restart assembly process (default:0)
 -r <paired_read_prefix>         prefix for paired-reads (default: pe)
 -f <fragment_size>              fragment size (default: 300)
 -d <standard_deviation>         fragment size standard deviation (default:45)
 -l <super_reads_file_name>      assembled super-reads file name (default: LongReads.fq)
 -u <not_assembled_reads_prefix> prefix for the unassembled reads file names (default: 
         adds ".notAssembled.fq.gz" to the initial paired files)
Usage examples:
 superreads.pl hg19_R1.fastq hg19_R2.fastq \/packages\/MaSuRCA-2.1.0
/;


# -c                              don\'t clean-up the intermediary files


die($usage."Error: at least two input fastq files, and the masurca package directory need to be specified\n") unless @ARGV>=3;

### GLOBAL PARAMETERS

my $step=1;
my $num_thr=10;
my $jf_size=2500000000;
my $read_prefix = "pe";
my $longreads_name = "LongReads.fq.gz";
my $unassembled_prefix="";
my $peout1file=get_filename_prefix($ARGV[0]).".notAssembled.fq.gz";
my $peout2file=get_filename_prefix($ARGV[1]).".notAssembled.fq.gz";
my $fragment_length = 300;
my $sd=20;
#my $dontclean=0;
#my $splice_prog="tophat2";


### end global parameters

GetOptions(
     "t=i" => \$num_thr,
     "j=i" => \$jf_size,
     "s=i" => \$step,
     "r=s" => \$read_prefix,
     "f=f" => \$fragment_length,
     "l=s" => \$longreads_name,
     "d=f" => \$sd,
     "u=s" => \$unassembled_prefix
);

# "c"   => \$dontclean,
#my $cleanup=1-$dontclean;

if(!$step) {$step=1;}

if($unassembled_prefix) {
    $peout1file=$unassembled_prefix."R1.fq.gz";
    $peout2file=$unassembled_prefix."R2.fq.gz";
}

# this is step 1: only here I create the files; step 2 assumes they were already created

if(!(-e $ARGV[0]) || !(-e $ARGV[1])) {
    die "Couldn't find both input fastq files!\n";
}
    
if($step<2) { print STDERR "Starting step 1: process input files files....\n";}


my $r1file=process_file($ARGV[0],$step);
my $r2file=process_file($ARGV[1],$step);
my $masurca_dir=$ARGV[2];

my $config_file=$masurca_dir."/sr_config_example.txt";

if(!(-e $config_file)) {
    print STDERR "MaSuRCA config file not found: $config_file\n";
    exit;
}

if($step<2) { print STDERR "Done step 1.\n";}

my $assemble_script="assemble.sh";

if($step<3) {
    print STDERR "Starting step 2: prepare files for assembly....\n";
    $config_file=update_config_file($config_file,$r1file,$r2file,$read_prefix,$fragment_length,$sd,$num_thr,$jf_size);
    my $run_masurca=$masurca_dir."/bin/masurca $config_file";
    print STDERR "Running $run_masurca\n";
    die "Could not run MaSuRCA command: $run_masurca\n" if system($run_masurca);
    update_assemble_script($assemble_script);
    print STDERR "Done step 2.\n";
}

if($step<4) {
    print STDERR "Starting step 3: run MaSuRCA super-read module....\n";
    if(!(-e $assemble_script)) {
  print STDERR "Could not find assembly script: $assemble_script\n";
  exit;
    }
    my $run_assembly="./".$assemble_script;
    die "Assembly script did not finish running!\n" if system($run_assembly);
    print STDERR "Done step 3.\n";
}

if($step<5) {
    print STDERR "Starting step 4: prepare super-reads for spliced alignment....\n";
    get_long_reads($r1file,$r2file,$longreads_name,$peout1file,$peout2file,$fragment_length);
    print STDERR "Done step 4.\n";
}


sub get_filename_prefix {
    my ($filename)=@_;

    my @b=split(/\//,$filename);
    my @a=split(/\./,$b[-1]);

    #if($a[-1] eq 'gz') { pop(@a);}
    if(($a[-1]=~m/\.bzi?p?2$/)||($a[-1]=~m/.g?zi?p?$/)) { pop(@a);}
    
    if(($a[-1] eq 'fq')||($a[-1] eq 'fastq')) { pop(@a);}

    my $newname=join('.',@a);

    return($newname);
}

sub process_file { # MaSuRCA needs the fastq files unzipped, so we need to make sure they are not compressed

    my($file,$step)=@_; # only at step 0 I unompress the files, otherwise I just create the name

    my $outfile="";
 
    my $gz="";

    # determine compression if any
    if ($file=~m/\.bzi?p?2$/) {
  $gz='bzip2';
    }
    elsif ($file=~m/.g?zi?p?$/) {
  $gz='gzip';
    }

    if($gz) {
  my @b=split(/\//,$file);
  my @a=split(/\./,$b[-1]);
  $outfile=join('.',@a);    
  if($step<2) {
      open(F, $gz." -cd '".$file."'|") || 
    die("Error creating decompression pipe: $gz -cd $file !\n");
      open(O,">$outfile");
      while(<F>) {
    print O $_;
      }
      close(F);
      close(O);
  }
    }
    else { 
  $outfile=$file;
    }

    return($outfile);
}

  
sub update_assemble_script {
    my ($assemble_script)=@_;

    my $out="";

    open(F,$assemble_script);
    while(<F>) {
  if(/^runCA/) { last;}
  $out.=$_;
    }
    close(F);

    open(O,">$assemble_script");
    print O $out;
    close(O);

}

sub update_config_file { 
    my ($config_file,$r1file,$r2file,$read_prefix,$fragment_len,$sd,$num_thr,$jf_size)=@_;
    my $new_config_file="sr_config.txt";
    open(F,$config_file);
    open(O,">$new_config_file");
    my $print=1;
    while(<F>) {
  if(/^DATA$/) {
      print O "DATA\n";
      print O "PE= $read_prefix $fragment_len $sd $r1file $r2file\n";
      print O "END\n";
      $print=0;
  }
  if($print) {
      if(/^NUM_THREADS/) {
    print O "NUM_THREADS=$num_thr\n";
      }
      elsif(/^JF_SIZE/) {
    print O "JF_SIZE=$jf_size\n";
      }
      else {
    print O $_;
      }
  }
  if(/^END/) {
      $print=1;
  }
    }
    close(F);
    close(O);

    return($new_config_file);
}

sub get_long_reads {
    my ($pair1file,$pair2file,$longreadout,$peout1file,$peout2file,$fragment_length)=@_;

    my $readplacement="work1/readPlacementsInSuperReads.final.read.superRead.offset.ori.txt";
    die "MaSuRCA file $readplacement could not be found!\n" if (!(-e $readplacement));

    my $superreadfasta="work1/superReadSequences.fasta";
    die "MaSuRCA file $superreadfasta could not be found!\n" if (!(-e $superreadfasta));
    
    my @read; # stores the supereads info: 0=first read pair position; 1=second read pair position; 2=orientation of first read; 3=position of read in fastq file

    my $n=0;
    my $prev_read_num=-1;
    my $prev_orient;
    my $prev_pos;
    my $prev_superread;

    my %longread;
    my %isname;

    open(F,$readplacement);
    while(<F>) {
  chomp;
  my ($read_id, $super_read, $position, $orientation) = split(/\s+/);
  if($read_id =~ /^$read_prefix(\d+)/) { 
      my $read_num = $1;

      # if we have two reads in a row, the first one being an even number, 
      # then check paired end constraints
      if ($read_num == $prev_read_num + 1 &&
    $read_num % 2 == 1) {
    # then we have a pair of reads
    if ($super_read eq $prev_superread) { # then they are in the same unitig
        if (($orientation eq "F" && $prev_orient eq "R")|| ($orientation eq "R" &&
           $prev_orient eq "F")) {
      if($prev_pos<0) { $prev_pos =0;}
      if($position<0) { $position = 0;}
      my $distance = $prev_pos - $position;
      if ($orientation eq "R" && $prev_orient eq "F") {
          $distance = $position - $prev_pos;
      }
      # if reads are placed the right way, and they are within a factor of 2 of the right dist apart
      if ($distance>50 && $distance < $fragment_length * 2 &&
          $distance > 0) {  
          push(@{$read[$n]},($prev_pos,$position,$prev_orient,$prev_read_num/2));
          $longread{$prev_read_num/2}=1;
          push(@{$isname{$super_read}},$n);
          $n++;
      }
        }
    }
      }
      # always save the ID and compare to the next one
      $prev_read_num = $read_num;
      $prev_orient = $orientation;
      $prev_pos = $position;
      $prev_superread = $super_read;
  }
  else { $prev_read_num=-1;}
    }
    close(F);


    if($pair1file =~ /\.gz$/) {
  open(F,"zcat $pair1file|");
    }
    else {
  open(F,$pair1file);
    }
    #open(O,">$peout1file");
    open(O,"|gzip -c >$peout1file");
    $n=0;
    while(<F>) {
  chomp;
  if($longread{$n}) { $longread{$n}=$_; <F>; <F>; <F>;}
  else {
      print O $_,"\n";
      my $line=<F>; print O $line;
      my $line=<F>; print O $line;
      my $line=<F>; print O $line;
  }
  $n++;
    }
    close(F);
    close(O);

    if($pair2file =~ /\.gz$/) {
  open(F,"zcat $pair2file|");
    }
    else {
  open(F,$pair2file);
    }
    #open(O,">$peout2file");
    open(O,"|gzip -c >$peout2file");
    $n=0;
    while(<F>) {
  chomp;
  if(!$longread{$n}) { 
      print O $_,"\n";
      my $line=<F>; print O $line;
      my $line=<F>; print O $line;
      my $line=<F>; print O $line;
  }
  else { <F>;<F>;<F>;}
  $n++;
    }
    close(F);
    close(O);
    
    open(O,">$longreadout");
    #open(O,"|gzip -c >$longreadout");
    $/=">";
    open(F,$superreadfasta);
    while(<F>) {
  chomp;
  if($_) {
      my ($name)=/^(\S+)\s+/;
      if($isname{$name}) {
    my $pos=index($_,"\n");
    my $seq=substr($_,$pos+1);
    local $/="\n";
    chomp($seq);
    for(my $i=0;$i<scalar(@{$isname{$name}});$i++) {
        my $n=$isname{$name}[$i];
        my $end5=$read[$n][0];
        my $end3=$read[$n][1];
        if($end5>$end3) {
      $end5=$read[$n][1];
      $end3=$read[$n][0];
        }
        
        my $len=$end3-$end5;
        my $longread_seq=substr($seq,$end5,$len);
        if($read[$n][2] eq 'R') { 
      $longread_seq=reverse $longread_seq;
      $longread_seq =~ tr/ACGTacgt/TGCAtgca/;
        }
        
        # now print it in fastq format
        print O $longread{$read[$n][3]},"\n";
        print O $longread_seq, "\n";
        print O "+\n";
        # use quality value "J" which is 41, I think
        print O 'J' x length($longread_seq),"\n";
    }
      }
  }
    }
    close(F);
}