#!/bin/bash
set -euo pipefail

#User-specific settings
NSLOTS=24
MEM=2G

#Other settings
TASK="AdapterRemoval"
WD=/nlustre/users/ansie/Rian_data
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}

declare -a array_R1=( $(ls /nlustre/users/ansie/Rian_data/bab/*R1_001*.fastq) )
declare -a array_R2=( $(ls /nlustre/users/ansie/Rian_data/bab/*R2_001.fastq) )
arraylength=${#array_R1[@]}
for ((i=1; i<${arraylength}+1; i++));
do

file_1=${array_R1[$i-1]}
file_2=${array_R2[$i-1]}
strip_suffix="${file_1%_R1*}"
baseName="${strip_suffix#./bab/}"


# Prepare SGE script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#PBS -S /bin/bash
#PBS -o ${WD}/${TASK}_runinfo/log
#PBS -e ${WD}/${TASK} runinfo/log
#PBS -m ae
#PBS -M aejysselansie@gmail.com
#PBS -l nodes=1:ppn=${NSLOTS}
#PBS -l walltime=8:00:00
#PBS -q normal
#PBS -N AdapterRemoval

module purge
module load adapterremoval


AdapterRemoval --threads ${NSLOTS} --file1 $file_1 --file2 $file_2 --minlength 35 --collapse --basename $baseName --quallitymax 42
 


EOF

#Submit job to cluster
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh 
done
