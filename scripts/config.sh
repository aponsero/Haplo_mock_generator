export CWD=$PWD
###### #Parameters for the run
# where the gemsim profile to prepare is
export PROFILE="/xdisk/bhurwitz/mig2020/rsgrps/bhurwitz/alise/my_data/Cory_project/artificial_communities/profile_5haplo.txt"
# Path to the Fasta genome to use
export FILE="/xdisk/bhurwitz/mig2020/rsgrps/bhurwitz/alise/my_data/Cory_project/dataset/CLCuMuV_WA01.fasta"
# total mutation rate (% of bases that will be mutated)
export MUTRATE="0.025"
# output directory
export OUT_DIR="/xdisk/bhurwitz/mig2020/rsgrps/bhurwitz/alise/my_data/Cory_project/artificial_communities/0.25mut_5haplo_100k"
# nb of illumina reads to generate
export NB_READS=100000

#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$PWD/scripts/workers"
export GEMSIM="$WORKER_DIR/GemSIM_v1.6_changed"
# path to gemsim error model to use
export MODEL="$GEMSIM/models/ill100v4_p.gzip"


# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}

#---------------------------------------------------
