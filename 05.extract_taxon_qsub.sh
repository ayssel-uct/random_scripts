#!/bin/bash
set -euo pipefail

#Other settings
TASK="extract_query_taxon"
WD=/nlustre/users/ansie/Rian_data
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}
mkdir -p ${WD}/Extracted_taxons
QUERY="Viruses"

##STEP1 : Put Query data from Kaiju output into a file
##Here I do it with all files (not only damage repaired (will remove those later)
echo 'Step1'


for f in `ls ./Kaiju_out_verbose/*kaiju.names.out | grep -v dr`; do
   (echo ${f}; grep "${QUERY}" $f >> ${WD}/Extracted_taxons/${QUERY}_list.txt &); 
done
echo 'Step 1 done'
sleep 200
##STEP 2: Extract the read numbers from the list file (second column) and add to new file
echo 'Step2'
for x in ${WD}/Extracted_taxons/${QUERY}_list.txt; do 
	cut -d'	' -f2 ${x}  >> ${WD}/Extracted_taxons/${QUERY}_readsIDs.txt;
done
echo 'Step 2 done'
sleep 200 
##STEP 3: Get sequence from fastq file
echo 'Step3' 
module load seqtk
for f in `ls ./bab/*hum-clean.fq | grep -v dr`; do
	(echo ${f}; seqtk subseq ${f} ${WD}/Extracted_taxons/${QUERY}_readsIDs.txt >> ${WD}/Extracted_taxons/${QUERY}_sequences.fq);
done
sleep 5
echo 'Step3 done'
echo 'done'
