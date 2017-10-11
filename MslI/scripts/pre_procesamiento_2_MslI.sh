


# pasos 1 y 2 del ipyrad 
cd /home/baya/jorge/GBS/MslI/ipyrad
mkdir fastqc
# creo los ensambles en pyrad teniendo en cuenta que hay que correrlo 9 veces para poder tener en cuenta todos los sitios de la enzima de restriccion  (NNRTG EN TERMINOS DE ATGC Y R (R=A o G))
# en otras palabras NNRTG = RRRTG, RCRTG, RTRTG, CRRTG, CCRTG, CTRTG, TRRTG, TCRTG, TTRTG. A cada muestra le corro el fastqc.

limite=9
i=1 
while [ $limite -ge $i ] 
do 
 	ipyrad -p /home/baya/jorge/GBS/MslI/ipyrad/params/params-coco_$i.txt -r -f -s 12
	mkdir /home/baya/jorge/GBS/MslI/ipyrad/fastqc/corrida_$i
	perl /home/baya/FastQC/fastqc /home/baya/jorge/GBS/MslI/ipyrad/MslI_$i/MslI_$[i]_fastqs/*.fastq.gz -o /home/baya/jorge/GBS/MslI/ipyrad/fastqc/corrida_$i
let i=$i+1
done




