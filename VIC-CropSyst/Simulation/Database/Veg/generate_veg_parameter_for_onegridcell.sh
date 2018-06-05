#!/bin/sh
gridid=$1
vegid=$2
outfilename="veg_param_id_${gridid}.txt"
current_path=$CWD
echo "Generating veg parameter for gridid $gridid with veg type $vegid..."
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Veg
line="$gridid 1\n    $vegid 1.0 0.1 0.1 0.75 0.6 0.5 0.3\n"
echo $line > $outfilename
cd $current_path

