#!/bin/bash
# March 4 2019
# Script for runing stacks (refmap.pl and populations script)
# For Laboratorio de biologia comparativa CIB
# by Jorge Mario Muñoz Pérez
# Software needed ref_map.pl version 2.2
# populations version 2.1
# $1 directory with containing ONLY .bam files
# $2 hilos
# $3 out directory for refmap
# $4 popmap (tab separated ind(tab)pop/n)
# $5 populations cycles 
function run_stacks {

    export LD_LIBRARY_PATH
    LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH

    mkdir $3 -p
    echo running refmap.pl
    ref_map.pl -o $3 --popmap $4 -T $2 --samples $1
    for i in $(seq $5)
    do
	echo populations cicle number $i/$5
	mkdir $3/p$i -p
	populations -t $2 -P $3 -O ${3}/p${i} -M $4 -p $i -r 0.8 --min_maf 0.05 --max_obs_het 0.70 --phylip_var --phylip --vcf_haplotypes --genepop --write_random_snp --structure --vcf
    done
    exit
}
run_stacks ./../bowtie2-samtools/SAM-BAM/ 8 refmap popmap_ok 2
