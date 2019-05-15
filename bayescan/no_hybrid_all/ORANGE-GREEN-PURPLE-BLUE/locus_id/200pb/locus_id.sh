#!/bin/bash
# script for extract snp flanking sequence in reference genome
VCF_FILE=/home/jorge/old/stacks_output/stacks_p5.vcf
SNP_LIST=$(cat /home/jorge/old/stacks_output/no_hybrid_all/ORANGE-GREEN-PURPLE-BLUE/locus_id/snp_list.txt)
REF=/home/jorge/old/COCOS_NUCIFERA_REFERENCE_GENOME/CoConut.genome.fa
RANGE=200
## cut vcf into header and genotype data
grep ^# -v $VCF_FILE > genotype.txt
##
for i in $SNP_LIST
do
	echo working on locus $i
	mkdir locus_$i -p && cd locus_$i
	sed -n ${i}p ./../genotype.txt | cut -f1,2 > ${i}_direction.txt
	grep -A1 -w ">$(cut -f1 ${i}_direction.txt)" ${REF} > $(cut -f1 ${i}_direction.txt).txt
	let SNP=$(cut -f2 ${i}_direction.txt)
	let ll=$SNP-$RANGE
	let hl=$SNP+$RANGE
	cut -c $ll-$hl $(cut -f1 ${i}_direction.txt).txt > ${RANGE}bpx2_locus_${i}_for_blast.txt && sed -i 1d ${RANGE}bpx2_locus_${i}_for_blast.txt
	blastn -query ${RANGE}bpx2_locus_${i}_for_blast.txt -db nt -out ${i}_blastn.out -task blastn -remote
	sleep 30
	blastn -query ${RANGE}bpx2_locus_${i}_for_blast.txt -db nt -out ${i}_megablast.out -task megablast -remote
	sleep 30
	blastn -query ${RANGE}bpx2_locus_${i}_for_blast.txt -db nt -out ${i}_dc-megablast.out -task dc-megablast -remote
	sleep 30
	blastn -query ${RANGE}bpx2_locus_${i}_for_blast.txt -db nt -out ${i}_tax_megablast.out -task megablast -window_masker_taxid 13894 -remote
	sleep 30
	blastn -query ${RANGE}bpx2_locus_${i}_for_blast.txt -db nt -out ${i}_tax_blastn.out -task blastn -window_masker_taxid 13894 -remote
	sleep 30
	blastn -query ${RANGE}bpx2_locus_${i}_for_blast.txt -db nt -out ${i}_tax_dc-megablast.out -task dc-megablast -window_masker_taxid 13894 -remote
	sleep 30
	cd ..
done



