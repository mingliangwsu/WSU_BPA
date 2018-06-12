#!/bin/sh
cd /home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns
celllist="309119 308201 307255 310974 309115 311900 308199 307260 308179 308186 310037"
for cell in $celllist
do
    echo "$cell"
    sh ./run_VIC_CropSYst.sh $cell
done
