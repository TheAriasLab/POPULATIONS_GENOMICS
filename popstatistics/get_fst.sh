vcftools --vcf only_crhomosomes.vcf --weir-fst-pop atlantic_ids.txt --weir-fst-pop pacific_ids.txt --out atl-pac 
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop atlantic_ids.txt --weir-fst-pop c3_ids.txt --out atl-c3
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop atlantic_ids.txt --weir-fst-pop mixed_ids.txt --out atl-mix

vcftools --vcf only_crhomosomes.vcf --weir-fst-pop pacific_ids.txt --weir-fst-pop c3_ids.txt --out pac-c3
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop pacific_ids.txt --weir-fst-pop mixed_ids.txt --out pac-mix

vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c3_ids.txt --weir-fst-pop mixed_ids.txt --out  c3-mix
# grpups

vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c1_ids.txt --weir-fst-pop c2_ids.txt --out  c1-c2
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c1_ids.txt --weir-fst-pop c3_ids.txt --out  c1-c3
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c1_ids.txt --weir-fst-pop c4_ids.txt --out  c1-c4
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c1_ids.txt --weir-fst-pop mixed_ids.txt --out  c1-mixed

vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c2_ids.txt --weir-fst-pop c3_ids.txt --out c2-c3
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c2_ids.txt --weir-fst-pop c4_ids.txt --out c2-c4
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c2_ids.txt --weir-fst-pop mixed_ids.txt --out c2-mixed

vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c3_ids.txt --weir-fst-pop c4_ids.txt --out c3-c4
vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c3_ids.txt --weir-fst-pop mixed_ids.txt --out c3-mixed

vcftools --vcf only_crhomosomes.vcf --weir-fst-pop c4_ids.txt --weir-fst-pop mixed_ids.txt --out c4-mixed

# get files for pi and Tajima





#
vcftools --vcf altantic_maf.recode.vcf --site-pi --out pi_atlantic
vcftools --vcf altantic_maf.recode.vcf --TajimaD 100000 --out Tajima_atlantic

vcftools --vcf pacific_maf.recode.vcf --TajimaD 100000 --out Tajima_pacific
vcftools --vcf pacific_maf.recode.vcf --site-pi --out pi_pacific


