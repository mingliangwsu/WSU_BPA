#!/bin/sh

if [ $# -eq 0 ]; then
    #hard coded
    gridid=307255
    rot=4006
    irri=DEFAULT_CENTER_PIVOT
else
    gridid=$1
    rot=$2
    irri=$3
fi


#step 4
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Soil
sh get_gridcell_soil_into_seperate_file.sh $gridid

#step 5
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Veg
sh generate_veg_parameter_for_onegridcell.sh $gridid $rot

#step 6
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Management
sh generate_irrigation_parameter_for_onegridcell.sh $gridid $rot $irri

#step 7
cd ~/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns
sh generate_scenario_for_one_gridcell.sh $gridid

#step 8
/home/liuming/dev/VIC_CropSyst/build/Qt/Linux_gcc/Debug/VIC_CropSyst -g vic_control_$gridid.txt
