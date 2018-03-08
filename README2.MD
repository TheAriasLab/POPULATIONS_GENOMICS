# __GBS_Coco__

##  **Descripción**

Pipelines que integran varias herramientas para descubrir SNPs. Entre las que se encuentran:
stacks: corre process_radtags y refmap.pl (genoma de referencia) para varios parámetros
ipyrad: corre ipyrad para varias configuraciones de parámetros (denovo,reference y parámetros relacionados con la clusterización)
DiscoSNP: Corre run_discoSnpRad.sh y discoRAD_finalization.sh

Scripts para realizar análisis de pobaciones en diferentes softwares
análisis para detectar locus bajo selecciòn - Bayescan
análisis para inferir la estructura de la pobación - Structure
análisis para inferir la estructura de la pobación - FastStructure

##  **Instalación**

git clone https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS.git


##  **Uso**

cd POOPULATIONS_GENOMICS/MslI/scripts

para correr ipyrad con genoma de referencia (poner cual es el genoma de referencia)

bash ./ipyrad_MslI.sh

para correr ipyrad de novo

bash ./ipyrad_MslI_denovo.sh

para correr stacks con genoma de referencia 

bash ./stacks_Msli.sh

para correr Bayescan

bash ./bayescan.sh

para correr faststructure

bash ./bayescan.sh





