webuse pig, clear
mixed weight || _all:R.week || _all:R.id

cd "/Users/josh/repositories/stata/ranefplot"
cap program drop ranefplot
do ranefplot.ado

ranefplot, relevel(2)
