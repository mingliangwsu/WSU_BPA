180604LML:

Test runs for various crops/rotations:
Irrigated potato (4004): 309119 45.84375 -119.09375
Winter Wheat     (4005): 308201 45.78125 -118.46875 
Spring Wheat     (4006): 307255 45.71875 -119.59375
Corn             (4007): 310974 45.96875 -119.15625
Alfalfa          (5701): 309115 45.84375 -119.34375
Sweet Corn       (4008): 311900 46.03125 -119.28125
Peas(53)         (4009): 308199 45.78125 -118.59375
Dry beans(42)    (4010): 307260 45.71875 -119.28125    //(1803) 
Barley(21)       (4011): 300756 45.28125 -119.78125    //(201) Normally it is not irrigated.
Onion(49)        (4100): 308179 45.78125 -119.84375    //NOTE: need right management for harvest information.
Canola(31) Winter(4101): 308186 45.78125 -119.40625
Carrots(206)     (4102): 310037 45.90625 -119.71875    //check harvest data & management file     

Apple(68)        (1401): 314691 46.21875 -118.84375    //(1401)
 

Carrots & Onion: planting date: Apr. 1; harvest date: Oct. 1
if model=canopy_cover_2017, set thermal_time_season_end equals full_senescence



For this run, all crops has no rotations, i.e. all crop is single crop. 

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


