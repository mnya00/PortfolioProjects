A cross-cultural examination of the effect of performance related pay schemes on firm innovation

The data is from a sub sample of the companies included in Eurofound’s 4th European Company Survey (ECS). 
The European Company Survey 2019 (ECS 2019) used a push-to-web approach.

The survey yielded 21,869 respondents in management positions from 21,869 establishments in a total of 28 countries. 

Out of these, I randomly selected 4 countries, 

2 of which rank highest (Netherlands, 4.61; Austria, 4.46) 
in Future Orientation practice scores and 

2 of which rank lowest (Poland, 3.11; Hungary, 3.21) 
in Future Orientation practice scores as measured by GLOBE standards (House et. al, 2004).

Independent Variables-- 

Individual Performance related pay (IPRP)
Collective Performance related pay (CPRP)
Combined Performance related pay (Combined PRP)

Moderating variable--

Future Orientation scores

Dependent variable--

Organizational Innovation

Control variables--

Sector
Firm size
Multi-location
Training %
Teamwork



--1. Deleting data from all countries except the chosen 4

. drop if country ==2


. drop if country ==3


. drop if country==4


. drop if country==5


. drop if country==6


. drop if country==7


. drop if country==8


. drop if country==9


. drop if country==10


. drop if country==11


. drop if country==12


. drop if country==14


. drop if country==15


. drop if country==16


. drop if country==17


. drop if country==18


. drop if country==19


. drop if country==22


. drop if country==23


. drop if country==24


. drop if country==25


. drop if country==26


. drop if country==27


. drop if country==28


. drop if country==29


. drop if country==30


. drop if country==31


. drop if country==32




--2. Assigning future orientation scores to each country remaining.



 ge FutureOrient=4.46 if country==1

. recode FutureOrient (.=4.61) if country==20

. recode FutureOrient (.=3.11) if country==21


. recode FutureOrient (.=3.21) if country==13




--3. Renaming and reassigning numerics to the control variables


 ge Small=1 if mm_size_grp==1



. ge Medium=1 if mm_size_grp==2


. ge Large=1 if mm_size_grp==3


. recode Small Medium Large (.=0)





 ge Manufacturing=1 if mm_NACE==3


 ge Construction=1 if mm_NACE==6


. ge AccFoodSer=1 if mm_NACE==9


. ge TranspStor=1 if mm_NACE==8


. ge FinIns=1 if mm_NACE==11


. ge RealEst=1 if mm_NACE==12


. ge WholRetail=1 if mm_NACE==7


. recode Construction AccFoodSer TranspStor FinIns Manufacturing RealEst WholRetail (.=0)

ge Other_Ind=1 if mm_NACE==1| mm_NACE==2| mm_NACE==4| mm_NACE==5| mm_NACE==10| mm_NACE>12

recode Other_Ind (.=0)



ren singlest Multilocated

. recode Multilocated (1=0)


. recode Multilocated(2=1)


--4. Assigning numerics to questionnaire answers for main variables


. drop if paidtrain_d < 1




. recode teamex (2=0)


. drop if teamex < 0




 recode innoprod (3=4)
 
. recode innoprod (1=3)
 
. recode innoprod innoprod(4=1)

. drop if innoprod < 1
 
 
 
 
. recode innoproc (1=3) (2=2) (3=1)
 
. drop if innoproc < 1
 
 
 
 
.  recode innomark (1=3) (2=2) (3=1)

. drop if innomark < 1




. drop if vpbres_d < 0


. drop if vpinper_d < 0


. drop if vpgrpe_d < 0


. drop if vpprsh_d < 0



--5. Combining sub variables to form main independent and dependent variables being analysed




. ge Org_innovation= innoprod+ innoproc+ innomark

. ge IPRP= vpbres_d+ vpinper_d

. ge CPRP= vpgrpe_d+ vpprsh_d




. ge CombPRP=0 if vpbres_d>1


. recode CombPRP (.=0) if vpinper_d>1


. recode CombPRP (0=1) if vpgrpe_d>1


. recode CombPRP (0=1) if vpprsh_d>1


. recode CombPRP (.=0)




. ge IPRP_new=1 if vpbres_d>1

. recode IPRP_new (.=1) if vpinper_d>1

. recode IPRP_new (.=0)




. ge CPRP_new=1 if vpgrpe_d>1

. recode CPRP_new (.=1) if vpprsh_d>1

. recode CPRP_new (.=0)




. ge High_Futur_Orient=1 if FutureOrient>4

. recode High_Futur_Orient (.=0)

. ge Low_Futur_Orient=1 if FutureOrient<4

. recode Low_Futur_Orient (.=0)




. ge PRP = vpbres_d+ vpinper_d+ vpgrpe_d+ vpprsh_d

. ren vpbres_d IPRP_1

. ren vpinper_d IPRP_2

. ren vpgrpe_d CPRP_1

. ren vpprsh_d CPRP_2



--6. Creating ordinal numeric assignments for logistic regression analysis

label define singlest 1 "Yes", modify
label define singlest 0 "No", add
label define singlest 2 "", modify
label variable Org_innovation "organisational Innovation"
label define OrgInnov 3 "None" 4 "Low" 5 "Below Average" 6 "Average" 7 "Above Average" 8 "High" 9 "Very High"
label values Org_innovation OrgInnov


label define OrgInnov 1 "None", add
label define OrgInnov 2 "Low", add
label define OrgInnov 3 "Below Average", modify
label define OrgInnov 4 "Average", modify
label define OrgInnov 5 "Above Average", modify
label define OrgInnov 6 "High", modify
label define OrgInnov 7 "Very High", modify
label define OrgInnov 8 "", modify
label define OrgInnov 9 "", modify



--7. Logistic regression analysis





ologit Org_innovation i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex

ologit Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 i.CombPRP i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex

ologit Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 i.CombPRP FutureOrient i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex

ologit Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 i.CombPRP FutureOrient IPRP_1#c.FutureOrient IPRP_2#c.FutureOrient CPRP_1#c.FutureOrient CPRP_2#c.FutureOrient CombPRP#c.FutureOrient i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex





ologit Org_innovation i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex, or

ologit Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 i.CombPRP i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex, or

ologit Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 i.CombPRP FutureOrient i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex, or

ologit Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 i.CombPRP FutureOrient IPRP_1#c.FutureOrient IPRP_2#c.FutureOrient CPRP_1#c.FutureOrient CPRP_2#c.FutureOrient CombPRP#c.FutureOrient i.Small i.Medium i.Large i.Manufacturing i.Construction i.AccFoodSer i.TranspStor i.FinIns i.RealEst i.WholRetail i.Multilocated i.paidtrain_d i.teamex, or


drop Org_innovation
ge Org_innovation= innoprod+ innoproc+ innomark



--8. Correlation analysis




correlate Org_innovation IPRP_1 IPRP_2 CPRP_1 CPRP_2 CombPRP FutureOrient Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated paidtrain_d teamex, mean

pwcorr Org_innovation IPRP_1 IPRP_2 CPRP_1 CPRP_2 CombPRP FutureOrient Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated paidtrain_d teamex, sig



--9. Linear regression analysis with VIF estimates




reg Org_innovation Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex

estat vif

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 CombPRP Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex

estat vif

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 CombPRP FutureOrient Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex

estat vif

summarize FutureOrient , meanonly
gen centered_FutureOrient = FutureOrient - r(mean)


summarize CombPRP , meanonly
gen centered_CombPRP = CombPRP - r(mean)


--10. Regression without similar variables to address multicolinearity




reg Org_innovation Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 CombPRP Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 CombPRP FutureOrient Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 centered_CombPRP centered_FutureOrient IPRP_1#c.centered_FutureOrient IPRP_2#c.centered_FutureOrient CPRP_1#c.centered_FutureOrient CPRP_2#c.centered_FutureOrient c.centered_CombPRP#c.centered_FutureOrient Small Medium Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)


Without Medium. Accounting for Large


reg Org_innovation Small Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 CombPRP Small Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 CombPRP FutureOrient Small Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)

reg Org_innovation i.IPRP_1 i.IPRP_2 i.CPRP_1 i.CPRP_2 centered_CombPRP centered_FutureOrient IPRP_1#c.centered_FutureOrient IPRP_2#c.centered_FutureOrient CPRP_1#c.centered_FutureOrient CPRP_2#c.centered_FutureOrient c.centered_CombPRP#c.centered_FutureOrient Small Large Manufacturing Construction AccFoodSer TranspStor FinIns RealEst WholRetail Multilocated i.paidtrain_d teamex, vce(robust)
