#!/bin/sh

for gridid in 300756 304470 307255 307259 307260 308179 308184 308186 308188 308189 308199 308201 309115 309119 310037 310974 311900 314691
do
   replacestring='s/\/home\/liuming\/Projects/\/data\/hydro\/users\/liumingdata\/Projects/g' 
   sed -i ${replacestring} vic_control_$gridid.txt
   sed -i 's/1979/1915/g' vic_control_$gridid.txt 
   sed -i '22s/TRUE/FALSE/g' vic_control_$gridid.txt
   /home/liuming/dev/VIC_CropSyst/build/gcc/Release/VIC_CropSyst -g vic_control_$gridid.txt

   cp vic_control_$gridid.txt vic_control_${gridid}_noirrigation.txt
   sed -i '167s/TRUE/FALSE/g' vic_control_${gridid}_noirrigation.txt
   sed -i 's/crop_Livneh_norotation/noirrig_crop_Livneh_norotation/g' vic_control_${gridid}_noirrigation.txt
   sed -i 's/VICFLUX_Livneh_norotation/noirrig_VICFLUX_Livneh_norotation/g' vic_control_${gridid}_noirrigation.txt   
   /home/liuming/dev/VIC_CropSyst/build/gcc/Release/VIC_CropSyst -g vic_control_${gridid}_noirrigation.txt

done
echo "All done!"
