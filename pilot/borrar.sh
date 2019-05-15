# borrar carpetas y archivos viejos

rm /home/baya/jorge/GBS/MslI/ipyrad_log.txt /home/baya/jorge/GBS/MslI/log.txt -vf
rm /home/baya/jorge/GBS/MslI/RAW/MslI_R1_grep.fastq /home/baya/jorge/GBS/MslI/RAW/MslI_R2_grep.fastq -vf
rm /home/baya/jorge/GBS/MslI/RAW/*.txt -vf
rm /home/baya/jorge/GBS/MslI/RAW/MslI_R1.fastq.bz2 /home/baya/jorge/GBS/MslI/RAW/MslI_R2.fastq.bz2
rm /home/baya/jorge/GBS/MslI/ipyrad/MslI_* -Rfv
rm /home/baya/jorge/GBS/MslI/ipyrad/fastqc/* -Rfv
rm /home/baya/jorge/GBS/MslI/ipyrad/params/ipyrad_log.txt -fv
rm /home/baya/jorge/GBS/MslI/ipyrad/params/params-estricto* /home/baya/jorge/GBS/MslI/ipyrad/params/params-laxo* /home/baya/jorge/GBS/MslI/ipyrad/params/params-full.txt -vf
rm /home/baya/jorge/GBS/PstI-MspI/RAW/*.bz2 
rm /home/baya/jorge/GBS/PstI-MspI/RAW/*.fastq /home/baya/jorge/GBS/PstI-MspI/RAW/*.txt -vf
rm /home/baya/jorge/GBS/PstI-MspI/ipyrad/PM -Rfv
rm /home/baya/jorge/GBS/PstI-MspI/ipyrad/params/params-estricto* /home/baya/jorge/GBS/PstI-MspI/ipyrad/params/params-laxo* /home/baya/jorge/GBS/PstI-MspI/ipyrad/params/ipyrad_log.txt -vf
