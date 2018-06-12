#!/bin/bash
outfilename=potato-irrigated.crp
if grep -q "CC_initial" $outfilename; then
    sed -i 's/^CC_initial=.*/initial=-9999/g' $outfilename
fi
if grep -q "CC_maximum" $outfilename; then
    sed -i 's/^CC_maximum=.*/maximum=-9999/g' $outfilename
fi
if grep -q "CC_mature_green" $outfilename; then
    sed -i 's/^CC_mature_green=.*/green_season_end=-9999/g' $outfilename
fi
if grep -q "CC_mature_total" $outfilename; then
    sed -i 's/^CC_mature_total=.*/total_season_end=-9999/g' $outfilename
fi
if ! grep -q "thermal_time_season_end" $outfilename; then
    sed -i '/^total_season_end=.*/athermal_time_season_end=-9999' $outfilename
fi
if ! grep -q "shape_accrescent=" $outfilename; then
    sed -i '/^thermal_time_season_end=.*/ashape_accrescent=9' $outfilename
fi
if ! grep -q "shape_senescent=" $outfilename; then
    sed -i '/^shape_accrescent=.*/ashape_senescent=9' $outfilename
fi
sed -i 's/^canopy_growth=.*/canopy_growth=canopy_cover_2017/g' $outfilename
sed -i 's/^harvested_part=.*/harvested_part=tuber/g' $outfilename
sed -i 's/^C_species=.*/C_species=C3/g' $outfilename
sed -i 's/^life_cycle=.*/life_cycle=annual/g' $outfilename
sed -i 's/^stem_type=.*/stem_type=herbaceous/g' $outfilename
sed -i 's/^WUE_changes=.*/WUE_changes=false/g' $outfilename
sed -i 's/^TUE_equation=.*/TUE_equation=TUE_curve/g' $outfilename
sed -i 's/^TUE_scaling_coef=.*/TUE_scaling_coef=0.5/g' $outfilename
sed -i 's/^TUE_scaling_coef_veg=.*/TUE_scaling_coef_veg=0.5/g' $outfilename
sed -i 's/^TUE_at_1pKa_VPD=.*/TUE_at_1pKa_VPD=5/g' $outfilename
sed -i 's/^TUE_at_1pKa_VPD_veg=.*/TUE_at_1pKa_VPD_veg=5/g' $outfilename
sed -i 's/^RUE_global=.*/RUE_global=2/g' $outfilename
sed -i 's/^min_tolerable_temp=.*/min_tolerable_temp=7/g' $outfilename
sed -i 's/^max_tolerable_temp=.*/max_tolerable_temp=40/g' $outfilename
sed -i 's/^low_threshold_limit_temp=.*/low_threshold_limit_temp=20/g' $outfilename
sed -i 's/^high_threshold_limit_temp=.*/high_threshold_limit_temp=28/g' $outfilename
sed -i 's/^LWP_reduces_canopy_expansion=.*/LWP_reduces_canopy_expansion=-1000/g' $outfilename
sed -i 's/^LWP_stops_canopy_expansion=.*/LWP_stops_canopy_expansion=-1400/g' $outfilename
sed -i 's/^ET_crop_coef=.*/ET_crop_coef=1.15/g' $outfilename
sed -i 's/^max_water_uptake=.*/max_water_uptake=12/g' $outfilename
sed -i 's/^stomatal_closure_leaf_water_pot=.*/stomatal_closure_leaf_water_pot=-1300/g' $outfilename
sed -i 's/^wilt_leaf_water_pot=.*/wilt_leaf_water_pot=-1600/g' $outfilename
sed -i 's/^kc=.*/kc=0.5/g' $outfilename
sed -i 's/^initial=.*/initial=0.05/g' $outfilename
sed -i 's/^maximum=.*/maximum=0.95/g' $outfilename
sed -i 's/^green_season_end=.*/green_season_end=0.7/g' $outfilename
sed -i 's/^total_season_end=.*/total_season_end=0.7/g' $outfilename
sed -i 's/^shape_accrescent=.*/shape_accrescent=9/g' $outfilename
sed -i 's/^shape_senescent=.*/shape_senescent=9/g' $outfilename
sed -i 's/^rel_TT_at_half_CC_max=.*/rel_TT_at_half_CC_max=0.5/g' $outfilename
sed -i 's/^maturity_significant=.*/maturity_significant=true/g' $outfilename
sed -i 's/^emergence=.*/emergence=100/g' $outfilename
sed -i 's/^peak_LAI=.*/peak_LAI=1500/g' $outfilename
sed -i 's/^max_root_depth=.*/max_root_depth/g' $outfilename
sed -i ':a;N;$!ba;s/max_root_depth/max_root_depth=1350/1' $outfilename
sed -i 's/^flowering=.*/flowering=1200/g' $outfilename
sed -i 's/^filling=.*/filling=2100/g' $outfilename
sed -i 's/^senescence (begin)=.*/senescence (begin)=1600/g' $outfilename
sed -i 's/^maturity=.*/maturity=1200/g' $outfilename
sed -i 's/^thermal_response=.*/thermal_response=linear/g' $outfilename
sed -i 's/^base_temp=.*/base_temp=3/g' $outfilename
sed -i 's/^cutoff_temp=.*/cutoff_temp=25/g' $outfilename
sed -i 's/^optimal_temp=.*/optimal_temp=0/g' $outfilename
sed -i 's/^maximum_temp=.*/maximum_temp=0/g' $outfilename
sed -i 's/^initial_depth=.*/initial_depth=0.15/g' $outfilename
sed -i 's/^root_sensitivity_water_stress=.*/root_sensitivity_water_stress=0.5/g' $outfilename
sed -i ':a;N;$!ba;s/max_root_depth/max_root_depth=0.6/2' $outfilename
sed -i 's/^surface_root_density=.*/surface_root_density=3/g' $outfilename
sed -i 's/^root_length_at_emergence cm=.*/root_length_at_emergence cm=10/g' $outfilename
sed -i 's/^root_shoot_emergence_ratio=.*/root_shoot_emergence_ratio=2/g' $outfilename
sed -i 's/^root_shoot_full_ratio=.*/root_shoot_full_ratio=0.1/g' $outfilename
sed -i 's/^max_canopy_height=.*/max_canopy_height=0.6/g' $outfilename
sed -i 's/^consider_inactive_days=.*/consider_inactive_days=7/g' $outfilename
sed -i 's/^inducement_temperature=.*/inducement_temperature=5/g' $outfilename
sed -i 's/^unstressed=.*/unstressed=0.8/g' $outfilename
sed -i 's/^translocation_max=.*/translocation_max=0/g' $outfilename
sed -i 's/^adjust_HI=.*/adjust_HI=false/g' $outfilename
sed -i 's/^heat_extreme=.*/heat_extreme=false/g' $outfilename
sed -i 's/^TUE_reference_conc=.*/TUE_reference_conc=360/g' $outfilename
sed -i 's/^RUE_reference_conc=.*/RUE_reference_conc=360/g' $outfilename
sed -i 's/^alpha=.*/alpha=0.0022/g' $outfilename
sed -i 's/^theta=.*/theta=0.98/g' $outfilename
sed -i 's/^growth_ratio_asymtotic=.*/growth_ratio_asymtotic=1.45/g' $outfilename
if ! grep -q "thermal_response" "$outfilename"; then
    sed -i '/^full_senescence=.*/athermal_response=linear' $outfilename
fi
sed -i '/-9999/d' $outfilename
