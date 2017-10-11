# __Proyecto GBS para *Cocos nucifera*__

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
