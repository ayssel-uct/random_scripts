#!/bin/bash
set -euo pipefail

#User-specific settings


#Other settings
TASK="bbmap_HumanGenome"
WD=/nlustre/users/ansie/Rian_data
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}


declare -a array=( $(ls /nlustre/users/ansie/Rian_data/bab/*.collapsed) )
arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do

file=${array[$i-1]}
#file=/nlustre/users/ansie/Rian_data/bab/bab2_b1_e1_wgc_me_TCATGGT_L004_.collapsed 


# Prepare PBS script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#PBS -S /bin/bash
#PBS -m ae
#PBS -k oe
#PBS -M aejysselansie@gmail.com
#PBS -l nodes=1:ppn=18
#PBS -l walltime=8:00:00
#PBS -q bigmem
#PBS -N testing_script

module purge
module load bbmap


bbmap.sh minid=0.95 maxindel=3 bwr=0.16 bw=12 quickmatch fast minhits=2 ref=${WD}/hg/hg38.p12.fa path=${WD}/hg_index/ qtrim=r1 trimq=10 untrim -in=${file} outu=${file}\.hum-clean.fq outm=${file}\.hum-matched.fq threads=18
 


EOF

#Submit job to cluster
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh 
done
