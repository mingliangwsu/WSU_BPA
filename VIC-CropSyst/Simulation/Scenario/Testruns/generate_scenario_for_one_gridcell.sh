#!/bin/sh
gridid=$1
outfilename="vic_control_${gridid}.txt"
current_path=$CWD
echo "Generating vic_control file for gridid $gridid..."
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns
cp vic_control_CP_Umatilla_Livneh_norotation_one_gridcell_mode.txt $outfilename
replacestring='s/REPLACE_GRIDCELL_ID/'${gridid}'/g'
sed -i ${replacestring} $outfilename
echo "$outfilename generated."
cd $current_path

