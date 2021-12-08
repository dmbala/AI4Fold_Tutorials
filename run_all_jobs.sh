cd ./AF2/1CBN_usemsas
sbatch run_cpu.slrm

cd ../../AF2/1CBN_reduced_db  
sbatch run_cpu.slrm

cd ../../AF2/1CBN  
sbatch run_cpu.slrm

cd ../../RF/1CBN  
sbatch run_cpu.slrm
