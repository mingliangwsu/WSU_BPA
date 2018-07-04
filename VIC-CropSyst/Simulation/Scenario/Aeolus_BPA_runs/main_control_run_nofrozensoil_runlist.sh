#!/bin/bash
echo "Start..."

irrigation="TRUE"
outputdir="BPA_180616_nofrozensoil"
if ! [ -d /fastscratch/liuming/$outputdir ]; then
    mkdir /fastscratch/liuming/$outputdir
fi

for irrigation in "TRUE" "FALSE"; do
  for zone in 71 55 23 79 75 27 59 51 43 88 35 67 19 85 15 31 63 82 47; do
    soilname="UMA_p${zone}.txt"
    outdir=${outputdir}
    crop_out="crop_irr_${irrigation}_sd_"
    vic_out="vic_irr_${irrigation}_sd_"
    irrig_file="Umatila_irrigation_parameter.txt"
    control_file="sub_UM_p${zone}_${irrigation}_nofrozen.txt"
    echo "outdir:${outdir}"
    qsub -q batch -l nodes=1:ppn=1,mem=2GB,walltime=06:00:00 -F "${soilname} ${outdir} ${crop_out} ${vic_out} ${irrigation} ${irrig_file} ${control_file}" singlejob_nofrozone.sh 
    echo "qsub ${control_file} done."
  done
done
