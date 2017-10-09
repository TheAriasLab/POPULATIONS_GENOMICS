
# hace coincidir los paths en mi pc y en el pc de la cib para cuestiones de compatibilidad
#grep -rl '/baya/jorge/GBS/' ./ | xargs sed -i 's#/baya/jorge/GBS/#/baya/jorge/GBS/#g' # del pc de la cib a mi casa
#grep -rl '/baya/jorge/GBS/' ./ | xargs sed -i 's#/baya/jorge/GBS/#/baya/baya/jorge/GBS/#g' # de mi pc al pc de la cib


#cargar los archivos test 
cp /home/baya/jorge/MslI/RAW/test/MslI_R1.fastq.bz2 /home/baya/jorge/GBS/MslI/RAW/test -v
cp /home/baya/jorge/MslI/RAW/test/MslI_R2.fastq.bz2 /home/baya/jorge/GBS/MslI/RAW/test -v

cp /home/baya/jorge/PstI-MspI/RAW/test/PM_R1.fastq.bz2 /home/baya/jorge/GBS/PstI-MspI/RAW/test -v
cp /home/baya/jorge/PstI-MspI/RAW/test/PM_R2.fastq.bz2 /home/baya/jorge/GBS/PstI-MspI/RAW/test -v


# cargar archivos originales completos
cp /home/baya/jorge/MslI/RAW/MslI_R1.fastq.bz2 /home/baya/jorge/GBS/MslI/RAW/ -v
cp /home/baya/jorge/MslI/RAW/MslI_R2.fastq.bz2 /home/baya/jorge/GBS/MslI/RAW/ -v

#rm /home/baya/jorge/MslI/RAW/test/original/MslI_R1.fastq.bz2 /home/baya/jorge/GBS/MslI/RAW/test/original/MslI_R2.fastq.bz2 -v

cp /home/baya/jorge/PstI-MspI/RAW/PM_R1.fastq.bz2 /home/baya/jorge/GBS/PstI-MspI/RAW/ -v
cp /home/baya/jorge/PstI-MspI/RAW/PM_R2.fastq.bz2 /home/baya/jorge/GBS/PstI-MspI/RAW/ -v

#rm /home/baya/jorge/PstI-MspI/RAW/test/original/PM_R2.fastq.bz2 /home/baya/jorge/PstI-MspI/RAW/test/original/PM_R1.fastq.bz2 -v

#correr los scripts
echo .................................................... MslI pasos 1 y 2 
bash /home/baya/jorge/GBS/MslI/scripts/pre_procesamiento_MslI.sh    #  MslI pasos 1 y 2
echo .................................................... PM pasos 1 y 2 
bash /home/baya/jorge/GBS/PstI-MspI/scripts/pre_procesamiento_PM.sh #pasos PM 1 y 2
echo .................................................... PM pasos 3 al 6 
bash /home/baya/jorge/GBS/PstI-MspI/scripts/wrapper_2.sh           # PM      pasos 3 al 6
echo .................................................... MslI pasos 3 al 6 
bash /home/baya/jorge/GBS/MslI/scripts/wrapper.sh                  # MslI         pasos 3 al 6
echo .................................................... PM paso 7
bash /home/baya/jorge/GBS/PstI-MspI/scripts/step_7_PM.sh            # PM      paso 7
echo .................................................... MslI paso 7
bash /home/baya/jorge/GBS/MslI/scripts/step_7_MslI.sh                # MslI    paso 7







