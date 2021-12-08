#!/bin/bash
#export TF_FORCE_UNIFIED_MEMORY=1
#export XLA_PYTHON_CLIENT_MEM_FRACTION=4.0

export PATH=/usr/lpp/mmfs/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
module load gcc/11.2 openmpi
module use /projects/community/modulefiles
module load ai-fold
#source /projects/community/ai-fold/2021/bd387/etc/profile.d/conda.sh
#conda activate af2
source activate af2

export DB_DIR="/projects/community/alphafold/dbs/reduced_dbs"
export BIN_DIR="/projects/community/ai-fold/2021/bd387/envs/af2/bin/"

input_fasta_file=$1
output_data_dir=$2
echo "input fasta file"
echo $input_fasta_file
echo "Output data directory"
echo $output_data_dir

python /projects/community/ai-fold/2021/bd387/envs/af2/alphafold/run_alphafold.py --helpshort
python /projects/community/ai-fold/2021/bd387/envs/af2/alphafold/run_alphafold.py \
    --data_dir=$DB_DIR \
    --uniref90_database_path=$DB_DIR/uniref90/uniref90.fasta \
    --mgnify_database_path=$DB_DIR/mgnify/mgy_clusters_2018_12.fa \
    --small_bfd_database_path=$DB_DIR/small_bfd/bfd-first_non_consensus_sequences.fasta \
    --pdb70_database_path=$DB_DIR/pdb70/pdb70 \
    --template_mmcif_dir=$DB_DIR/pdb_mmcif/mmcif_files/ \
    --obsolete_pdbs_path=$DB_DIR/pdb_mmcif/obsolete.dat \
    --model_preset=monomer_ptm \
    --db_preset=reduced_dbs \
    --fasta_paths=$input_fasta_file \
    --output_dir=$output_data_dir \
    --max_template_date=2020-05-14 \
    --use_precomputed_msas

