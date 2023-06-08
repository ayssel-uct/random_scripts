#!/bin/bash
set -euo pipefail


# User-specific settings
FILE1=/scratch/aocc/anyss/Moringa_oleifera_BGI.gff
FILE2=/scratch/aocc/anyss/Maker_exp4_MayD/Moringa_masked.maker.output/Moringa_oleifera_annotation.gff
NSLOTS=1
MEM=4G


# Other setting
TASK="GFF_compare"
WD=$(pwd)
NOW=$(date +"%Y%m%d%H%M")
mkdir -p ${TASK}_runinfo/{log,tmp}


# Prepare SGE script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#$ -S /bin/bash
#$ -cwd
#$ -pe serial ${NSLOTS}
#$ -l h_vmem=${MEM}
#$ -e ${WD}/${TASK}_runinfo/log
#$ -o ${WD}/${TASK}_runinfo/log
#$ -m aes
#$ -M ${USER}@psb.vib-ugent.be

module purge
module load gffcompare/x86_64/20160708

gffcompare -o M.oleifera -V -D -r ${FILE2} ${FILE1}

EOF


# Submit job
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh

