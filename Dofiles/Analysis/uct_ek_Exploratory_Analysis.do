
	* --------------------------------------------------------------------------
	* Simple comparisons of program area vs non-area (high intensity vs low intensity)
	* 	- High vs low intensity: 				ib0.treat_slocal  & if county=="Siaya" & rct_area==1
	* 	- Part. vs non-partic in Siaya:			ib0.rct_area & if county=="Siaya"
	* 	- Siaya vs non-Siaya:					ib0.siaya 





	* --------------------------------------------------------------------------
	* Naive comparison of localities along forest loss
	
	use "$uctek_dtInt/UCTEK_main_data-cross-sectional.dta", clear		
		
		* Descriptives
		bysort province: su tree2000
		bysort province: su loss0014
		bysort province: su loss0020
		
		estpost tabstat
		
		
		* Naive analysis coomparing High-intensity vs Low-intensity
		eststo clear
		eststo: reg tloss0017 ib0.treat_slocal tloss0014 tree2000 if county=="Siaya" & rct_area==1
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss0020 ib0.treat_slocal tloss0014 tree2000 if county=="Siaya" & rct_area==1
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		esttab, ///
			title("Effect on forest loss")	///
			mtitles("2000-17" "2000-20")	///
			scalar("N Observations" "r2 Adjusted_R2" ) 	///
			star(* .1 ** .05 *** .01) 												///
			sfmt(%9.3gc) b(3) se(3) label se nonumbers nonotes nobaselevels noomitted
			
			/*
			"Controls Controls" 			///
			"tree2000 Tree cover in 2000" "baselineloss Tree loss bw. 2000-14"
			keep(1.treat_slocal _cons) 		///
			*/
			
			
		* Naive analysis comparing 3 RCT sub-Counties vs non-participating sub-counties in Siaya
		eststo clear
		eststo: reg tloss0017 ib0.rct_area tloss0014 tree2000 if county=="Siaya"
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss0020 ib0.rct_area tloss0014 tree2000 if county=="Siaya"
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		esttab, ///
			title("Effect on forest loss")	///
			mtitles("2000-17" "2000-20")	///
			scalar("N Observations" "r2 Adjusted_R2" ) 	///
			star(* .1 ** .05 *** .01) 												///
			sfmt(%9.3gc) b(3) se(3) label se nonumbers nonotes nobaselevels noomitted
			
			
			
		* Naive analysis comparing Siaya vs remaining counties
		
		eststo clear
		eststo: reg tloss0017 ib0.siaya tloss0014 tree2000 
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss0020 ib0.siaya tloss0014 tree2000
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		esttab, ///
			title("Effect on forest loss")	///
			mtitles("2000-17" "2000-20")	///
			scalar("N Observations" "r2 Adjusted_R2" ) 	///
			star(* .1 ** .05 *** .01) 												///
			sfmt(%9.3gc) b(3) se(3) label se nonumbers nonotes nobaselevels noomitted
			
	
		
		** Changed outcome variable
		eststo clear
		eststo: reg tloss1420 ib0.treat_slocal tloss0014 tree2000 if county=="Siaya" & rct_area==1
			qui su tloss1420 if county=="Siaya" & rct_area==1 & treat_slocal==0
			estadd scalar cmean 		= r(mean)
			estadd scalar csd			= r(sd)
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss1720 ib0.treat_slocal tloss0014 tree2000 if county=="Siaya" & rct_area==1
			qui su tloss1720 if county=="Siaya" & rct_area==1 & treat_slocal==0
			estadd scalar cmean 		= r(mean)
			estadd scalar csd			= r(sd)
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss1420 ib0.rct_area tloss0014 tree2000 if county=="Siaya"
			qui su tloss1420 if county=="Siaya" & rct_area==0
			estadd scalar cmean 		= r(mean)
			estadd scalar csd			= r(sd)
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss1720 ib0.rct_area tloss0014 tree2000 if county=="Siaya"
			qui su tloss1720 if county=="Siaya" & rct_area==0
			estadd scalar cmean 		= r(mean)
			estadd scalar csd			= r(sd)
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss1420 ib0.siaya tloss0014 tree2000 
			qui su tloss1420 if county!="Siaya"
			estadd scalar cmean 		= r(mean)
			estadd scalar csd			= r(sd)
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		eststo: reg tloss1720 ib0.siaya tloss0014 tree2000
			qui su tloss1720 if county!="Siaya"
			estadd scalar cmean 		= r(mean)
			estadd scalar csd			= r(sd)
			estadd local baselineloss	"Yes"
			estadd local tree2000		"Yes"
		esttab , 																	///
			title("Effect on forest loss (in pct. points relative to baseline tree cover in 2000)")	///
			order(1.treat_slocal 1.rct_area 1.siaya)								///
			mgroups("High vs Low intens." "RCT vs non-RCT in county" "Siaya county vs Rest", patter(1 0 1 0 1 0) ) ///
			mtitles("2014-20" "2017-20" "2014-20" "2017-20" "2014-20" "2017-20") 	///
			scalar("N Observations" "r2 Adjusted_R2" 								///
					"cmean Mean in comp. group" "csd Std.dev. in comp.group")		///
			star(* .1 ** .05 *** .01) 												///
			sfmt(%9.3gc) b(3) se(3) label se nonumbers nonotes nobaselevels noomitted
			
			
			
			
			
			
	** Naive analysis using panel data
	use "$uctek_dtInt/UCTEK_slocality_treecover_panel.dta", clear
	
		
		** High vs low intensity
		drop if rct_area==0
		collapse (mean) treecover 						///
				(min) treecover_min = treecover 		///
				(max) treecover_max = treecover, by(treat_slocal year)
				
	// 		(rarea treecover_min treecover_max year if treat_slocal==0, 				///
	// 					astyle(ci) yline(1) acolor(red%10))								///		
	// 		(rarea treecover_min treecover_max year if treat_slocal==1, 				///
	// 					astyle(ci) yline(1) acolor(blue%10))
				
		twoway 	(line treecover year if treat_slocal==0 , lc(red) lw(thin))					///
				(line treecover year if treat_slocal==1 , lc(blue)),									///
				legend(order(1 2) label(1 "Low intensity") label(2 "High intensity" ))		///
				xline(2014, lc(black)) ytitle("Tree cover (% of total area)")				///
				graphregion(color(white)) plotregion(color(white))
		graph save 	"$uctek_outRaw/notes/treecover_time_highvslow.gph", replace
		graph export "$uctek_outRaw/notes/treecover_time_highvslow.png", as(png) width(1500) replace
		
		
		** RCT area vs outside RCT area
		use "$uctek_dtInt/UCTEK_slocality_treecover_panel.dta", clear
		drop if siaya==0
		collapse (mean) treecover 						///
				(min) treecover_min = treecover 		///
				(max) treecover_max = treecover, by(year rct_area)
				
		twoway 	(line treecover year if rct_area==0 , lc(red) lw(thin))						///
				(line treecover year if rct_area==1 , lc(blue)),									///
				legend(order(1 2) label(1 "Outside RCT area") label(2 "RCT localities" ))			///
				xline(2014, lc(black)) ytitle("Tree cover (% of total area)")				///
				graphregion(color(white)) plotregion(color(white))
		graph save 	"$uctek_outRaw/notes/treecover_time_rctvsoutside.gph", replace
		graph export "$uctek_outRaw/notes/treecover_time_rctvsoutside.png", as(png) width(1500) replace
		
		
		
		** Siaya county vs others
		use "$uctek_dtInt/UCTEK_slocality_treecover_panel.dta", clear
		collapse (mean) treecover 						///
				(min) treecover_min = treecover 		///
				(max) treecover_max = treecover, by(year siaya)
				
		twoway 	(line treecover year if siaya==0 , lc(red) lw(thin))							///
				(line treecover year if siaya==1 , lc(blue)),								///
				legend(order(1 2) label(1 "Rest of country") label(2 "Siaya county" ))		///
				xline(2014, lc(black)) ytitle("Tree cover (% of total area)")					///
				graphregion(color(white)) plotregion(color(white))
		graph save 	"$uctek_outRaw/notes/treecover_time_siayavsrest.gph", replace
		graph export "$uctek_outRaw/notes/treecover_time_siayavsrest.png", as(png) width(1500) replace
		
		
		** Bottom left sub-localities
		use "$uctek_dtInt/UCTEK_slocality_treecover_panel.dta", clear
		gen forestarea = inlist(SLID, 609050203, 609050202)	if rct_area==1
		drop if rct_area==0
		collapse (mean) treecover 						///
				(min) treecover_min = treecover 		///
				(max) treecover_max = treecover, by(year forestarea)
				
		twoway 	(line treecover year if forestarea==0 , lc(red) lw(thin))								///
				(line treecover year if forestarea==1 , lc(blue) yaxis(2)),								///
				legend(order(1 2) label(1 "RCT area (Left axis)") label(2 "Forest area in RCT area (Right axis)" ))		///
				xline(2014, lc(black)) 															///
				ytitle("Tree cover for rest (% of total area)", axis(1))						///
				ytitle("Tree cover for forest area (% of total area)", axis(2))					///
				note("Forest area cover two sub-localities in the south-west.") scale(0.7)		///
				graphregion(color(white)) plotregion(color(white))
		graph save 	"$uctek_outRaw/notes/treecover_time_forestareavsrest.gph", replace
		graph export "$uctek_outRaw/notes/treecover_time_forestareavsrest.png", as(png) width(1500) replace
		
				
		
		
		
	*** Naive DID estimations
	use "$uctek_dtInt/UCTEK_slocality_treecover_panel.dta", clear
		lab var treatyear_slocal	"High intensity"
		lab var treatyear_rct_area	"RCT area"
		lab var treatyear_siaya		"Siaya county"
		eststo clear
		eststo: xtreg treecover ib0.treatyear_slocal  		ib2000.year if county=="Siaya" & rct_area==1, vce(cluster SLID)
		eststo: xtreg treecover ib0.treatyear_rct_area  ib2000.year if county=="Siaya" , vce(cluster SLID)
		eststo: xtreg treecover ib0.treatyear_siaya   		ib2000.year , vce(cluster SLID)
			
		
	esttab, ///
			title("DID estimation forest cover using different comparisons")	///
			order(1.treatyear_slocal 1.treatyear_rct_area 1.treatyear_siaya)	///
			scalar("N Observations" "r2 Adjusted_R2" )							///	
			drop(*.year)														///
			star(* .1 ** .05 *** .01) 											///
			sfmt(%9.3gc) b(3) se(3) label se nonumbers nonotes nobaselevels noomitted
	