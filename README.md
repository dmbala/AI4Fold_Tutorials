# AI4Fold_Tutorials

### Initial Setups

### Compute Accounts
*   Register for the Robetta server account https://robetta.bakerlab.org/register.php (takes about a minute)
*   For using colab, you need an active gmail account https://support.google.com/mail/answer/56256?hl=en (takes about a minute)
*   Amarel cluster account for Rutger's participants (requires Rutger's netid) fill this form https://oarc.rutgers.edu/amarel-cluster-access-request/

### SSH clients
    Chrome Browser - Secured Shell App: https://chrome.google.com/webstore/detail/secure-shell-app/pnhechapfaindjhompbnflcldabbghjo?hl=en
    Windows OS - git bash: https://gitforwindows.org/
    Others: puTTY, moabaxterm, winscp,

## Main Folders
    AF2 (AlphaFold2 examples - running with full db, reduced db, and msa+structure prediction)
    AnalysisScripts (scripts to get RMSD and pTM plots)
    RF (RoseTTAFold examples)


## How to get structure of a protein from its sequence. 

* Query PDB
* Query AlphaFoldDB  
* Do prediction on 
     * AF2 or RoseTTAFold servers
     * local cluster/workstation or external resources like  XSEDE, National Supercomputers, Cloud

## Pointers to external Resources
- Query PDB: https://www.rcsb.org/
- Query AlphaFoldDB https://alphafold.ebi.ac.uk/
- Robetta Server: https://robetta.bakerlab.org/
- AlphaFold Colab: https://colab.sandbox.google.com/github/deepmind/alphafold/blob/main/notebooks/AlphaFold.ipynb

## Local Clusters/Workstation

    Conda
    Docker/Singularity

### Submitting jobs to the cluster via SLURM

SSH into the cluster. For this step, you need to open a terminal, SSH client,  or web access method like Open Ondemand, Chrome Shell App, or Fastx. 

```
ssh <netid>@amarel.hpc.rutgers.edu
```

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


### Slides
https://drive.google.com/file/d/1AfIXfBuxTPMuU3v9M2XJjx2DxBXUaGAI/view?usp=sharing
