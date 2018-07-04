#!/bin/bash
echo "Start..."

#irrigation="TRUE"
outputdir="BPA_180623"
if ! [ -d /fastscratch/liuming/$outputdir ]; then
    mkdir /fastscratch/liuming/$outputdir
fi

#for irrigation in "TRUE" "FALSE"; do
for irrigation in "TRUE"; do
  for zone in {0..14}; do
  #for zone in {0..0}; do
    soilname="UMA_p${zone}.txt"
    outdir=${outputdir}
    crop_out="crop_irr_${irrigation}_sd_"
    vic_out="vic_irr_${irrigation}_sd_"
    irrig_file="Umatila_irrigation_parameter.txt"
    control_file="sub_UM_p${zone}_${irrigation}.txt"
    echo "outdir:${outdir}"
    qsub -N UM_${zone}_${irrigation}  -q hydro -l nodes=1:ppn=1,mem=2GB,walltime=48:00:00 -F "${soilname} ${outdir} ${crop_out} ${vic_out} ${irrigation} ${irrig_file} ${control_file}" singlejob.sh 
    echo "qsub ${control_file} done."
  done
done
