#!/bin/sh

for gridid in 300756 304470 307255 307259 307260 308179 308184 308186 308188 308189 308199 308201 309115 309119 310037 310974 311900 314691
do
   replacestring='s/\/home\/liuming\/Projects/\/data\/hydro\/users\/liumingdata\/Projects/g' 
   sed -i ${replacestring} vic_control_$gridid.txt
   /home/liuming/dev/VIC_CropSyst/build/gcc/Release/VIC_CropSyst -g vic_control_$gridid.txt
done
echo "All done!"
