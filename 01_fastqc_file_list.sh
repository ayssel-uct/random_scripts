#!/bin/bash
set -euo pipefail

#User-specific settings
NSLOTS=30
MEM=2G

#Other settings
TASK="Unzip"
WD=$(pwd)
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}


declare -a array=( $(ls ./bab) )
#arraylength=${#array[@]}
#for ((i=1; i<${arraylength}+1; i++));
#do
#echo  ${array}
#x=${array[$i-1]}
#y=${x%%.fqz}



# Prepare PBS script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#PBS -S /bin/bash
#PBS -k oe
#PBS -m ae
#PBS -M aejysselansie@gmail.com
#PBS -l nodes=1:ppn=${NSLOTS}
#PBS -l walltime=8:00:00
#PBS -q bigmem
#PBS -N FastQC

module purge
module load fastqc-0.11.7

#fastqc -d ${WD}/bab/ -o /nlustre/users/ansie/Rian_data/bab/ -t ${NSLOTS} 
fastqc -o /nlustre/users/ansie/Rian_data/bab/ -t ${NSLOTS} ${array[@]}



EOF

#Submit job to cluster
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh 

