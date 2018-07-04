#!/bin/bash
#sh qsub_array_jobs.sh "/fastscratch/liuming/BPA_180704_noirrig" "Umatilla_bigdomain_soil_after_1st_round.txt" "UM_1st_round" "FALSE"
sh qsub_array_jobs.sh "/fastscratch/liuming/BPA_180704_withirrig" "Umatilla_bigdomain_soil_after_1st_round.txt" "UM_1st_round" "TRUE"
echo "Done!"
