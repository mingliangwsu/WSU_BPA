#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sum VIC-CropSyst crop daily outputs to annuam mean.

@author: liuming
"""

import pandas as pd
import numpy as np
import sys
import math
#import numpy as np
#import matplotlib.pyplot as plt
import os
import os.path


#clm_list = ['Livneh','Abatzoglou']
#clm_list = ['Livneh']
#rot_list = ['norotation','rotation']
#rot_list = ['norotation']

#irrigation = "noirrig_"


#irrigation = "TRUE"
#use_region_mask = True
#annual_data = True
#use_region_mask = False
#annual_data = False
#outdir = "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns/Output_from_Aeolus"

def str2bool(v):
  return v.lower() in ("TRUE", "True", "T", "t", "1")

if len(sys.argv) == 5:
    if str2bool(sys.argv[1]):
        irrigation = "TRUE"
    else:
        irrigation = "FALSE"
    use_region_mask = str2bool(sys.argv[2])
    annual_data = str2bool(sys.argv[3])
    outdir = sys.argv[4]
else:
    print("Usage:" + sys.argv[0] + "<irrigation: T or F> <use_region_mask: T or F> <annual_data: T or F> <outdir_without_slash>" )
    exit()



#User output
#outdir = "/home/liuming/Projects/BioEarth/VIC-CropSyst/Simulation/Scenarios/BPA_Umatilla/VIC_output"
#start_year = 1928
#outdir = "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns/Output_180617_crops18"
#outdir = "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns/Output"

#outdir = "/fastscratch/liuming/BPA_180702"

#cellid_file = "/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs/cellloc_id_list.txt.complete"
#cellid_file = "/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs/cellloc_id_list.txt.selected"
cellid_file = "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns/Output_from_Aeolus/UM_calibration_cellid_list.txt"

if annual_data:
    grid_mean_data = str(irrigation) + "crop_all_annual_avg_withfraction_area.txt"
else:
    grid_mean_data = str(irrigation) + "crop_all_month_avg_withfraction_area.txt"

os.chdir(outdir)
generateout_dir = outdir

if use_region_mask:
    loc_name_list = []
    #loc_id_dic = {}
    with open(cellid_file) as f:
        for line in f:
            records = line.split("\n")
            if len(records[0]):
                loc_name_list.append(int(records[0]))
            #loc_id_dic.update({records[0] : records[1]})
            #print("cell id list reading is finished.\n")

#avg_annual_all = pd.DataFrame()
#avg_month_all = pd.DataFrame()
#cell_crop_fraction = pd.DataFrame()

#print("Irrigation:" + irrigation)

if annual_data:
    avg_out_filename = "region_avg_crop_annual_irrig" + str(irrigation) + "_regionmask" + str(use_region_mask) + ".txt"
else:
    avg_out_filename = "region_avg_crop_monthly_irrig" + str(irrigation) + "_regionmask" + str(use_region_mask) + ".txt"
#avg_crop_fraction = generateout_dir + "/" + "grid_crop_fractions.txt"

print(len(loc_name_list))

target_var_list = ['Yield_kg_m2','irrig_netdemand_mm','irrig_total_mm','irrig_evap_mm','irrig_runoff_mm','water_stress_index','Runoff','Baseflow','Soil_E_mm','Crop_Canopy_E_mm','Act_Transp_mm','ET_mm','VIC_PET_shortgrass_mm','CropSyst_Pot_Transp_mm','PPT']

key_for_annual = ['cell_id','lat','lon','CroppingSyst_code']

if annual_data:
    key_crop = ['cell_id','lat','lon','CroppingSyst_code']
else:
    key_crop = ['cell_id','lat','lon','Month','CroppingSyst_code']
    
all_var_list = key_crop + target_var_list


if os.path.exists(grid_mean_data):
    vic_crop = pd.read_csv(grid_mean_data,sep=',',index_col=False)
    #filter the non-irrigated crops and gridcell
    #1: grid cell list
    vic_crop['crop_area_km2'] = vic_crop['area_km2'] * vic_crop['Cell_fract']
    if use_region_mask:
        vic_crop = vic_crop.loc[vic_crop['cell_id'].isin(loc_name_list)]
    #2: filterout non-irrigated crops
    if annual_data:
        vic_crop = vic_crop.loc[vic_crop['irrig_netdemand_mm'] > 0]
        #outavg = vic_crop.groupby(['CroppingSyst_code'],as_index=False)[all_var_list].mean()
        #outavg = weighted_average(vic_crop,'irrig_netdemand_mm','crop_area_km2','CroppingSyst_code')
        for var in target_var_list:
            temp = vic_crop.groupby('CroppingSyst_code', as_index=True).apply(lambda x: np.average(x[var], weights=x['crop_area_km2']))
            tavg = pd.DataFrame({'CroppingSyst_code':temp.index,var:temp})
            if (var == 'Yield_kg_m2'):
                outavg = tavg
            else:
                outavg = outavg.merge(tavg,how='left',left_on='CroppingSyst_code',right_on='CroppingSyst_code')
        
    else:
        #identify which gridcell & crop is irrigated
        temp = vic_crop.groupby(key_for_annual,as_index=False)[all_var_list].sum()
        temp = temp.loc[temp['irrig_netdemand_mm'] > 0]
        temp = temp[['cell_id','CroppingSyst_code']]
        temp = temp.drop_duplicates(keep='first')
        vic_crop = vic_crop.merge(temp,how='inner', left_on=['cell_id','CroppingSyst_code'], right_on=['cell_id','CroppingSyst_code'])
        #outavg = vic_crop.groupby(['Month','CroppingSyst_code'],as_index=False)[all_var_list].mean()
        #outavg = weighted_average(vic_crop,'irrig_netdemand_mm',['crop_area_km2'],['Month','CroppingSyst_code'])
        for var in target_var_list:
            temp = vic_crop.groupby(['Month','CroppingSyst_code'], as_index=False).apply(lambda x: np.average(x[var], weights=x['crop_area_km2']))
            temp.index.name
            monlist = [ x[0] for x in temp.index.values.tolist()]
            croplist = [ x[1] for x in temp.index.values.tolist()]
            tavg = pd.DataFrame({'Month':monlist, 'CroppingSyst_code':croplist, var:temp})
            if (var == 'Yield_kg_m2'):
                outavg = tavg
            else:
                outavg = outavg.merge(tavg,how='left',left_on=['Month','CroppingSyst_code'],right_on=['Month','CroppingSyst_code'])

outavg.to_csv(avg_out_filename, index=False, float_format='%.5f')
print("Done!")
