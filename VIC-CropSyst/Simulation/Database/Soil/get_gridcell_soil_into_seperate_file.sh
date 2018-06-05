#!/bin/sh
gridid=$1
outfilename="soil_param_id_${gridid}.txt"
current_path=$CWD
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Soil
cat Umatilla_bigdomain_soil.txt | while read line
do
    #for word in $line
    #do
      #echo $word
    #done
    set $line
    #echo $2
    if [ $2 = $gridid ]; then
        echo "found: $2"
        echo $line > $outfilename
    fi
done
cd $current_path

