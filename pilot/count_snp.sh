#!/bin/bash
cd ..
# hay que agrgegar la estandarizacion del path

#encuentra mediante "find" todos los archivos que tienen un nombre que termina en "-vcf" y los copia en un archivo ubicado en donde se corre este
#script, 

#este archivo es leido para formar un array que contega todos los paths te de los archivos ".vcf" 

#luego imprimo el numero de arreglos que se incluyeron en el array

#hago un ciclo para cada path, cuento cuantos snp identificados debido a que las en los archivos ".vcf" las lineas correspondientes a snp'2
#comienzan con la palabra "locus", de manera que se cuenta las veces que se repite la palabra "locus" al inicio de cada archivos ".vcf" para 
# contar la cantidad de snp's por arreglo

#luego imprimo los arreglos de paths y numero de snp's correspondientes con un printf de manera que esta información pueda ser ingresada al pipeline
#de analisis utilizacion el archivo "smummary_vcf.txt que se crea al final" 

find "$(pwd -P)" -name "*.vcf" > listavcfls.txt # lista vcf 
mapfile -t lista_vcf < "$(pwd)/listavcfls.txt" # leo el archivo en un "array"
echo la cantidad de arreglos son ${#lista_vcf[@]} # cantidad de archivos .vcf

# ciclo para contar los snp en cada path alamcenado en el array
i=0
while [ $i -lt ${#lista_vcf[@]}  ] 
do
numsnp[$i]=$(grep ^locus ${lista_vcf[i]} -c)
let i=$i+1
done

# imprimos la informacion en un archivo con formato compatible con otras pipelines
paste <(printf '%s\n' "${lista_vcf[@]}") <(printf '%s\n' "${numsnp[@]}") > summary_vcf.txt
paste <(printf '%s\n' "${lista_vcf[@]}") <(printf '%s\n' "${numsnp[@]}")
