#!/bin/bash
# Script for running distruct using the results given by clumpp in run_clumpp.sh
# For laboratorio de biologia comparativa CIB
# by Jorge Mario Muñoz Pérez
# Software needed distructLinux1.1
# Need to configure drawparams, coco.indivq, coco.languages, coco.names, coco.perm, coco.ps
# $1 clumpp.out file
function run_distruct {
    cp $1 .
    distructLinux1.1 -o $2
}
run_distruct ./../clumpp/K4.clumpp.out K4_distruct.out
