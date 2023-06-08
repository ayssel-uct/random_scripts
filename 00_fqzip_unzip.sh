#!/bin/bash
set -euo pipefail

#User-specific settings
NSLOTS=3
MEM=12G

#Other settings
TASK="Unzip"
WD=$(pwd)
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}


declare -a array=( $(ls ./bab) )
arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do
echo  ${array[$i-1]}
x=${array[$i-1]}
y=${x%%.fqz}



# Prepare PBS script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#PBS -S /bin/bash
#PBS -k oe
#PBS -m ae
#PBS -M aejysselansie@gmail.com
#PBS -l nodes=1:ppn=${NSLOTS}
#PBS -l walltime=8:00:00
#PBS -q normal
#PBS -N AdapterRemoval

module purge
module load adapterremoval
module load fqzcomp

fqz_comp -d ${WD}/bab/${x} ${WD}/bab/${y} 



EOF

#Submit job to cluster
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh 
done
