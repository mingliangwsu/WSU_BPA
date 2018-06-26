#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: $0 <1:gridid>\n"
    exit 0
else
    gridid=$1
fi

outfilename="soil_param_id_${gridid}.txt"
current_path=$CWD
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Soil
cat Umatilla_bigdomain_soil.txt | while read line
do
    set $line
    if [ $2 = $gridid ]; then
        echo "found: $2"
        echo $line > $outfilename
    fi
done
cd $current_path

