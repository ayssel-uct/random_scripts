#!/bin/bash
## Array job for multiple multifasta files
##Removes sequences from fasta files based on list of headers to discard
#This tool uses "samtools faidx" to remove sequences with a specific header


set -euo pipefail



declare -a array=( $(ls /mnt/c/Users/User/Downloads/Run_new_pipeline/Ansie_remove_Amino_Acids/V703_Env_AA_HXB2_Timepoint1_Version1/*.fasta) )
arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do
echo  ${array[$i-1]}
x=${array[$i-1]}


samtools faidx ${x}
remove_ids=($(awk '{print $1}' ${x}.fai | grep -v -f /mnt/c/Users/User/Downloads/Run_new_pipeline/Ansie_remove_Amino_Acids/UMIs_to_remove.txt))
samtools faidx -o ${x}_cleaned.fasta ${x} "${remove_ids[@]}"
done


