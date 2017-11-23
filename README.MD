# __Proyecto GBS para *Cocos nucifera*__

pipeline para el anlísis bioinformático de datos prevenientes de RADseq: GBS (MslI) y ddRAD (PstI-MspI) en *Cocos nucifera*

preprocesaiento => procesamieto => Analísis

preprocesaiento : remover contaminaciones de otras librerias => demultiplexado => verificar sitio de restricción => remover adaptadores



##  **Software necesario** 

* ipyrad http://ipyrad.readthedocs.io/
* stacks http://catchenlab.life.illinois.edu/stacks/
* fastqc https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
* PGDspider http://www.cmpg.unibe.ch/software/PGDSpider/
* Bayescan http://cmpg.unibe.ch/software/BayeScan/
* Custom scripts (para limpiar reads contaminantes de otras librerias, para conocer todos los sitos de restriccion posibles de Msli)



## **Funcionamiento de los scripts**

se busca comparar la cantidad de SNPs recuperados a partir de los dos tratamientos enzimáticos MslI y PstI-MspI

https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/tree/master/MslI/scripts
https://github.com/BiologiaComparativaCiB/POPULATIONS_GENOMICS/tree/master/PstI-MspI/scripts

* **preprocesaiento**
* ipyrad
* pre_procesamiento_1_MslI.sh y pre_procesamiento_1_PM.sh
	revisa los indices combinatorios (XXXXXX+XXXXXX) de los archivos RAW y crea un indice por cada archivo (R1 Y   	      	        	R2) que contiene una lista con los diferentes indices combinatorios y su frecuencia.
	
	luego el programa elige el indice combinatorio que más se repite (en este caso en el 98% de los reads) y elimina los 	     	     reads con otros indices combinatorios, estos reads con estos índices son producto de contaminaciones de otras librerias  	      en el proceso de secuenciación
	
	luego el programa verifica que solo haya un tipo de índice combinatorio en el nuevo archivo RAW y crea un nuevo archivo 	en donde se puede verificar la existencia de un solo índice manualmente.
	luego corre el fastqc para revisar anomalías en la información
	
* pre_procesamiento_2_reference_MslI.sh y pre_procesamiento_1_reference_PM.sh

	crea los archivos de parámetros de manera AUTOMÁTICA :)
	
	corro los pasos 1 y 2 del ipyrad que corresponden a demultiplexado, verificación del sitio de la enzima de restricción     	    y remoción de adaptadores.
	
	Debido a la particularidad de ser altamente degenerado que tiene el sitio de restricción de MslI (NNRTG) y al hecho de 	    	    que ipyrad no recibe más de un nucleotido degenerado al mismo tiempo en la secuencia de restricción de la enzima (en 	 esta caso N y R) se descompone el dominio de la enzima de restriccion de manera que solo se use un          	       		nucleotido degenerado de la siguiente manera
	
	**NNRTG = RRRTG, RCRTG, RTRTG, CRRTG, CCRTG, CTRTG, TRRTG, TCRTG, TTRTG**
	se corre cada uno por separado y luego 	se unen de nuevo usando el parámetro -m 
	
* wrapper_reference.sh y wrapper_2_reference.sh




	
	
	
	









## **Arbol de directorios**

### **Resumen corridas en ipyrad**
* **summary_ipyrad**

### **Enzimas de restriccion usadas**

* **MslI**
	* ipyrad: analisis en ipyrad
		* barcodes: barcodes para identificar cada muestra
		* fastqc : carpeta con los analisis de fastqc para los archivos RAW y preprocesados
		* params : carpeta con los archhivos de parametros para correr los analisis en ipyrad
		* popfiles : carpeta con los popfile para cada uno de los analisis en ipyrad
		* MslI_#(1-9): debido a que se debe correr el ipyrad 9 veces (debido la forma de introducir el sitio de corte de la enzima de restriccion MslI, que se tiene que hacer por partes),
		* MslI_1 : aqui estan todos los outfiles de los analisis de ipyrad

	* stacks: analisis en stacks
	* RAW: archivos iniciales y preprocesados para esta enzima
		* test: archivos de prueba (alrededor de un 2.5% de los originales) para verificar funcionalidad de los scripts de manera rapida
	* info: informacion suministrada por la gente que secuencio 
	* MslI_R1.fastq.bz2  MslI_R2.fastq.bz2: archivos de trabajo comprimidos
	* MslI_R1_grep.fastq  MslI_R2_grep.fastq: archivos de trabajo con los reads de otras librerias filtrados
	* indice_1_cut.txt  indice_2_cut.txt: lista filtrada de indices de bibliotecas contaminantes
	* indice_1.txt      indice_2.txt: lista con los indices de diferentes bibliotecas para filtrarlos






* **PstI_MspI**
	* ipyrad: analisis en ipyrad
		* barcodes: barcodes para identificar cada muestra
		* fastqc : carpeta con los analisis de fastqc para los archivos RAW y preprocesados
		* params : carpeta con los archhivos de parametros para correr los analisis en ipyrad
		* popfiles : carpeta con los popfile para cada uno de los analisis en ipyrad		
		* PM : aqui estan todos los outfiles de los analisis de ipyrad

	* stacks: analisis en stacks
	* RAW: archivos iniciales y preprocesados para esta enzima
		* test: archivos de prueba (alrededor de un 2.5% de los originales) para verificar funcionalidad de los scripts de manera rapida
	* info: informacion suministrada por la gente que secuencio 
	* PM_R1.fastq.bz2  PM_R2.fastq.bz2: archivos de trabajo comprimidos
	* PM_R1_grep.fastq  PM_R2_grep.fastq: archivos de trabajo con los reads de otras librerias filtrados
	* indice_1_cut.txt  indice_2_cut.txt: lista filtrada de indices de bibliotecas contaminantes
	* indice_1.txt      indice_2.txt: lista con los indices de diferentes bibliotecas para filtrarlos




### Scripts globales

* **piloto_coco.sh**
	* script gobal que llama al resto de scripts para poder correr el analisis completo
* **borrar.sh**
	* borra los archivos de corridas pasadas para evitar conflictos: este scritp debe ir aparte de piloto_coco.sh por cuestiones de seguirdad

tiempo de corrida : 6783m6.296s = 4.783 días
