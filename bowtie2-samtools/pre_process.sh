#!/bin/bash
# March 4 2009
# Script for Laboratorio de biologia comparativa CIB
# By Jorge Mario Muñoz Pérez
# 1) indexing reference genome
# 2) aligning reads to reference indexed genome
# 3) convert .sam to .bam
# software needed
# bowtie2 version 2.3.3.1
# samtools version 1.8
# $1 threds
# $2 reference-genome
# $3 outfile index reference genome
############################ indexing reference genome
function index_reference {
mkdir $3 -p
bowtie2-build --threads $1 $2 $3
}
index_reference 8 dummy_reference.fa ./index_reference/index 
############################## align reads to indexed genome
# $1 threads
# $2 forward R1 path
# $3 reveres R2 path
# $4 fasta reference path
# $5 index reference out
function samples_to_bam {
    rev $2 | cut -d"/" -f1 | rev | cut -f1 -d"_" | sed 's/$/.sam/' > sam_list
    rev $2 | cut -d"/" -f1 | rev | cut -f1 -d"_" | sed 's/$/.bam/' > bam_list
    mkdir -p ./SAM-BAM/
    readarray forward < $2
    readarray reverse < $3
    readarray bam < bam_list
    a=0
    for i in $(cat sam_list)
    do
	echo
	echo verifying reads corresponding ${forward[$a]} with ${reverse[$a]}
	bowtie2 --threads $1 -x $5 -1 ${forward[$a]} -2 ${reverse[$a]} -S ./SAM-BAM/$i
	echo converting $i into ${bam[$a]}
	########################## Convert SAM to BAM
	samtools view -@ $1 -hb -T $4 ./SAM-BAM/$i | samtools sort -m 1800M -@ $1 -o ./SAM-BAM/${bam[$a]}
	rm -fv ./SAM-BAM/$i
	let a++
    done
}
samples_to_bam 8 lista_R1 lista_R2 reference_dummy.fa index_reference/index 
