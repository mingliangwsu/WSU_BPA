#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage: $0 <1:gridid> <2:vegid>\n"
    exit 0
else
    gridid=$1
    vegid=$2
fi

outfilename="veg_param_id_${gridid}.txt"
current_path=$CWD
echo "Generating veg parameter for gridid $gridid with veg type $vegid..."
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Veg
line="$gridid 1\n    $vegid 1.0 0.1 0.1 0.75 0.6 0.5 0.3\n"
echo $line > $outfilename
cd $current_path

