#!/bin/sh

if [ $# -eq 0 ]; then
    #hard coded
    echo "Usage: " $0 " <grid_cell_id>"
    exit 0
else
    gridid=$1
fi

replacestring='s/\/home\/liuming\/Projects/\/data\/hydro\/users\/liumingdata\/Projects/g' 
sed -i ${replacestring} vic_control_$gridid.txt


/home/liuming/dev/VIC_CropSyst/build/gcc/Release/VIC_CropSyst -g vic_control_$gridid.txt
