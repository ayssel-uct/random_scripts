## Array job for multiple multifasta files
##Keeps only the uique sequeces in each multifasta file
## Uses genometools "sequniq"

#!/bin/bash
set -euo pipefail

TASK="keep_unique"
WD=$(pwd)
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}


declare -a array=( $(ls *.fasta) )
arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do
echo  ${array[$i-1]}
x=${array[$i-1]}
y=${x%.fasta}_unique.fasta

gt sequniq -o ${y} ${x}
rm -rf *.fasta.*
done
