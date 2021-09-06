# Script to make venn comparisons between struture groups

Fgroups="/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/structure/distruct/groups/"
vcf_onlychromosomes="/home/j/BIOINFORMATICA/POPULATIONS_GENOMICS/stacks/refmap/p5/only_crhomosomes.vcf"

get_files () {
# 1) make vcf files for each structure group filtering individuals and removing maf  0.05
# 1.1) get files with structure grupus id
cp ${1}*ids.txt ./../data/
# 1.2) get vcf file with 19k SNPs
cp ${2} ./../data/
}

get_files ${Fgroups} ${vcf_onlychromosomes}

# filter group individuals with vcftools
filter_vcfs () {
    vcftools --vcf ./../data/only_crhomosomes.vcf --keep ${1} --out ${2} --recode
    mv *.log *.recode.vcf ./../data/
}

filter_vcfs ./../data/c1_ids.txt c1
filter_vcfs ./../data/c2_ids.txt c2
filter_vcfs ./../data/c3_ids.txt c3
filter_vcfs ./../data/c4_ids.txt c4
filter_vcfs ./../data/mixed_ids.txt mixed

## filter vcf by maf
filter_maf () {
    vcftools --vcf ./../data/${1} --maf 0.05 --recode --maf 0.05 --out $2
    mv ${2}.recode.vcf *.log ./../data/
}

filter_maf c1.recode.vcf c1_maf
filter_maf c2.recode.vcf c2_maf
filter_maf c3.recode.vcf c3_maf
filter_maf c4.recode.vcf c4_maf
filter_maf mixed.recode.vcf m_maf

# 2) get snps ids for each file
# 3) make venn comparisons

get_snps_ids () {
    grep "#" -v ${1} | cut -f3 > ${2}
}

get_snps_ids ./../data/c1_maf.recode.vcf ./../results/snp_id_c1.txt
get_snps_ids ./../data/c2_maf.recode.vcf ./../results/snp_id_c2.txt
get_snps_ids ./../data/c3_maf.recode.vcf ./../results/snp_id_c3.txt
get_snps_ids ./../data/c4_maf.recode.vcf ./../results/snp_id_c4.txt
get_snps_ids ./../data/mixed.recode.vcf  ./../results/snp_id_mixed.txt


# 3) make venn in http://bioinformatics.psb.ugent.be/cgi-bin/liste/Venn/calculate_venn.htpl




