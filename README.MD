# __Proyecto GBS para *Cocos nucifera*__

**Pipeline para el anlásis bioinformático de datos prevenientes de RADseq: GBS (MslI) y ddRAD (PstI-MspI) en *Cocos nucifera*** (con genoma de referencia) 

![alt text](https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/blob/master/basic-assembly-steps.png)


**Preprocesamiento steps (1y2) => procesamieto steps (3 al 7) => Analísis**

**Preprocesaiento** : remover contaminaciones de otras librerias => demultiplexado => verificar sitio de restricción => remover adaptadores

**Procesamiento**: establecer las reglas para llamar SNPs y filtrar los SNPs de acuerdo a esas reglas

**Analísis**: utilizar los SNPs encontrados para responder preguntas biológicas 


##  **Software necesario** 

* **ipyrad http://ipyrad.readthedocs.io/**    
	* Preprocesamiento, procesamiento
* **stacks http://catchenlab.life.illinois.edu/stacks/**
	* Preprocesamiento, procesamiento
* **fastqc https://www.bioinformatics.babraham.ac.uk/projects/fastqc/**
	* Preprocesamiento
* **PGDspider http://www.cmpg.unibe.ch/software/PGDSpider/**
	* Procesamiento
* **Bayescan http://cmpg.unibe.ch/software/BayeScan/**
	* Analísis
* **bowtie2 http://bowtie-bio.sourceforge.net/bowtie2/**
	* Preprocesamiento
* **Custom scripts**
	* Preprocesamiento, procesamiento, analísis
	*https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/tree/master/MslI/scripts
	*https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/tree/master/PstI-MspI/scripts


## **Funcionamiento de los scripts**

se busca comparar la cantidad de SNPs recuperados a partir de los dos tratamientos enzimáticos MslI y PstI-MspI

* _**IPYRAD**_

![alt text](https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/blob/master/assemblies-ipyrad_ok.png)

* **Preprocesamiento**

* pre_procesamiento_1_MslI.sh y pre_procesamiento_1_PM.sh

	* revisa los índices combinatorios (XXXXXX+XXXXXX) de los archivos RAW y crea un índice por cada archivo (R1 Y R2) que contiene una lista con los diferentes indices combinatorios y su frecuencia.
	* luego el programa elige el índice combinatorio que más se repite (en este caso en el 98% de los reads) y elimina los reads con otros indices combinatorios, estos reads con estos índices son producto de contaminaciones de otras librerias en el proceso de secuenciación
	* luego el programa verifica que solo haya un tipo de índice combinatorio en el nuevo archivo RAW y crea un nuevo archivo en donde se puede verificar la existencia de un solo índice manualmente.
	* luego corre el fastqc para revisar anomalías en la información
	
	
* pre_procesamiento_2_reference_MslI.sh y pre_procesamiento_1_reference_PM.sh

	* crea los archivos de parámetros para cada uno de los analísis teniendo en cuenta sus particularidades de manera AUTOMÁTICA :)
	* corre los pasos 1 y 2 del ipyrad que corresponden a demultiplexado, verificación del sitio de la enzima de restricción y remoción de adaptadores.
	* debido a la particularidad de ser altamente degenerado que tiene el sitio de restricción de MslI (NNRTG) y al hecho de que ipyrad no recibe más de un nucleotido degenerado al mismo tiempo en la secuencia de restricción de la enzima (en este caso N y R) se descompone el dominio de la enzima de restriccion de manera que solo se use *un* nucleotido degenerado de la siguiente manera
	**NNRTG = RRRTG, RCRTG, RTRTG, CRRTG, CCRTG, CTRTG, TRRTG, TCRTG, TTRTG**  se corre cada uno por separado y luego se unen de nuevo usando el parámetro -m en ipyrad
	
* **Procesamiento**

* wrapper_reference.sh y wrapper_2_reference.sh

	* en wrapper_reference.sh se unen los nueve analísis producto de los pasos 1 y 2 del ipyrad usando el parametro -m
	* se adiciona a los archivos de parametros de forma AUTOMÁTICA el PATH del genoma de referencia y el metodo de ensamblaje (denovo+reference en este caso)
	* se ramifica del anÃ¡lisis de forma AUTOMÁTICA de manera que se crea una rama *estricta* y una *laxo* en cuanto a las reglas para llamar SNPs a partir de los reads preprocesados, se varìan los parámetros 11, 12 ,14 , 23 del ipyrad
	* corre los pasos 3, 4, ,5 ,6 del ipyrad

* step_7_reference_MslI.sh y step_7_PM_reference.sh

	* paso de control para poder tener varios ensamblajes
	* se filtran los SNP's encontrados en los pasos anteriores de acuerdo al numero de veces que se repite el SNP en las 12 muestras, ensayamos con 1 repetición (2 individuos) , 2 repeticiones ,(4 individuos), 6 repeticiones (12 individuos, todos)
	* se ramifica el proceso de manera que se refleje la explicación anterior en el pipeline, se crean archivos de parametros con el sufijo min_sample_##
	
* _**STACKS**_

![alt text](https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/blob/master/assemblies_stacks_ok.png)

* **Preprocesaiento**
	
* pre_procesamiento_1_MslI.sh y pre_procesamiento_1_PM.sh (este paso es comùn a los analísis de stacks y ipyrad)

	* revisa los ìndices combinatorios (XXXXXX+XXXXXX) de los archivos RAW y crea un índice por cada archivo (R1 Y R2) que contiene una lista con los diferentes indices combinatorios y su frecuencia.
	* luego el programa elige el indice combinatorio que más se repite (en este caso en el 98% de los reads) y elimina los reads con otros indices combinatorios, estos reads con estos ìndices son producto de contaminaciones de otras librerias  	      en el proceso de secuenciación
	* luego el programa verifica que solo haya un tipo de índice combinatorio en el nuevo archivo RAW y crea un nuevo archivo en donde se puede verificar la existencia de un solo índice manualmente.
	* luego corre el fastqc para revisar anomalìas en la información

	
* process_radtags.sh

	* stacks tiene la particularidad de no aceptar barcodes de diferente tamaño para la demultiplexacion de las muestras           , entonces se corre el process_radtags tantas veces como grupos de barcodes haya
	* corre process_radtags tantas veces como grupos de barcodes haya
	* corre fasqc a los archivos resultantes para verificar anomalidades en los dato de forma manual
	
* **Procesamiento**
	
* refmap_MslI.sh y refmap_PM.sh

	* stacks no recibe los paired-end reads de la forma en que ipyrad lo hace por lo que hay que alinear los reads a un genoma de referencia y crear un único archivo .sam por cada muestra (en vez de dos)
	* refmap_MslI.sh debe ser corrido en primer lugar para que de forma automática haga los alineamientos muestra por muestra
	* se llama el script de stacks refmap.pl con todas las reglas para llamar los SNPs **en** los individuos y se ramfica en analísis **entre** los individuos de igual manera que en los scripts del pipeline ipyrad step_7_reference_MslI.sh y step_7_PM_reference.sh

* **Analísis**

* bayescan_input.sh 

	* se busca saber cuales loci son neutrales y cuales están bajo selección. En primer lugar usando *PGDspider* se cambia el formato de los output de ipyrad de stacks de la siguiente manera
	  .VCF => .PGD => .GESTE/Bayescan, de este modo se llevan los archivos al Bayescan que usa su **propio** formato, no se cambia directamente el formato VCF => GESTE/Bayescan porque se pierde información

* bayescan.sh  

	* llama bayescan_2.1 y corre busca clasificar los loci según sean neutrales o están bajo selección según los parámetros establecidos en el script
	
* bayescan_graph.r

	* script R para graficar los resultados provenientes de bayescan.sh, crea una grafica en donde se marcan los loci bajo selección y establece el False Discovery Rate (FDR) un parámetro para poder para identificar los loci bajo selección 


## **Arbol de directorios**

https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/blob/master/treefile.txt
