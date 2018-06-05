180604LML:

Test runs for various crops/rotations:
Irrigated potato (4004): 309119 45.84375 -119.09375
Winter Wheat     (4005): 308201 45.78125 -118.46875 

For this run, all crops has no rotations, i.e. all crop is single crop. 

Procedure for setting certain gridcell level simulations ( steps 1-8):

1. Identify the location of gridcell (might be the cell cell with the maximum cdl fraction) and copy the soil paramter file for this grid cell, and named as soil_param_id_[GRIDCELLID].txt.
The irrigated gridcells can be identified with overlaying irrigation map on fractional data layer. 

sh Soil/get_gridcell_soil_into_seperate_file.sh "[GRIDCELL_ID]". Replace [GRIDCELL_ID] with read gridcell id number.

2. Check if the crop type (rotation is exit or not) in the vegetation library file, if not create an item in this file.

3. Make sure the rotation file (and crop and management parameter files) exist.
3.1 crop parameter
3.2 management
3.3 rotation (for annual crops only)

4. Check the crop is listed in cropcodelib.txt

The second column is the filename (w/o extension) of the crop parameter file (listed in the rotation file).



5. Generate (if not exist) the vegetation parameter file for this crop/rotation type.  

sh Veg/generate_veg_parameter_for_onegridcell.sh [GRIDCELL_ID] [rotation_type_codei]

6. Generate irrigation type for this gridcell.

sh Management/generate_irrigation_parameter_for_onegridcell.sh [GRIDCELL_ID] [rotation_type_codei] [irrigation_type_name]

7. Generate scenario (VIC control) file.

sh Testruns/generate_scenario_for_one_gridcell.sh [GRIDCELL_ID]

8. Run the program.


