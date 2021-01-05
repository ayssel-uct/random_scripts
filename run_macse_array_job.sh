##Bash script for running multiple Macse jobs for fasta files in same directory
## Currently jobs run in sequence, would be cool to make them run in parallel (Gnu Parallel could help here)

#!/bin/bash
#set -euo pipefail

#list files in the directory that you are working in, the file names are stored as an array 
declare -a array=( $(ls /path/to/directory/*.fasta) )

arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do
echo  ${array[$i-1]}
x=${array[$i-1]}
y=${x%.fasta}


java -jar -Xmx600m /path/to/macse_v2.05.jar -prog alignSequences -seq ${x} -out_NT ${y}_macse_out_NT.fasta -out_AA ${y}_macse_out_AA.fasta

# Note, this deletes the "-" in the fasta headers as well... maybe not a huge problem yet

done
