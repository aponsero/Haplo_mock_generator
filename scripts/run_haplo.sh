#!/bin/sh

#PBS -l select=1:ncpus=1:mem=2gb:pcmem=6gb
#PBS -l walltime=01:00:00
#PBS -l place=free:shared

source activate bio
echo "Started job `date`"


RUN="$WORKER_DIR/haplotype_gen.py"
MYROW=`head -n +${PBS_ARRAY_INDEX} $PROFILE | tail -n 1`
IFS=';' read -ra my_array <<< "$MYROW"
MYNAME=$my_array
MYOUT="$OUT_DIR/haplotypes/$MYNAME"


python $WORKER_DIR/haplotype_gen.py -f $FILE -n $MYNAME -m $MUTRATE -o $MYOUT


echo "Finished `date`"
