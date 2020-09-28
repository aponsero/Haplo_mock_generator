#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -f "$PROFILE" ]]; then
    echo "$PROFILE does not exist. Please provide the path for a metagenome profile. Job terminated."
    exit 1
fi

if [[ ! -f "$FILE" ]]; then
    echo "$FILE does not exist. Please provide the path for the genome to use to create the community. Job terminated."
    exit 1
fi

if [[ ! -d "$OUT_DIR" ]]; then
    echo "$OUT_DIR does not exist. The folder was created."
    mkdir $OUT_DIR
fi

#
# Job submission
#

ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01- Run haplo creation script
#

PROG="01-haplo_mutation"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"
init_dir "$OUT_DIR/haplotypes"

echo "launching $SCRIPT_DIR/run_haplo.sh as an array job."

export NUM_HAPLO=$(wc -l < "$PROFILE")

if [[ $NUM_HAPLO -eq 0 ]]; then
  echo "Empty profile in  $PROFILE, please correct the file. Job terminated."
  exit 1
fi

JOB_ID=`qsub $ARGS -v WORKER_DIR,OUT_DIR,PROFILE,FILE,MUTRATE,STDERR_DIR,STDOUT_DIR -N run_calculator -e "$STDERR_DIR" -o "$STDOUT_DIR" -J 1-$NUM_HAPLO $SCRIPT_DIR/run_haplo.sh`
    

if [ "${JOB_ID}x" != "x" ]; then
        echo Job: \"$JOB_ID\"
        PREV_JOB_ID=$JOB_ID
else
        echo Problem submitting job. Job terminated.
        exit 1
fi


## 02 -Create metagenome
#


PROG2="02-CreateMeta"
export STDERR_DIR2="$SCRIPT_DIR/err/$PROG2"
export STDOUT_DIR2="$SCRIPT_DIR/out/$PROG2"


init_dir "$STDERR_DIR2" "$STDOUT_DIR2"

echo " launching $SCRIPT_DIR/run_GemSim.sh in queue"
echo "previous job ID $PREV_JOB_ID"

JOB_ID=`qsub $ARGS -v WORKER_DIR,GEMSIM,OUT_DIR,PROFILE,NB_READS,MODEL,STDERR_DIR2,STDOUT_DIR2 -N create_Meta -e "$STDERR_DIR2" -o "$STDOUT_DIR2" -W depend=afterok:$PREV_JOB_ID $SCRIPT_DIR/run_GemSim.sh`

if [ "${JOB_ID}x" != "x" ]; then
        echo Job: \"$JOB_ID\"
        PREV_JOB_ID=$JOB_ID
else
        echo Problem submitting job. Job terminated.
        exit 1
fi






