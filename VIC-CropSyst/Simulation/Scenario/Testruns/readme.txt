180604LML:

Test runs for various crops/rotations:
Irrigated potato (4004): 309119 45.84375 -119.09375    //Not using the excel version of Photato parameter
Winter Wheat     (4005): 308201 45.78125 -118.46875 
Spring Wheat     (4006): 307255 45.71875 -119.59375
Corn             (4007): 310974 45.96875 -119.15625
Alfalfa          (701):  309115 45.84375 -119.34375
Sweet Corn       (4008): 311900 46.03125 -119.28125
Peas(53)         (4009): 308199 45.78125 -118.59375
Dry beans(42)    (4010): 307260 45.71875 -119.28125    //(1803) 
Barley(21)       (4011): 300756 45.28125 -119.78125    //(201) Normally it is not irrigated.
Onion(49)        (4100): 308179 45.78125 -119.84375    //NOTE: need right management for harvest information.
Canola(31) Winter(4101): 308186 45.78125 -119.40625
Carrots(206)     (4102): 310037 45.90625 -119.71875    //check harvest data & management file     
Apple(68)        (1401): 314691 46.21875 -118.84375    //(1401) Warning: The daily waterstress is set 1 during dormant season. 
Grass seeds(59)  (4104): 307259 45.71875 -119.34375    //(1527) perennual crops Warning: the management parameter file (harvest events should be set!!!) Maturity GDD set: 1600
Mint(14)         (807):  308189 45.78125 -119.21875    //(807) 
Cherry(66)       (1403): 308184 45.78125 -119.53125    //(1403)
GENERIC_Hay(37)  (2501): 308188 45.78125 -119.28125
Camelina(38)     (4103): 304470 45.53125 -119.65625    //(1905)

 

Carrots & Onion: planting date: Apr. 1; harvest date: Oct. 1
if model=canopy_cover_2017, set thermal_time_season_end equals full_senescence



For this run, all crops has no rotations, i.e. all crop is single crop (except Alfalfa & Mint, which has 5 year rotation). 

Procedure for setting certain gridcell level simulations ( steps 1-8):

1. Check if the crop type (rotation is exit or not) in the vegetation library file, if not create an item in this file.

2. Make sure the rotation file (and crop and management parameter files) exist.
2.1 crop parameter. For perennual crop, make sure the Code has a symlink to Name.
2.2 management: for alfafa (multi-year crops), make sure set "repeat_event=true" for managements (e.g. irrigation).  For perennual crop, make sure the Code has a symlink to Name.
2.3 rotation (for annual crops only). Make sure both the Name and Code files are generated.

3. Check the crop is listed in cropcodelib.txt

The second column is the filename (w/o extension) of the crop parameter file (listed in the rotation file).



4. Identify the location of gridcell (might be the cell cell with the maximum cdl fraction) and copy the soil paramter file for this grid cell, and named as soil_param_id_[GRIDCELLID].txt.
The irrigated gridcells can be identified with overlaying irrigation map on fractional data layer. 

sh Soil/get_gridcell_soil_into_seperate_file.sh "[GRIDCELL_ID]". Replace [GRIDCELL_ID] with read gridcell id number.

5. Generate (if not exist) the vegetation parameter file for this crop/rotation type.  

sh Veg/generate_veg_parameter_for_onegridcell.sh [GRIDCELL_ID] [rotation_type_codei]

6. Generate irrigation type for this gridcell.

sh Management/generate_irrigation_parameter_for_onegridcell.sh [GRIDCELL_ID] [rotation_type_codei] [irrigation_type_name]

7. Generate scenario (VIC control) file.

sh Testruns/generate_scenario_for_one_gridcell.sh [GRIDCELL_ID]

8. Run the program.

Step 4-7 can be batched in the script batch4_8_generate_parameter_files.sh [GRIDCELL_ID] [rotation_type_codei] [irrigation_type_name]   
irrigation:  DEFAULT_CENTER_PIVOT


//180611:
/home/liuming/dev/toolkits/ForVIC/python/update_crop_parameter_from_excel_table_converted_txt.py
It is the source code to replace crop parameter values from Claudio's excel table (has been converted into tab seperated text file).
The file "replace_paramater_all.sh" in the directory of "/home/liuming/Projects/WSU_BPA/VIC-CropSyst/Simulation/Database/Crop/Name" is the batch script to replace all crops types in the list.
Note: 
1: It seems the new parameters for Potato is not right.
2: found problem on Barley: the start sychronization for irrigation is sensitive to harvest date. If the sowing date is too late (i.e. not more than 20 days, the irrigation season will not be initialized and the irrigation never happen!!!). Now set offday = 0
3. Seems the new apple parameter does not work

