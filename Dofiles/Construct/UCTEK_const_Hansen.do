
	* -------------------------------------------------------------------------
	*
	* Combine Hansen data with sub-locations both at cross-sectional and panel-level
	* - First merge administrative bounds with cross-sectional baseline-endline
	*	forest loss
	* - Second, generate sub-locality level panel dataset by merging sub-locality
	* 	level tree cover loss at panel level.
	* --------------------------------------------------------------------------
	
	
	
	* # Cross-sectional data
	use "$uctek_dtInt/geo_info/GEO_sublocality-sCounty-Locality.dta", clear
	
		* Drop duplicates before merging
		duplicates tag SLID, gen(dup)
		drop if dup==1
		drop dup
		
		* Siaya county dummy
		gen siaya = (county=="Siaya")
		lab def siaya_values 1 "Siaya" 0 "Rest of country"
		lab val siaya siaya_values
		lab var siaya "Dummy: 1 Siaya county 0 Rest of country"
		
		
		* Merge
		merge 1:1 SLID using "$uctek_dtInt/hansen/Hansen_KE-locality.dta", nogen
		
		* Generate additional forest loss measures
		gen loss1420 = loss0020 - loss0014
		gen loss1720 = loss0020 - loss0017
		
		** Note: 	forest loss is the share (0 to 1) of the TOTAL sub-locality area
		**  		that has lost trees. Not the share of pre-existing area, so need
		**			to transform these variables
		gen tloss0020 = (loss0020/tree2000)*100
		gen tloss0014 = (loss0014/tree2000)*100
		gen tloss0017 = (loss0017/tree2000)*100
		gen tloss1420 = (loss1420/tree2000)*100
		gen tloss1720 = (loss1720/tree2000)*100
		
		lab var loss1420		"Tree cover loss bw. 2014-2020 as percentage of total area"
		lab var loss1720		"Tree cover loss bw. 2014-2020 as percentage of total area"
		lab var tloss0020		"Tree cover loss bw. 2000-2020 as percentage of baseline tree cover."
		lab var tloss0014		"Tree cover loss bw. 2000-2014 as percentage of baseline tree cover."
		lab var tloss0017		"Tree cover loss bw. 2000-2017 as percentage of baseline tree cover."
		lab var tloss1420		"Tree cover loss bw. 2014-2020 as percentage of baseline tree cover."
		lab var tloss1720		"Tree cover loss bw. 2017-2020 as percentage of baseline tree cover."
		
		
		save "$uctek_dtInt/UCTEK_main_data-cross-sectional.dta", replace
		
		
	
	* # Generate sub-locality-level panel
	use "$uctek_dtInt/UCTEK_main_data-cross-sectional.dta", clear

		* Merge 
		merge 1:m SLID using "$uctek_dtInt/hansen/Hansen_KE-slocality_panel.dta"
		
		xtset SLID year
		
		** Generate panel treatment variables
		gen treatyear_slocal 	= treat_slocal * (year>=2015)
		gen treatyear_rct_area 	= rct_area * (year>=2015)
		gen treatyear_siaya 		= (county=="Siaya") * (year>=2015)
		
		lab var treatyear_slocal	"Treatment year variable: high vs low intensity"
		lab var treatyear_rct_area	"Treatment year variable: RCT area vs rest of Siaya county"
		lab var treatyear_siaya		"Treatment year variable: Siaya count vs rest of country"
		
		save "$uctek_dtInt/UCTEK_slocality_treecover_panel.dta", replace
		save "$uctek_dtInt/UCTEK_main_data-panel.dta", replace

	
	