##Before running this shell script, first edit the CTL files that contain settings for Maker.
#!/bin/bash
set -euo pipefail

#User-specific settings
NSLOTS=20
MEM=6G

#Other settings
TASK="Fonio_round1"
BASE="Fonio_round1"
WD=$(pwd)
NOW=$(date +"%Y%m%d%H%M")


export THREADS_DAEMON_MODEL=1
export AUGUSTUS_CONFIG_PATH=/software/shared/apps/x86_64/augustus/3.3/config/
export ZOE=/software/shared/apps/x86_64/snap/20130625/snap/

mkdir -p ${TASK}_runinfo/{log,tmp}
# Prepare SGE script
cat <<EOF >${TASK}_runinfo/tmp/${TASK}_$$.sh
#$ -S /bin/bash
#$ -cwd
#$ -l h_vmem=${MEM}
#$ -o ${WD}/${TASK}_runinfo/log
#$ -m baes
#$ -M ${USER}@psb.vib-ugent.be
#$ -pe serial ${NSLOTS}

module purge
module load maker/x86_64/2.31.10
module unload RepeatMasker/x86_64/4-1-0
module load RepeatMasker/x86_64/4-0-7
module unload blast/x86_64/2.6.0+
module load blast/x86_64/2.7.1+
module unload exonerate/x86_64/2.4.0
module load exonerate/x86_64/2.2.0
module load SNAP/x86_64/20180302
module load openmpi/x86_64/1.8.6
module load perl/x86_64/5.28.0


export AUGUSTUS_CONFIG_PATH=/software/shared/apps/x86_64/augustus/3.3/config/
export ZOE=/software/shared/apps/x86_64/snap/20130625/snap
export THREADS_DAEMON_MODEL=1

mpiexec --quiet -n ${NSLOTS} maker --base ${BASE} maker_opts.ctl maker_bopts.ctl maker_exe.ctl > ${TASK}.error
EOF
#Submit job to cluster
qsub ${TASK}_runinfo/tmp/${TASK}_$$.sh 
