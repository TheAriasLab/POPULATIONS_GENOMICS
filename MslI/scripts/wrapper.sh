#!/bin/bash
#########################################################      2    #########################################################################################################################################
#########################################################      3    #########################################################################################################################################
#########################################################      4    #########################################################################################################################################

cd /home/baya/jorge/GBS/MslI/ipyrad/params

# uno los parametros de cada una de las 9 corridas para seguir analizando en los pasos posteriores del ipyrad todo como un conjunto
ipyrad -m full params-coco_1.txt params-coco_2.txt params-coco_3.txt params-coco_4.txt params-coco_5.txt params-coco_6.txt params-coco_7.txt params-coco_8.txt params-coco_9.txt 

#ramifico para crear un analisis laxo y uno estricto
ipyrad -p /home/baya/jorge/GBS/MslI/ipyrad/params/params-full.txt -r -f -b laxo 
ipyrad -p /home/baya/jorge/GBS/MslI/ipyrad/params/params-full.txt -r -f -b estricto 
# modifico el archivo params para que tengan efecto los cambios "estrictos"
sed -i '/\[11] /c\6  ## [11] ' params-laxo.txt
sed -i '/\[12] /c\6  ## [12] ' params-laxo.txt
sed -i '/\[14] /c\0.90  ## [14] ' params-estricto.txt
sed -i '/\[23] /c\1, 1  ## [23] ' params-estricto.txt

#corrro el pasos del 3 al 6 para cada analisis
ipyrad -p /home/baya/jorge/GBS/MslI/ipyrad/params/params-laxo.txt -r -f -s 3456 
ipyrad -p /home/baya/jorge/GBS/MslI/ipyrad/params/params-estricto.txt -r -f -s 3456 





#comienza el analisis con stacks teniendo en cuenta que no acepta barcodes de diferente tamaño y en este caso hay barcodes de 5, 6, 7 y 8 pb por lo que hay que correrlo 4 veces
#corro el process_radtags

#limite=8
#i=5
#while [ $limite -ge $i ] 
#do 
#	process_radtags -1 /home/baya/jorge/GBS/GBS_RAW/Group_MslI/MslI_R1_grep.fastq -2 /home/baya/jorge/GBS/GBS_RAW/Group_MslI/MslI_R2_grep.fastq -o /home/baya/jorge/GBS/GBS_RAW/Group_MslI/stacks/process_radtags -b /home/baya/jorge/GBS/GBS_RAW/Group_MslI/stacks/barcodes_stacks$i.txt -c -q --inline_null --renz_1 msli --renz_2 msli --barcode_dist_1 0

#let i=$i+1
#done


#corro el fastqc para los archivos de stacks
#perl /home/baya/FastQC/fastqc /home/baya/jorge/GBS/GBS_RAW/Group_MslI/stacks/process_radtags/* -o /home/baya/FastQC/stacks

 
######################################################      5     ##########################################################################################################################################




#pendiente

#2)revisar los parametros del stacks para correr el denovo.pl
#3)explorar datos arrojados por el ipyrad


 








