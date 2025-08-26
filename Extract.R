library(dplyr)
library(labelled)
library(readxl)
x <-read.table("data/2010/ebm_complete.csv", header=T, sep=";",quote='"', stringsAsFactors = T, na.strings = "")
saveRDS(x,"data/2010/ebm2010.RDS")
names(x)

y<-read.table("data/2010/ebm_meta.csv", header=T, sep=";",quote='"', stringsAsFactors = F, na.strings = "")
var_label(x)<-y$Explanation
saveRDS(x,"data/2010/ebm2010.RDS")

sel <- x %>% select(id= Code, cit=G_City, sta=G_State, stu=G_Study, 
                    sex=A1_Gender, age=A2_Age, nai=A3_Born_i, nat=A4_Nat1_State,
                    inc = A10_LevInc_raw, lev = A13_Rank1_max, rel = A14_Relig, 
                    rel_name = A14_Relig_Niv1, 
                    citlik1= B1_CITLIK1_Name, citlik2=B1_CITLIK2_Name, citlik3=B1_CITLIK3_Name,citlik4=B1_CITLIK4_Name,citlik5=B1_CITLIK5_Name,
                    citunl1 = B1_CITUNL1_Name, citunl2 = B1_CITUNL2_Name, citunl3 = B1_CITUNL3_Name,citunl4 = B1_CITUNL4_Name,citunl5 = B1_CITUNL5_Name,
                    stalik1 = B2_STALIK1_iso, stalik2 = B2_STALIK2_iso, stalik3 = B2_STALIK3_iso,  stalik4 = B2_STALIK4_iso, stalik5 = B2_STALIK5_iso, 
                    staunl1 = B2_STAUNL1_iso, staunl2 = B2_STAUNL2_iso, staunl3 = B2_STAUNL3_iso,  staunl4 = B2_STAUNL4_iso, staunl5 = B2_STAUNL5_iso,
                   eur1 = D2_answ1, eur2 = D2_answ2, eur3 = D2_answ3,
                    eur4 = D2_answ4, eur5 = D2_answ5) %>% 
              mutate(eur = paste(eur1,eur2,eur3,eur4,eur5, sep=", "))

sel$rel<-as.factor(sel$rel)
levels(sel$rel)
levels(sel$rel)<-c("Non/RR/NA", "Oui")
levels(sel$lev)<- c(NA, "(1) Loc" ,"(2) Inf", "(3) Nat", "(4) Sup" ,"(5) Glo", NA)
levels(sel$cit)<-c("Alexandrie", "Bakou", "Pékin", "Bangalore", "Bruxelles", "Buea", "Budapest", "Bucarest", "Guangzhou", 
                    "Coimbra", "Delhi", "Dakar", "Douala", "Dschang", "Erzerum", "Evora", "Fortaleza",
                    "Iasi", "Istanbul", "Izmir" ,"Khabarovsk", "Chisinau", "Le Havre", "Louvain", "Liège", "Lyon",
                    "Lisbonne", "Chennai", "Manaus", "Malte", "Moscou", "Maroua", "Ngaoundere" ,"Nanjing",
                   "Paris" ,"Pondichery" ,"Porto Alegre", "Sao Paulo" ,"Sfax" ,"Shangaï", "Stockholm" ,
                   "Stavropol", "Tunis", "Wuhan", "Yaounde" ,"Yekaterinburg")

summary(sel)



saveRDS(sel, "data/2010/ebm2010_sel.RDS")
library(writexl)
write_xlsx(sel, "data/2010/ebm2010_sel.xlsx")
