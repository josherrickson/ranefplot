{smcl}
{* *! version 0.0.1  13july2018}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "ranefplot##syntax"}{...}
{viewerjumpto "Description" "ranefplot##description"}{...}
{viewerjumpto "Options" "ranefplot##options"}{...}
{viewerjumpto "Examples" "ranefplot##examples"}{...}
{title:Title}

{phang}
{bf:ranefplot} {hline 2} Produces a visualization of the random intercepts in a mixed effects model.


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:ranefplot} [, {it:options}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opth relevel(integer)}}Chooses which level of random effects to predict (see below).{p_end}

{marker description}{...}
{title:Description}

{pstd}
Generates a scatterplot of the random effects from the model, along with confidence bounds. The points are
re-ordered to produce an easier to see visualization. If multiple random effects are included (either nested or
crossed), the {opth relevel(integer)} option should be passed, where {it:integer} is the {it:re_equation}
number given in the mixed model (e.g., see syntax for {help mixed##syntax}.


{marker examples}{...}
{title:Examples}

{pstd}A single random intercept.{p_end}
{phang2}{stata webuse pig:. webuse pig}{p_end}
{phang2}{stata "mixed weight week || id:":. mixed weight week || id:}{p_end}
{phang2}{stata ranefplot:. ranefplot}{p_end}

{pstd}Crossed random effects.{p_end}
{phang2}{stata "mixed weight || _all:R.week || _all:R.id":. mixed weight || _all:R.week || _all:R.id}{p_end}
{phang2}{stata ranefplot, relevel(2):. ranefplot, relevel(2)}{p_end}
