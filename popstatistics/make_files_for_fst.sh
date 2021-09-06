vcftools --vcf only_crhomosomes.vcf --keep c1_ids.txt --recode --out c1_tmp
vcftools --vcf c1_tmp.recode.vcf --maf 0.05 --recode --out c1_maf
vcftools --vcf c1_maf.recode.vcf --site-pi --out pi_c1_maf
vcftools --vcf c1_maf.recode.vcf --TajimaD 100000 --out Tajima_c1_maf

vcftools --vcf only_crhomosomes.vcf --keep c2_ids.txt --recode --out c2_tmp
vcftools --vcf c2_tmp.recode.vcf --maf 0.05 --recode --out c2_maf
vcftools --vcf c2_maf.recode.vcf --site-pi --out pi_c2_maf
vcftools --vcf c2_maf.recode.vcf --TajimaD 100000 --out Tajima_c2_maf

vcftools --vcf only_crhomosomes.vcf --keep c3_ids.txt --recode --out c3_tmp
vcftools --vcf c3_tmp.recode.vcf --maf 0.05 --recode --out c3_maf
vcftools --vcf c3_maf.recode.vcf --site-pi --out pi_c3_maf
vcftools --vcf c3_maf.recode.vcf --TajimaD 100000 --out Tajima_c3_maf

vcftools --vcf only_crhomosomes.vcf --keep c4_ids.txt --recode --out c4_tmp
vcftools --vcf c4_tmp.recode.vcf --maf 0.05 --recode --out c4_maf
vcftools --vcf c4_maf.recode.vcf --site-pi --out pi_c4_maf
vcftools --vcf c4_maf.recode.vcf --TajimaD 100000 --out Tajima_c4_maf

vcftools --vcf only_crhomosomes.vcf --keep mixed_ids.txt --recode --out mixed_tmp
vcftools --vcf mixed_tmp.recode.vcf --maf 0.05 --recode --out mixed_maf
vcftools --vcf mixed_maf.recode.vcf --site-pi --out pi_mixed_maf
vcftools --vcf mixed_maf.recode.vcf --TajimaD 100000 --out Tajima_mixed_maf

