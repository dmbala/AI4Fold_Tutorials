# AI4Fold_Tutorials

* AF2 (AlphaFold2 examples - running with full db, reduced db, and msa+structure prediction)
* AnalysisScripts (scripts to get RMSD and pTM plots)
* RF (RoseTTAFold examples)


## How to get structure of a protein from its sequence. 

* Query PDB
* Query AlphaFoldDB  
* Do prediction on 
     * AF2 or RoseTTAFold servers
     * local cluster/workstation or external resources like  XSEDE, National Supercomputers, Cloud

## Pointers to external Resources
Query PDB: https://www.rcsb.org/
Query AlphaFoldDB https://alphafold.ebi.ac.uk/
Robetta Server: https://robetta.bakerlab.org/
AlphaFold Colab: https://colab.sandbox.google.com/github/deepmind/alphafold/blob/main/notebooks/AlphaFold.ipynb

## Local Clusters/Workstation

* Conda
* Docker/Singularity

### Submitting jobs to the cluster via SLURM

Clone this repository
```
>  git clone https://github.com/dmbala/AI4Fold_Tutorials
```
(On Amarel cluster, try "cp -r /projects/oarc/users/training/AI4Fold AI4Fold_Tutorial")
```
>  cd AI4Fold_Tutrials
```
To run all the jobs
```
> ./run_all_jobs.sh
```
Now check your jobs:
```
> squeue -u <netid> 
```
Note that if you are not running this on the Amarel clsuter, please modify the db and bin path in the wrapper scripts, and  change the patition names and other parameters specific to your local cluster. 




