#!/bin/sh
gridid=$1
vegid=$2
irrigationtype=$3
outfilename="irrigation_param_id_${gridid}.txt"
current_path=$CWD
echo "Generating irrigation parameter for gridid $gridid with veg type $vegid and irrigation type $irrigationtype..."
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Management
line="$gridid 1\n    $vegid $irrigationtype\n"
echo $line > $outfilename
cd $current_path

