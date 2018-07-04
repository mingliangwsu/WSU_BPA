#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sum VIC-CropSyst crop daily outputs to annuam mean.

@author: liuming
"""

import pandas as pd
#import numpy as np
#import matplotlib.pyplot as plt
import os
import os.path

#clm_list = ['Livneh','Abatzoglou']
clm_list = ['Livneh']
#rot_list = ['norotation','rotation']
rot_list = ['norotation']
irrigation = "TRUE"
start_year = 1928
outdir = "/fastscratch/liuming/BPA_180702"
cellid_file = "/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs/cellloc_id_list.txt.complete"

os.chdir(outdir)
generateout_dir = outdir
loc_name_list = []
loc_id_dic = {}
with open(cellid_file) as f:
    for line in f:
        records = line.split(" ")
        if len(records[0]):
            loc_name_list.append(records[0])
            loc_id_dic.update({records[0] : records[1]})
print("cell id list reading is finished.\n")

cell_crop_fraction = pd.DataFrame()
print("Irrigation:" + irrigation)
avg_annual_out = generateout_dir + "/" + irrigation + "crop_all_annual_avg.txt"
avg_month_out = generateout_dir + "/" + irrigation + "crop_all_month_avg.txt"
avg_crop_fraction = generateout_dir + "/" + "crop_fractions.txt"

print(len(loc_name_list))

for loc_name in loc_name_list:
    fraction_info_var_list = ['cell_id','lon','lat','CroppingSyst_code','Cell_fract']
    os.chdir(outdir)
    for clm in clm_list:
        print(clm)
        for rot in rot_list:
            print("    " + rot)
            vic_crop_outputs = "crop_irr_" + irrigation + "_sd__" + loc_name + ".asc"
            print(vic_crop_outputs)
            if os.path.exists(vic_crop_outputs):
                vic_crop = pd.read_csv(vic_crop_outputs,sep=',',index_col=False)
                #print(key_list)
                temp_fraction = vic_crop[fraction_info_var_list]
                temp_fraction.drop_duplicates(keep='first')
                if cell_crop_fraction.empty:
                    cell_crop_fraction = temp_fraction
                else:
                    cell_crop_fraction = cell_crop_fraction.append(temp_fraction, ignore_index=True)
cell_crop_fraction.to_csv(avg_crop_fraction, index=False, float_format='%.6f')
print("Done!")