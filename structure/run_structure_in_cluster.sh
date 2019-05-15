#!/bin/bash
# Script for runing in structure (https://web.stanford.edu/group/pritchardlab/structure.html) in APOLO cluster (http://www.eafit.edu.co/apolo) 
# March 4 2019
# For laboratorio de biologia comparativa CIB
# by Jorge Mario Muñoz Pérez
# software needed structure 2.3.4
# designed to run through a slurm array in a slurm scheduler
# k from 1 to 6
# 10 reps by each k
# reps 250000
# burnin 25000
#SBATCH --partition=longjobs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=48:00:00
#SBATCH --job-name=struct_nomiss
#SBATCH -o result_%N_%j_%A_%a.out      # File to which STDOUT will be written
#SBATCH -e result_%N_%j_%A_%a.err      # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jomare1188@gmail.com
#SBATCH --array=0-59

export SBATCH_EXPORT=NONE
export OMP_NUM_THREADS=1

# for apolo
# module load structure/2.3.4_intel-2017_update-1
# for cronos
module load structure/2.3.4_intel-18.0.2
#export BASE=$PWD
export STR_INPUT=in.str
export MAINPARAMS_FILE=mainparams
export EXTRAPARAMS_FILE=extraparams
export m=${SLURM_ARRAY_TASK_ID}

let indv_number=125
let locus_number=27600
mkdir results
structure -i $STR_INPUT -N $indv_number -L $locus_number -m $MAINPARAMS_FILE -e $EXTRAPARAMS_FILE -K $(( $m % 6 + 1 )) -o ./results/structure_k$(( $m % 6 + 1 ))-$(( $m/6 + 1 ))
