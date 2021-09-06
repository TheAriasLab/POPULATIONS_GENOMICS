grep CM0 only_crhomosomes.vcf | cut -f1 | uniq > cromosomes.tsv

for i in $(cat cromosomes.tsv)
do
vcftools --vcf only_crhomosomes.vcf --chr $i --recode --out c_$i
done
rm *.log
#ls | grep recode.vcf > recode.tsv
for i in $(ls | grep .recode.vcf$)
do
PopLDdecay -OutStat ${i}_c1 -InVCF $i -MaxDist 120000 -Het 0.9 -Miss 0.1 -MAF 0.1 -SubPop ./c1_ids.txt
done
for i in $(ls | grep .recode.vcf$)
do
PopLDdecay -OutStat ${i}_c2 -InVCF $i -MaxDist 120000 -Het 0.9 -Miss 0.1 -MAF 0.1 -SubPop ./c2_ids.txt
done
for i in $(ls | grep .recode.vcf$)
do
PopLDdecay -OutStat ${i}_c3 -InVCF $i -MaxDist 120000 -Het 0.9 -Miss 0.1 -MAF 0.1 -SubPop  ./c3_ids.txt
done
for i in $(ls | grep .recode.vcf$)
do
PopLDdecay -OutStat ${i}_c4 -InVCF $i -MaxDist 120000 -Het 0.9 -Miss 0.1 -MAF 0.1 -SubPop  ./c4_ids.txt
done
for i in $(ls | grep .recode.vcf$)
do
PopLDdecay -OutStat ${i}_all -InVCF $i -MaxDist 120000 -Het 0.9 -Miss 0.1 -MAF 0.1 -SubPop  ./pacific_ids.txt
done
for i in $(ls | grep .recode.vcf$)
do
PopLDdecay -OutStat ${i}_pacific -InVCF $i -MaxDist 120000 -Het 0.9 -Miss 0.1 -MAF 0.1
done


ls | grep all.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output all_LD -bin1 2000 -bin2 1000000 -break 600

ls | grep c1.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c1_LD -bin1 2000 -bin2 3000000 -break 2000

ls | grep c2.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c2_LD -bin1 2000 -bin2 3000000 -break 600

ls | grep c3.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c3_LD -bin1 2000 -bin2 1000000 -break 600

ls | grep c4.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output c4_LD -bin1 2000 -bin2 1000000 -break 600

ls | grep pacific.stat.gz > C.chr.list
Plot_OnePop.pl -inList C.chr.list -output pacific_LD -bin1 2000 -bin2 1000000 -break 600

Plot_MultiPop.pl -inList multi.list -output all -keepR

