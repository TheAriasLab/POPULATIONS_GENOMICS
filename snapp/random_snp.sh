#!/bin/bash
# sample random number of snps in fasta alignment
size=100
fasta=for_snapp_filtered_NOhybrid5.fa
grep "^>" $fasta > headers
grep -v "^>" $fasta > sequences

let SNPS=$(head -n1 sequences | wc -c)
let SNPS=$SNPS-1
seq 1 1 $SNPS> list_loci
shuf list_loci | head -n$size  > list_random_loci
wc -l list_random_loci

for i in $(cat list_random_loci)
do
	cut -c${i} sequences > loci_$i
done

paste -d "" loci_*  > filtered
rm ${size}_NH.fa loci_* 

a=0
readarray headers_array < headers
for i in $(cat filtered)
do
echo ${headers_array[$a]} >> ${size}_NH.fa
echo $i >> ${size}_NH.fa
let a++
done


