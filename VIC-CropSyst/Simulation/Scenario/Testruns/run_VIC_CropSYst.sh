#!/bin/sh

if [ $# -eq 0 ]; then
    #hard coded
    gridid=307255
else
    gridid=$1
fi
/home/liuming/dev/VIC_CropSyst/build/Qt/Linux_gcc/Debug/VIC_CropSyst -g vic_control_$gridid.txt
