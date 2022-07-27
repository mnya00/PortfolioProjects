ANALYZING THE ROLE OF OMNICHANNEL MARKETING IN ENHANCING CUSTOMER EXPERIENCE AND YIELDING CUSTOMER RETENTION.

This Study was conducted using Addidas stores both online and offline as a case study.

50 respondents contributed to the results of the dataset.

--IMPORT AND EXPLORE DATASET
import delimited "C:\Users\mnya0\Downloads\KAFUI\The role of Omnichannel Marketing in enhancing Customer Experience and yielding Customer Retention.csv"
describe
sum
browse

--DATA CLEANING
drop v1
drop v2

--RELABELLING AND ENCODING OF VARIABLES
label variable v3 "1. Gender"
label variable v4 "2. Age"
label variable v5 "3. Have you ever purchased any Adidas product online or offline?"
label variable v6 "4. Do you know how to utilize the available services of both online and physical stores of Adidas?"
label variable v7 "5. How often do you purchase Adidas products?"
label variable v8 "6. How often do you use the internet in purchasing any Adidas product in an adidas retail store?"
label variable v9 "7. I can purchase products via online and in physical stores of Adidas"
label variable v10 "8. I am satisfied with the shopping experience of Adidas"
label variable v11 "9. Prices are the same both online and offline"
label variable v12 "10. I can get support through both online and physical stores of Adidas"
label variable v13 "11. Adidas is a trustworthy retailer"
label variable v14 "12. The feelings of service are consistent for both online and offline"
label variable v15 "13. Adidas provides consistent stock availability for both online and physical stores."
label variable v16 "14. The online and physical stores of Adidas have consistent performance in their speed of delivery"
label variable v17 "15. I feel optimistic when shopping at Adidas"
label variable v18 "16. I feel frustrated when shopping at Adidas"
label variable v19 "17. I am likely to continue to purchase products from Adidas"
label variable v20 "18. I am likely to choose Adidas as a preferred retailer if I need to buy such products"
label variable v21 "19. I am likely to recommend Adidas to my friends"
label variable v22 "20. Adidas keeps its promise to its customers"
label variable v23 "21. I feel uncertain when shopping at Adidas"
label variable v24 "22. Adidas cares about its customers"
label variable v25 "23. When shopping, I find myself spending a lot of time checking out new websites/apps/physical stores"
label variable v26 "24. I frequently keep watching for new websites/apps/physical stores"
label variable v27 "25. I am continually seeking out new websites/apps/physical stores"


encode v3, gen(1.Gender)
encode v3, gen(Gender)
encode v4, gen(Age)
encode v5, gen(purchase)
encode v6, gen(know_how)
encode v7, gen(freq_purch)
encode v8, gen(freq_intpurch)
encode v9, gen(CX_purchase)
encode v10, gen(CX_satisfied)
encode v11, gen(CX_prices)
encode v12, gen(CX_support)
encode v13, gen(CX_trust)
encode v14, gen(CX_feelings)
encode v15, gen(CX_constock)
encode v16, gen(CX_conperf)
encode v17, gen(CX_optimist)
encode v18, gen(CX_frust)
encode v19, gen(CR_contpurch)
encode v20, gen(CR_prefer)
encode v21, gen(CR_recommend)
encode v22, gen(CR_keepromise)
encode v23, gen(CR_uncertain)
encode v24, gen(CR_care)
encode v25, gen(CR_spendtime)
encode v26, gen(CR_keepwatch)
encode v27, gen(CR_contseek)





 recode Age (3=1) (2=1) (1=2)
(Age: 50 changes made)

. label define Age 1 "less than 25", modify

. label define Age 2 "25-29", modify

. label define Age 3 "greater than 29", modify

. recode purchase (1=0) (2=1)
(purchase: 50 changes made)

. label define purchase 1 "Yes", modify

. label define purchase 2 "", modify

. label define purchase 0 "No", add

. recode know_how (1=0) (2=1)
(know_how: 50 changes made)

. label define know_how 2 "", modify

. label define know_how 1 "Yes", modify

. label define know_how 0 "No", add

. recode freq_purch (2=0) (3=1) (1=2)
(freq_purch: 50 changes made)

. label define freq_purch 0 "Never", add

. label define freq_purch 1 "Yearly", modify

. label define freq_purch 2 "Monthly", modify

. label define freq_purch 3 "Weekly", modify

. recode freq_intpurch (.=0) (2=0) (4=1) (1=2)
(freq_intpurch: 49 changes made)

. label define freq_intpurch 4 "", modify

. label define freq_purch 0 "Never", modify

. label define freq_intpurch 1 "Yearly", modify

. label define freq_intpurch 2 "Monthly", modify

. label define freq_intpurch 3 "Weekly", modify

. label define freq_intpurch 0 "Never", add

. recode CX_purchase (5=1) (1=4) (4=5)
(CX_purchase: 41 changes made)

. label define CX_purchase 1 "Strongly Disagree", modify

. label define CX_purchase 5 "Strongly Agree", modify

. label define CX_purchase 4 "Agree", modify

 label define CX_satisfied 1 "Strongly Disagree", modify

. label define CX_satisfied 2 "Disagree", modify

. label define CX_satisfied 3 "Neutral", modify

. label define CX_satisfied 4 "Agree", add

. label define CX_satisfied 5 "Strongly Agree", add

. recode CX_satisfied (1=4) (2=3) (3=5)
(CX_satisfied: 50 changes made)

. recode CX_prices (.=0) (5=1) (1=4)
(CX_prices: 20 changes made)

. label define CX_prices 1 "Strongly Disagree", modify

. label define CX_prices 4 "Agree", modify

. label define CX_prices 5 "Strongly Agree", modify

. recode CX_support (.=0) (1=4) (4=5) (5=1)
(CX_support: 30 changes made)

. label define CX_support 1 "Strongly Disagree", modify

. label define CX_support 4 "Agree", modify

. label define CX_support 5 "Strongly Agree", modify

. recode CX_trust (1=4) (4=5) (5=1)
(CX_trust: 39 changes made)

. label define CX_trust 1 "Strongly Disagree", modify

. label define CX_trust 4 "StronglyAgree", modify

. label define CX_trust 4 "Agree", modify

. label define CX_trust 5 "Strongly Agree", modify

. recode CX_feelings (1=4) (4=5)
(CX_feelings: 17 changes made)

. label define CX_feelings 1 "Strongly Disagree", modify

. label define CX_feelings 4 "Agree", modify

. label define CX_feelings 5 "Strongly Agree", add

. recode CX_constock (4=5) (1=4)
(CX_constock: 20 changes made)

. label define CX_constock 1 "Strong Disagree", modify

. label define CX_constock 4 "Agree", modify

. label define CX_constock 5 "Strongly Agree", add

. recode CX_conperf (1=4) (5=1) (4=5)
(CX_conperf: 19 changes made)

. label define CX_conperf 1 "Strongly Disagree", modify

. label define CX_conperf 4 "Agree", modify

. label define CX_conperf 5 "Strongly Agree", modify

. recode CX_optimist (1=4) (4=1)
(CX_optimist: 25 changes made)

. label define CX_optimist 1 "Strongly Disagree", modify

. label define CX_optimist 4 "Agree", modify

. label define CX_optimist 5 "Strongly Agree", add

. recode CX_frust (5=1) (1=4)
(CX_frust: 13 changes made)

. label define CX_frust 1 "Strongly Disagree", modify

. label define CX_frust 4 "Agree", modify

. label define CX_frust 5 "Strongly Agree", modify

. recode CR_contpurch (4=5) (1=4) (5=1)
(CR_contpurch: 29 changes made)

. label define CR_contpurch 1 "Strongly Disagree", modify

. label define CR_contpurch 4 "Agree", modify

. label define CR_contpurch 5 "Strongly Agree", modify

. recode CR_prefer (1=4) (5=1) (4=5)
(CR_prefer: 23 changes made)

. label define CR_prefer 1 "Strongly Disagree", modify

. label define CR_prefer 4 "Agree", modify

. label define CR_prefer 5 "Strongly Agree", modify

. recode CR_recommend (1=4) (4=5) (5=1)
(CR_recommend: 34 changes made)

. label define CR_recommend 1 "Strongly Disagree", modify

. label define CR_recommend 4 "Agree", modify

. label define CR_recommend 5 "Strongly Agree", modify

. recode CR_keepromise (.=0) (1=4) (4=5)
(CR_keepromise: 26 changes made)

. label define CR_keepromise 1 "Strongly Disagree", modify

. label define CR_keepromise 4 "Agree", modify

. label define CR_keepromise 5 "Strongly Agree", add

. recode CR_uncertain (1=4) (4=5) (5=1)
(CR_uncertain: 14 changes made)

. label define CR_uncertain 1 "Strongly Disagree", modify

. label define CR_uncertain 4 "Agree", modify

. label define CR_uncertain 5 "Strongly Agree", modify

. recode CR_care (.=0) (1=4) (4=5) (5=1)
(CR_care: 28 changes made)

. label define CR_care 1 "Strongly Disagree", modify

. label define CR_care 4 "Agree", modify

. label define CR_care 5 "Strongly Agree", add

. recode CR_spendtime (.=0) (1=4) (4=5) (5=1)
(CR_spendtime: 21 changes made)

. label define CR_spendtime 1 "Strongly Disagree", modify

. label define CR_spendtime 4 "Agree", modify

. label define CR_spendtime 5 "Strongly Agree", modify

. recode CR_keepwatch (1=4) (4=5) (5=1)
(CR_keepwatch: 17 changes made)

. label define CR_keepwatch 1 "Strongly Disagree", modify

. label define CR_keepwatch 4 "Agree", modify

. label define CR_keepwatch 5 "Strongly Agree", modify

. recode CR_contseek (1=4) (4=5) (5=1)
(CR_contseek: 20 changes made)

. label define CR_contseek 1 "Strongly Disagree", modify

. label define CR_contseek 4 "Agree", modify

. label define CR_contseek 5 "Strongly Agree", modify


--CRONBACHS ALPHA TEST


alpha purchase know_how freq_purch freq_intpurch
alpha CX_purchase CX_satisfied CX_prices CX_support CX_trust CX_feelings CX_constock CX_conperf CX_optimist CX_frust
alpha CR_contpurch CR_prefer CR_recommend CR_keepromise CR_uncertain CR_care CR_spendtime CR_keepwatch CR_contseek


--GENERATING DEPENDENT AND INDEPENDENT VARIABLES

ge Omnichannel_marketing = purchase + know_how + freq_purch + freq_intpurch
ge Customer_Ex = CX_purchase + CX_satisfied+ CX_prices+ CX_support+ CX_trust+ CX_feelings+ CX_constock+ CX_conperf+ CX_optimist+ CX_frust
ge Customer_Ret = CR_contpurch+ CR_prefer+ CR_recommend+ CR_keepromise+ CR_uncertain+ CR_care+ CR_spendtime+ CR_keepwatch+ CR_contseek


--CORRELATION


correlate Omnichannel_marketing Customer_Ex Customer_Ret Gender Age


--LINEAR REGRESSION AND VIF ESTIMATES


reg Customer_Ret Omnichannel_marketing Customer_Ex Gender Age
estat vif
reg Customer_Ex Omnichannel_marketing Gender Age
estat vif
reg Customer_Ret Omnichannel_marketing Gender Age
estat vif
reg Customer_Ret Customer_Ex Gender Age
estat vif
