webuse pig, clear
mixed weight || _all:R.week || _all:R.id

cap program drop ranefplot
program define ranefplot
	preserve
	syntax [, relevel(integer 1)]
	forvalues i = 1/`=e(k_rs)-1' {
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

	twoway (rcap `ub' `lb' `x' if `signif' == 0, lcolor("gs14")) (scatter `ra' `x' if `signif' == 0, mcolor("gs14")) ///
				 (rcap `ub' `lb' `x' if `signif' == 1, lcolor("black")) (scatter `ra' `x' if `signif' == 1, mcolor("black")), ///
		yline(0) legend(off) xtitle("") xlab("") ytitle("Random Effect")
end

ranefplot, relevel(2)
