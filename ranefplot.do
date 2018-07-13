webuse pig, clear
mixed weight week || id:

cap program drop ranefplot
program define ranefplot
	preserve
	tempname ra rse x ub lb
	predict `ra', reffects
	predict `rse', reses
	collapse (first) `ra' `rse', by(id)

	sort `ra'
	gen `x' = _n

	gen `ub' = `ra' + 1.96*`rse'
	gen `lb' = `ra' - 1.96*`rse'

	twoway (rcap `ub' `lb' `x') (scatter `ra' `x'), yline(0) legend(off) xtitle("") xlab("")
end

ranefplot
