#!/bin/bash
export PATH="/usr/lpp/mmfs/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
module use /projects/community/modulefiles
module load ai-fold
source activate af2

cp  1CBN.pdb input1.pdb
for i in af2*.pdb rf*.pdb
do
    echo -n  "$j - $i  : "
    cp $i input2.pdb
    python ./rmsd.py  > rmsd_ranked_pdbs.dat
done
rm input?.pdb 
