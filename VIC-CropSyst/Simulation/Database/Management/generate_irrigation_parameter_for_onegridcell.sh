#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: $0 <1:gridid> <2:vegid> <3:irrigationtype>\n"
    exit 0
else
    gridid=$1
    vegid=$2
    irrigationtype=$3
fi

outfilename="irrigation_param_id_${gridid}.txt"
current_path=$CWD
echo "Generating irrigation parameter for gridid $gridid with veg type $vegid and irrigation type $irrigationtype..."
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Management
line="$gridid 1\n    $vegid $irrigationtype\n"
echo $line > $outfilename
cd $current_path

