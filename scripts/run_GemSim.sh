#!/bin/sh

#PBS -l select=1:ncpus=2:mem=10gb
#PBS -l walltime=48:00:00
#PBS -l place=free:shared

source config.sh

#handling GemSim path issues
module load perl
REL_OUT=$(perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . "\n"' $OUT_DIR $GEMSIM)

GENOMES_DIR="$REL_OUT/haplotypes"
OUT="$OUT_DIR/mock"

cd $GEMSIM
echo "$GEMSIM/GemReads.py -R $GENOMES_DIR -a $PROFILE -n $NB_READS -l d -u d -m $MODEL -q 64 -o $OUT -p"

$GEMSIM/GemReads.py -R $GENOMES_DIR -a $PROFILE -n $NB_READS -l d -u d -m $MODEL -q 64 -o $OUT -p


