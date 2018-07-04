#!/bin/bash
#outputdir="/fastscratch/liuming/BPA_180702_noirrigation"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <1:output_dir> <2:soilfilename> <3:set_soilprefix> <4: irrigation (TRUE or FALSE)>\n"
    exit 0
else
    outputdir=$1
    soilfilename=$2
    prefix=$3
    irrigationtype=$4
fi

#outputdir="/fastscratch/liuming/BPA_180703"
#soilfilename="Umatilla_bigdomain_soil_after_1st_round.txt"
#prefix="UM_1st_round"
#irrigationtype="FALSE"
#irrigationtype="TRUE"

workdir="/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs"
soildir="/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Soil"
soilprefix="${soildir}/${prefix}"
curent_dir=$PWD

echo "Irrigarion:${irrigationtype}!"
echo "soilprefix:${soilprefix}"


step=200
cores=60

allfrom=0
totalcells=719

lines=5
remains=$(( $totalcells % $lines ))
divv=$(( $totalcells / $lines ))
if [ $remains -eq 0 ]; then
    allto=$(( $divv - 1 ))
else
    allto=$divv
fi

if ! [ -d $outputdir ]; then
    mkdir -p $outputdir
fi

#split soil file into simulation pieces
#if ! [ -f ${soilprefix}_p0.txt ]; then
     sh /data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Soil/split_soilfile.sh ${soildir}/${soilfilename} $lines $soilprefix
#fi
part=0
X=$allfrom
while [ $X -lt $allto ]; do
    to=$(( $X + $step - 1 ))
    if [ $to -ge $allto ]; then
      to=$allto
    fi
 
    echo "part:${part} from:${X} to:${to}"
    if [ $part -eq 0 ]; then
        previousjob=$( qsub -t ${X}-${to}%${cores} -v soilprefix=${soilprefix},workdir=${workdir},irrigation=${irrigationtype},outputdir=${outputdir} all_zones_arrayjobs.sh )
        echo "firstjob:${previousjob}"
        id=${previousjob:0:6}
        echo "part:$part"
    else
        echo "previousjob:${previousjob}"
        nextjob=$( qsub -W depend=afteranyarray:${id}[] -t ${X}-${to}%${cores} -v soilprefix=${soilprefix},workdir=${workdir},irrigatione=${irrigationtype},outputdir=${outputdir} all_zones_arrayjobs.sh )
        previousjob=${nextjob}
        echo "currentjob:${previousjob}"
        id=${previousjob:0:6}
        echo "part:$part"
    fi
    part=$(( $part + 1 ))
    X=$(( $X + $step ))
done
echo "Done!"
