webuse pig, clear
mixed weight || _all:R.week || _all:R.id

cd "/Users/josh/repositories/stata/ranefplot"
cap program drop ranefplot
do ranefplot.ado

ranefplot, relevel(1)


webuse productivity, clear
mixed gsp private emp hwy other unemp || region: || state:   water

ranefplot, relevel(2)
