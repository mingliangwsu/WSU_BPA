#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Sum VIC-CropSyst crop daily outputs to annuam mean.

@author: liuming
"""

import pandas as pd
import sys
import math
#import numpy as np
#import matplotlib.pyplot as plt
import os
import os.path

#clm_list = ['Livneh','Abatzoglou']
clm_list = ['Livneh']
#rot_list = ['norotation','rotation']
rot_list = ['norotation']

#irrigation = "noirrig_"
#irrigation = "TRUE"
#outdir = "/fastscratch/liuming/BPA_180702"

if len(sys.argv) == 4:
    irrigation = sys.argv[1]
    outdir = sys.argv[2]
    generateout_dir = sys.argv[3]
    if not os.path.exists(generateout_dir):
        os.mkdir(generateout_dir)    
else:
    print("Usage:" + sys.argv[0] + "<irrigation: TRUE or FALSE> <vicoutdir_without_slash> <outputdir_without_slash>" )
    exit()

#User output
#outdir = "/home/liuming/Projects/BioEarth/VIC-CropSyst/Simulation/Scenarios/BPA_Umatilla/VIC_output"
start_year = 1928
#outdir = "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns/Output_180617_crops18"
#outdir = "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Testruns/Output"

#outdir = "/fastscratch/liuming/BPA_180702"
cellid_file = "/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs/cellloc_id_list.txt.complete"
#cellid_file = "/data/hydro/users/liumingdata/Projects/WSU_BPA/VIC-CropSyst/Simulation/Scenario/Aeolus_BPA_runs/cellloc_id_list.txt.selected"

current_dir = os.getcwd()
os.chdir(outdir)
#generateout_dir = outdir

loc_name_list = []
loc_id_dic = {}
with open(cellid_file) as f:
    for line in f:
        records = line.split(" ")
        if len(records[0]):
            loc_name_list.append(records[0])
            loc_id_dic.update({records[0] : records[1]})
print("cell id list reading is finished.\n")

avg_annual_all = pd.DataFrame()
avg_month_all = pd.DataFrame()
annual_all = pd.DataFrame()
month_all = pd.DataFrame()

cell_crop_fraction = pd.DataFrame()

print("Irrigation:" + irrigation)

avg_annual_out = generateout_dir + "/irrig" + irrigation + "crop_all_annual_avg_withfraction_area.txt"
avg_month_out = generateout_dir + "/irrig" + irrigation + "crop_all_month_avg_withfraction_area.txt"
annual_out = generateout_dir + "/irrig" + irrigation + "crop_all_annual_withfraction_area.txt"
month_out = generateout_dir + "/irrig" + irrigation + "crop_all_month_withfraction_area.txt"


avg_crop_fraction = generateout_dir + "/grid_crop_fractions.txt"

print(len(loc_name_list))

for loc_name in loc_name_list:
    #multiyear_rotation = True
    #if loc_name == "45.84375_-119.34375" or loc_name == "45.78125_-119.21875":
    #if loc_name == "XXXX":
    #    multiyear_rotation = True
    #else:
    #    multiyear_rotation = False

    target_var_list = ['Yield_kg_m2','irrig_netdemand_mm','irrig_total_mm','irrig_evap_mm','irrig_runoff_mm','water_stress_index','Runoff','Baseflow','Soil_E_mm','Crop_Canopy_E_mm','Act_Transp_mm','ET_mm','VIC_PET_shortgrass_mm','CropSyst_Pot_Transp_mm','PPT']
    #key_list = ['Year','CroppingSyst_code','Crop_code']
    key_list = ['cell_id','Year','Month','CroppingSyst_code','Crop_code']
    key_list_month = ['cell_id','Year','Month','CroppingSyst_code']
    key_list_grseason = ['cell_id','Year','CroppingSyst_code','Crop_code']
    #key_list_crop = ['Year','Crop_code']
    key_list_annual = ['cell_id','Year','CroppingSyst_code']
    key_list_annual_crop = ['cell_id','Year']
    key_crop = ['cell_id','CroppingSyst_code']
    key_month_crop = ['cell_id','Month','CroppingSyst_code']

    all_var_list = key_list + target_var_list
    fraction_info_var_list = ['cell_id','lon','lat','CroppingSyst_code','Cell_fract']
    os.chdir(outdir)

    for clm in clm_list:
        print(clm)
        for rot in rot_list:
            print("    " + rot)
            #vic_crop_outputs = "crop4001_cp_45.84375_-119.09375.asc"
            #vic_crop_outputs = "crop_Livneh_norotation_45.84375_-119.09375.asc"
            outrot="_"
            #cropname = loc_crop_dic[loc_name]
            #vic_crop_outputs = irrigation + "crop_" + clm + "_" + rot + "_" + loc_name + ".asc"
            vic_crop_outputs = "crop_irr_" + irrigation + "_sd__" + loc_name + ".asc"
            print(vic_crop_outputs)
            
            #output_annual_mean = irrigation + "Total_annual_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + ".asc" 
            #output_season_mean = irrigation + "Total_growseason_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + ".asc" 
            #output_month_mean = irrigation + "Total_month_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + ".asc" 
            #avgoutput_annual_mean = irrigation + "avg_Total_annual_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + ".asc" 
            #avgoutput_season_mean = irrigation + "avg_Total_growseason_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + ".asc" 
            #avgoutput_month_mean = irrigation + "avg_Total_monnth_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + ".asc" 
            
            
            #if multiyear_rotation:
            #    output_annual_mean_allrot = "annual_mean_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + "_all_rot.asc" 
            #    output_season_mean_allrot = "growseason_mean_" + clm + "_" + outrot + "_" + cropname + "_" + loc_name + "_all_rot.asc" 
            if os.path.exists(vic_crop_outputs):
                vic_crop = pd.read_csv(vic_crop_outputs,sep=',',index_col=False)
                #print(key_list)
                temp = vic_crop[all_var_list]
                temp = temp.loc[temp['Year'] >= start_year]                                                                         #all revords after start_year
                
                temp_fraction = vic_crop[fraction_info_var_list]
                temp_fraction = temp_fraction.drop_duplicates(keep='first')
                
                vic_select = temp
                vic_month = vic_select.groupby(key_list_month,as_index=False)[all_var_list].sum()
                vic_annual = temp.groupby(key_list_annual,as_index=False)[all_var_list].sum()
                
                
                avg_month = vic_month.groupby(key_month_crop,as_index=False)[all_var_list].mean()
                avg_month = avg_month.drop("Year", 1)
                avg_month = avg_month.drop("Crop_code", 1)
                #avg_month['CROP'] = cropname
                #avg_month.to_csv(avgoutput_month_mean, index=False, float_format='%.3f')
            
                #avg_season = vic_growth_season.groupby(key_crop,as_index=False)[all_var_list].mean()
                #avg_season = avg_season.drop("Year", 1)
                #avg_season = avg_season.drop("Crop_code", 1)
                #avg_season.to_csv(avgoutput_season_mean, index=False, float_format='%.3f')
            
                avg_year = vic_annual.groupby(key_crop,as_index=False)[all_var_list].mean()
                avg_year = avg_year.drop("Year", 1)
                avg_year = avg_year.drop("Crop_code", 1)
                #avg_year['CROP'] = cropname
                #avg_year.to_csv(avgoutput_annual_mean, index=False, float_format='%.3f')

                if annual_all.empty:
                    annual_all = vic_annual
                else:
                    annual_all = annual_all.append(vic_annual, ignore_index=True)

                if month_all.empty:
                    month_all = vic_month
                else:
                    month_all = month_all.append(vic_month, ignore_index=True)


                if avg_annual_all.empty:
                    avg_annual_all = avg_year
                else:
                    avg_annual_all = avg_annual_all.append(avg_year, ignore_index=True)
                
                if avg_month_all.empty:
                    avg_month_all = avg_month
                else:
                    avg_month_all = avg_month_all.append(avg_month, ignore_index=True)
                    
                if cell_crop_fraction.empty:
                    cell_crop_fraction = temp_fraction
                else:
                    cell_crop_fraction = cell_crop_fraction.append(temp_fraction, ignore_index=True)

#output average
csize = 0.0625
earth_rad = 6371393.0

def cos_degree(degree):
    return math.cos(degree * math.pi / 180.0)

#cell_crop_fraction['area_km2'] = 2.0 * ( csize * math.pi / 180.0 ) * earth_rad * earth_rad * math.cos(cell_crop_fraction['lat'] * math.pi / 180.0) * math.sin(csize * math.pi / 360.0) * 0.001 * 0.001

cell_crop_fraction['area_km2'] = 2.0 * ( csize * math.pi / 180.0 ) * earth_rad * earth_rad * cell_crop_fraction['lat'].apply(cos_degree) * math.sin(csize * math.pi / 360.0) * 0.001 * 0.001


#print(cell_crop_fraction.dtypes)
cell_crop_fraction.to_csv(avg_crop_fraction, index=False, float_format='%.5f')


month_all = month_all.merge(cell_crop_fraction, how='left', left_on=['cell_id','CroppingSyst_code'], right_on=['cell_id','CroppingSyst_code'])
month_all.to_csv(month_out, index=False, float_format='%.5f')

annual_all = annual_all.merge(cell_crop_fraction, how='left', left_on=['cell_id','CroppingSyst_code'], right_on=['cell_id','CroppingSyst_code'])
annual_all.to_csv(annual_out, index=False, float_format='%.5f')

avg_month_all = avg_month_all.merge(cell_crop_fraction, how='left', left_on=['cell_id','CroppingSyst_code'], right_on=['cell_id','CroppingSyst_code'])
avg_month_all.to_csv(avg_month_out, index=False, float_format='%.5f')

avg_annual_all = avg_annual_all.merge(cell_crop_fraction, how='left', left_on=['cell_id','CroppingSyst_code'], right_on=['cell_id','CroppingSyst_code'])
avg_annual_all.to_csv(avg_annual_out, index=False, float_format='%.5f')



os.chdir(current_dir)

print("Done!")

