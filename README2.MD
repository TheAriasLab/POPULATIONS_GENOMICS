# __GBS_Coco__

##  **Descripción**

1) Pipelines que integran varias herramientas para descubrir SNPs. Entre las que se encuentran:
stacks ,ipyrad y DiscoSnp++

http://catchenlab.life.illinois.edu/stacks/
http://ipyrad.readthedocs.io/
http://colibread.inria.fr/software/discosnp/

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





