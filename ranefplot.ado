program define ranefplot
	if !inlist("`e(cmd)'", "mixed") {
        error 301
    }

	preserve
	syntax [, relevel(integer 1) noCIHighlight]
	
	**** Get number of random effects
	local numre = e(k_rs)
	* Right now only support linear models, may support more in the future
	if "`e(cmd)'" == "mixed" {
		local numre = `numre' - 1
		* Extra effect for noise
	}
	
	**** Ensure `relevel` is appropriate
	if `relevel' <= 0 {
		display as error "{bf:relevel} must be greater than 0."
		exit
	}
	if `relevel' > `numre' {
		if `numre' == 1 {
			display as error "{bf:relevel} option not accepted; only one random effect in model."
		}
		else {
			display as error "{bf:relevel} must be between 1 and `numre', the number of random effects."
		}
		exit
	}
	
	forvalues i = 1/`numre' {
		tempname ra`i'
		local ras `ras' `ra`i''
		tempname rse`i'
		local rses `rses' `rse`i''
	}
	tempname ra rse x ub lb signif
	
	predict `ras', reffects
	gen `ra' = `ra`relevel''
	
	predict `rses', reses
	gen `rse' = `rse`relevel''
	
	collapse (first) `ra' `rse', by(id)

	sort `ra'
	gen `x' = _n

	gen `ub' = `ra' + 1.96*`rse'
	gen `lb' = `ra' - 1.96*`rse'
	
	gen `signif' = sign(`ub') == sign(`lb')

	if "`cihighlight'" == "nocihighlight" {
		local color = "black"
	}
	else {
		local color = "gs14"
	}
	
	twoway (rcap `ub' `lb' `x' if `signif' == 0, ///
						lcolor("`color'")) ///
				 (scatter `ra' `x' if `signif' == 0, ///
						mcolor("`color'")) ///
				 (rcap `ub' `lb' `x' if `signif' == 1, ///
						lcolor("black")) ///
				 (scatter `ra' `x' if `signif' == 1, ///
						mcolor("black")), ///
							yline(0) ///
							legend(off) ///
							xtitle("") ///
							xlab("") ///
							ytitle("Random Effect")
end
