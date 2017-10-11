#comienza el analisis con stacks teniendo en cuenta que no acepta barcodes de diferente tamaño y en este caso hay barcodes de 5, 6, 7 y 8 pb por lo que hay que correrlo 4 veces
#corro el process_radtags

limite=8
i=5
while [ $limite -ge $i ] 
do 
    echo ................................estoy en el ciclo $i
    mkdir /home/baya/jorge/GBS/MslI/stacks/process_radtags/corrida_$i
	process_radtags -1 /home/baya/jorge/GBS/MslI/RAW/MslI_R1_grep.fastq -2 /home/baya/jorge/GBS/MslI/RAW/MslI_R2_grep.fastq -o /home/baya/jorge/GBS/MslI/stacks/process_radtags/corrida_$i -b /home/baya/jorge/GBS/MslI/stacks/barcodes/barcode_$i -c -s 20 -q --renz_1 msli --renz_2 msli --barcode_dist_1  0 --barcode_dist_2 0 --inline_null -i fastq
	
	mkdir /home/baya/jorge/GBS/MslI/stacks/fastqc/corrida_$i
	perl /home/baya/FastQC/fastqc /home/baya/jorge/GBS/MslI/stacks/process_radtags/corrida_$i/*.fq -o /home/baya/jorge/GBS/MslI/stacks/fastqc/corrida_$i

let i=$i+1
done



