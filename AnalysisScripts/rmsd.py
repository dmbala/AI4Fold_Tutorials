# Computes RMSD between two pdb files - input1.pdb and input2.pdb. This is based on PyMOL's align function which does the sequence alignment first followed by the structure alignment. 

import pymol 
from pymol import cmd

pymol.cmd.load('input1.pdb')
pymol.cmd.load('input2.pdb')
res=pymol.cmd.align('input1', 'input2')
rmsd = float("{:.2f}".format(res[0]))
print("RMSD ", rmsd," Aligned-Atoms ", res[1], " Aligned-Residues ", res[6], sep=",")

