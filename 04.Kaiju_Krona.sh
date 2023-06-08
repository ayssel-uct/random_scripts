#!/bin/bash
set -euo pipefail

#User-specific settings


#Other settings
TASK="Kaiju_Krona_verbose"
WD=/nlustre/users/ansie/Rian_data
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}
#mkdir ${WD}/Kaiju_out_verbose
Out_Dir=Kaiju_out_verbose

declare -a array=( $(ls /nlustre/users/ansie/Rian_data/bab/*hum-clean.fq) )
arraylength=${#array[@]}
for ((i=1; i<${arraylength}+1; i++));
do

file=${array[$i-1]}
filename=${file##*/}


# Prepare PBS script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#PBS -S /bin/bash
#PBS -m ae
#PBS -k oe
#PBS -M aejysselansie@gmail.com
#PBS -l nodes=1:ppn=18
#PBS -l walltime=8:00:00
#PBS -q bigmem
#PBS -N ${TASK}

module purge
module load krona
##NOTA TO USER: Disable and enable each step as needed....
##step1:
#/home/ansie/local_software/kaiju/bin/kaiju -z 18 -t /home/ansie/Kaiju_Database/nodes.dmp -f /home/ansie/Kaiju_Database/kaiju_db_nr_euk.fmi -i ${file} -o ${WD}/${Out_Dir}/${filename}.kaiju.out -v
##step2
#/home/ansie/local_software/kaiju/bin/kaiju2krona -t /home/ansie/Kaiju_Database/nodes.dmp -n /home/ansie/Kaiju_Database/names.dmp -i ${WD}/${Out_Dir}/${filename}.kaiju.out -o ${WD}/${Out_Dir}/${filename}.kaiju.out.krona
##step3 the next program doesnt work in qsub, run it locally
#for file in ./*.krona; do ktImportText -o ${file}.html ${file}; done;
##Post processing helper programs
##step4 Create classification summary
#/home/ansie/local_software/kaiju/bin/kaiju2table -t /home/ansie/Kaiju_Database/nodes.dmp -n /home/ansie/Kaiju_Database/names.dmp -r species -p -o ${WD}/${Out_Dir}/${filename}.kaiju_summary.tsv ${WD}/${Out_Dir}/${filename}.kaiju.out
##step5 
/home/ansie/local_software/kaiju/bin/kaiju-addTaxonNames -t /home/ansie/Kaiju_Database/nodes.dmp -n /home/ansie/Kaiju_Database/names.dmp -i ${WD}/${Out_Dir}/${filename}.kaiju.out -o ${WD}/${Out_Dir}/${filename}.kaiju.names.out -p

EOF

#Submit job to cluster
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh 
done









