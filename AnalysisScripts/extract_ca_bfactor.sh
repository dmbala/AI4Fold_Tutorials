#!/bin/bash
export PATH="/usr/lpp/mmfs/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
module use /projects/community/modulefiles
module load ai-fold
source activate af2
echo -n "" > comb.tmp.dat
for i in ranked_*.pdb
do 
    cp comb.tmp.dat 1.tmp.dat 
    #grep "ATOM" $i | grep CA | awk '{print $6"   "$(NF-1)}' > 2.tmp.dat
    grep "ATOM" $i | grep CA | cut -c23-28,61-68 > 2.tmp.dat
    paste 1.tmp.dat 2.tmp.dat > comb.tmp.dat
done 
echo "ResID,pTM1,pTM2,pTM3,pTM4,pTM5" > ca_pTMs.csv
awk '{print $1",  "$2",   "$4",   "$6",  "$8",  "$10}' comb.tmp.dat >> ca_pTMs.csv
rm 1.tmp.dat 2.tmp.dat comb.tmp.dat

python ./allpTM_plots.py
python ./top_pTM_plot.py
