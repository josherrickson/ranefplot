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
number given in the mixed model (e.g., see syntax for {help mixed##syntax}).

{pstd}
Importantly, note that the {bf:relevel()} is {bf:NOT} the level as is traditionally defined when considering
mixed models as hierarchical models (HLM). To see what this means, consider the traditional model of students nested
inside classrooms, nested inside schools. In HLM parlance, the students are level 1 data (being the "lowest
level"), the classrooms are level 2, and the schools are level 3. Such a model would be define as

{phang2}. mixed {it:depvar} {it:indvars} || school: || classroom:{p_end}

{pstd}
As written, the first specified random effect is for school, so the option would be {bf:relevel(1)}; the second
specified random is for classroom, option as {bf:relevel(2)}.


{marker examples}{...}
{title:Examples}

{pstd}A single random intercept.{p_end}
{phang2}{stata webuse pig:. webuse pig}{p_end}
{phang2}{stata "mixed weight week || id:":. mixed weight week || id:}{p_end}
{phang2}{stata ranefplot:. ranefplot}{p_end}

{pstd}Crossed random effects.{p_end}
{phang2}{stata "mixed weight || _all:R.week || _all:R.id":. mixed weight || _all:R.week || _all:R.id}{p_end}
{phang2}{stata ranefplot, relevel(2):. ranefplot, relevel(2)}{p_end}
