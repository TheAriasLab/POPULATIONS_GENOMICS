#!/bin/bash
# 5 March 2019
# Script for running structure harvester from structure output and visualize evanno's method output for choosing best k
# For Laboratorio de biologia comparativa
# by Jorge Mario Muñoz Pérez
# Software Needed
# structureHarvester.py v0.6.94
# R
# $1 path to structure results dir
# $2 path to output files
function structure_harvester {
	structureHarvester.py --dir=$1 --out=$2
	structureHarvester.py --dir=$1 --out=./../clumpp --clump
	grep '^[0-9]' summary.txt > for_calculate_deltak.txt
}
structure_harvester ./../results/ .
# script for calculate deltak from for_calculate_deltak.txt in R
# performs Evanno et al. (2005) method for choose best k
Rscript --vanilla evanno.r

