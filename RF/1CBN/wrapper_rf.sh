#!/bin/bash

STR=$(hostname -s)
SUB='amarel'
if [[ "$STR" == *"$SUB"* ]]; then
  echo "Please DON'T run on the login node. Submit to the compute node using SLURM"
  exit 1
fi

export PATH=/usr/lpp/mmfs/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
module purge
module load gcc/11.2 openmpi
module use /projects/community/modulefiles
module load ai-fold
source activate rf 
set -e

export PIPEDIR="/projects/community/ai-fold/2021/bd387/envs/rf/RoseTTAFold"
DB="/projects/community/ai-fold/2021/bd387/envs/rf/RoseTTAFold/pdb100_2021Mar03/pdb100_2021Mar03"

# Inputs:
IN="$1"                # input.fasta
WDIR=${PWD}  # working folder

CPU=$2  # number of CPUs to use
MEM=$3 # max memory (in GB)



mkdir -p $WDIR/log
echo "-----------variables----------------"
echo "WDIR"   $WDIR
echo "IN   " $IN 
echo "DB " $DB
echo "PIPEDIR" $PIPEDIR
echo "CPU" $CPU 
echo "MEM" $MEM

############################################################
# 1. generate MSAs
############################################################




if [ ! -s $WDIR/t000_.msa0.a3m ]
then

    echo "--------------------------------"
    echo "--time spend for make_msa.sh ---"
    bdate=$(date +%s)

    echo "Running HHblits"
    $PIPEDIR/input_prep/make_msa.sh $IN $WDIR $CPU $MEM > $WDIR/log/make_msa.stdout 2> $WDIR/log/make_msa.stderr

    edate=$(date +%s)
    echo $(( $bdate - $edate ))
    echo "--------------------------------"

fi


############################################################
# 2. predict secondary structure for HHsearch run
############################################################
if [ ! -s $WDIR/t000_.ss2 ]
then
    echo "--------------------------------"
    echo "--time spend for make_ss.sh ---"
    bdate=$(date +%s)

    echo "Running PSIPRED"
    $PIPEDIR/input_prep/make_ss.sh $WDIR/t000_.msa0.a3m $WDIR/t000_.ss2 > $WDIR/log/make_ss.stdout 2> $WDIR/log/make_ss.stderr

    edate=$(date +%s)
    echo $(( $bdate - $edate ))
    echo "--------------------------------"
fi


############################################################
# 3. search for templates
############################################################
if [ ! -s $WDIR/t000_.hhr ]
then
    echo "--------------------------------"
    echo "--time spend for hhsearch ---"
    bdate=$(date +%s)

    echo "Running hhsearch"
    HH="hhsearch -b 50 -B 500 -z 50 -Z 500 -mact 0.05 -cpu $CPU -maxmem $MEM -aliw 100000 -e 100 -p 5.0 -d $DB"
    cat $WDIR/t000_.ss2 $WDIR/t000_.msa0.a3m > $WDIR/t000_.msa0.ss2.a3m
    $HH -i $WDIR/t000_.msa0.ss2.a3m -o $WDIR/t000_.hhr -atab $WDIR/t000_.atab -v 0 > $WDIR/log/hhsearch.stdout 2> $WDIR/log/hhsearch.stderr

    edate=$(date +%s)
    echo $(( $bdate - $edate ))
    echo "--------------------------------"
fi


############################################################
# 4. end-to-end prediction
############################################################
if [ ! -s $WDIR/t000_.3track.npz ]
then
    echo "--------------------------------"
    echo "--time spend for predict_e2e.py ---"
    bdate=$(date +%s)

    echo "Running end-to-end prediction"
    python $PIPEDIR/network/predict_e2e.py \
        -m $PIPEDIR/weights \
        -i $WDIR/t000_.msa0.a3m \
        -o $WDIR/t000_.e2e \
        --hhr $WDIR/t000_.hhr \
        --atab $WDIR/t000_.atab \
        --db $DB 1> $WDIR/log/network.stdout 2> $WDIR/log/network.stderr

    edate=$(date +%s)
    echo $(( $bdate - $edate ))
    echo "--------------------------------"
fi
echo "Done"

