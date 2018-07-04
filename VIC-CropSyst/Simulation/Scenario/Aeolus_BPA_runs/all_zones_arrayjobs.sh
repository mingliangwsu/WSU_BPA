#!/bin/bash
#PBS -N UM_VIC_CropSyst
##PBS -l nodes=1:ppn=1,mem=2GB,walltime=36:00:00
##PBS -q hydro

#PBS -l nodes=1:ppn=1,mem=2GB,walltime=06:00:00
#PBS -q batch

##PBS -l nodes=1:ppn=1,mem=4GB,walltime=02:00:00
##PBS -q fast

##PBS -t 0-718
##PBS -t 0-599%20

#arguments
#irrigation="TRUE"
#outputdir="BPA_180623"

#!/bin/bash

current_dir=$PWD

echo "Start..."

#if ! [ -d $outputdir ]; then
#    mkdir -p $outputdir
#fi

zone=${PBS_ARRAYID}
soilname="${soilprefix}_p${zone}.txt"
outdir=${outputdir}
crop_out="crop_irr_${irrigation}_sd_"
vic_out="vic_irr_${irrigation}_sd_"
irrig_file="Umatila_irrigation_parameter.txt"
control_file="sub_UM_p${zone}_${irrigation}.txt"
echo "outdir:${outdir}"

cd ${workdir}
cp vic_control_mode.txt $control_file
cp .CropSyst_scenario ./
replacestring="s~REPLACE_SOILFILE~$soilname~g"
sed -i $replacestring $control_file
replacestring="s~REPLACE_OUTPUTDIR~$outdir~g"
sed -i $replacestring $control_file
replacestring="s~REPLACE_CROPOUT~$crop_out~g"
sed -i $replacestring $control_file
replacestring="s~REPLACE_VICOUT~$vic_out~g"
sed -i $replacestring $control_file
replacestring="s~REPLACE_IRRIGATION_TRUE~$irrigation~g"
sed -i $replacestring $control_file
replacestring="s~REPLACE_IRRIGATION_FILE~$irrig_file~g"
sed -i $replacestring $control_file

exec="/home/liuming/dev/VIC_CropSyst/build/gcc/Release/VIC_CropSyst"
$exec -g $control_file
cd $current_dir

