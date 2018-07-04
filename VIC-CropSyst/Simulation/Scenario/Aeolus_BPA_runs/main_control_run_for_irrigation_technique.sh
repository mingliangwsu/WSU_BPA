#!/bin/bash
echo "Start..."

irrigation="TRUE"
outputdir="BPA_180615_irrig_tech"
if ! [ -d /fastscratch/liuming/$outputdir ]; then
    mkdir /fastscratch/liuming/$outputdir
fi

for irrigation in "TRUE"; do
 for irr_type in "DEFAULT_FLOOD" "DEFAULT_DRIP" "DEFAULT_CENTER_PIVOT"; do
  for zone in {0..23}; do
    soilname="UMA_p${zone}.txt"
    outdir=${outputdir}
    crop_out="${irr_type}_crop_irr_${irrigation}_sd_"
    vic_out="${irr_type}_vic_irr_${irrigation}_sd_"
    irrig_file="Umatila_irrigation_parameter_${irr_type}.txt"
    control_file="sub_UM_p${zone}_${irrigation}_${irr_type}.txt"
    echo "outdir:${outdir}"
    qsub -q hydro -l nodes=1:ppn=1,mem=2GB,walltime=72:00:00 -F "${soilname} ${outdir} ${crop_out} ${vic_out} ${irrigation} ${irrig_file} ${control_file}" singlejob.sh 
    echo "qsub ${control_file} done."
  done
 done
done
