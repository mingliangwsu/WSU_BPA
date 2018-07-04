#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <1:soil_file> <2:outdir> <3:crop_out> <4:vic_out> <5:irrigation?> <6:irrigation_file> <7:outcontrol>"
    exit 0
fi

cd /data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs
cp vic_control_mode_no_frozen.txt $7

exec="/home/liuming/dev/VIC_CropSyst/build/gcc/Release/VIC_CropSyst"

replacestring='s/REPLACE_SOILFILE/'$1'/g'
sed -i $replacestring $7
replacestring='s/REPLACE_OUTPUTDIR/'$2'/g'
sed -i $replacestring $7
replacestring='s/REPLACE_CROPOUT/'$3'/g'
sed -i $replacestring $7
replacestring='s/REPLACE_VICOUT/'$4'/g'
sed -i $replacestring $7
replacestring='s/REPLACE_IRRIGATION_TRUE/'$5'/g'
sed -i $replacestring $7
replacestring='s/REPLACE_IRRIGATION_FILE/'$6'/g'
sed -i $replacestring $7

$exec -g $7
echo "Finished $7"
