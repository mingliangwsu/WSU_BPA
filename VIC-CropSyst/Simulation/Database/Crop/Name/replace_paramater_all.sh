#!/bin/bash
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py wheat_spring.crp spring_wheat.txt
#python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py potato-irrigated.crp potato.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py wheat_winter.crp winter_wheat.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py corn_grain-irrigated.crp grain_corn.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Alfalfa_OFoot_Generic.crp alfalfa.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Sweet_corn_OFoot_Generic.crp sweet_corn.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Pea_green_OFoot_Generic.crp peas.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Onion_Bulb_OFoot_Generic.crp onions.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py canola_winter-intermediate.crp winter_canola.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Carrot_OFoot_Generic.crp carrots.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Bean_Bush_Dry_OFoot_Generic.crp dry_bean.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py apple.crp apple.txt
#python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Barley.crp barley.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py Grass_seed.crp pasture_seed.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py mint.crp mint.txt
python /home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py cherry.crp cherry.txt

sh replace_wheat_spring.sh
sh replace_potato-irrigated.sh
sh replace_wheat_winter.sh
sh replace_corn_grain-irrigated.sh
sh replace_Alfalfa_OFoot_Generic.sh
sh replace_Sweet_corn_OFoot_Generic.sh
sh replace_Pea_green_OFoot_Generic.sh
sh replace_Onion_Bulb_OFoot_Generic.sh
sh replace_canola_winter-intermediate.sh
sh replace_Carrot_OFoot_Generic.sh
sh replace_Bean_Bush_Dry_OFoot_Generic.sh
sh replace_apple.sh 
sh replace_Barley.sh
sh replace_Grass_seed.sh
sh replace_mint.sh
sh replace_cherry.sh
