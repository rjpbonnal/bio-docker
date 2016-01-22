# UniCredit VPN
docker run --rm -v /ingm/mnt/rnd/projects/til/treg_til/SQ_0334/sam_to_bam_by_coordinate/:/sample -v /ingm:/gtf -d -t helios/cufflinks Homo_sapiens.GRCh38.80.nohaplo_noMT.gtf SQ_0334.bam 8

# INGM 
docker run -it -v /ingm/mnt/rnd/projects/til/treg_til/SQ_0334/sam_to_bam_by_coordinate/:/sample -v /mnt/cdata/db/genome/ensembl/release-80/gtf/homo_sapiens/:/gtf helios/cufflinks Homo_sapiens.GRCh38.80.nohaplo_noMT.gtf SQ_0334.bam 8

# from inside the machine skipping the entrypoint
dockeriron run --rm -i --entrypoint=/bin/bash -t helios/cufflinks
cufflinks -p 25 -g /gtf/Homo_sapiens.GRCh38.80.nohaplo_noMT.gtf /input/SQ_0334.bam 

