# -------------------------------------------------
# ERSA2016_pgm001_supertab.R
# 2 Feb. 2011 - rev. Aug. 2016
# (c) Claude Grasland, UniversitÈ Paris Diderot
# (c) TimothÈe Giraud, GIS CIST
# (c) Laurent Beauguitte
# -------------------------------------------------


# =================================================================
# (A) INITIALISATION
# =================================================================

# Declare packages  
library(reshape)


# Clear workspace
rm(list=ls())

# Define directory 
setwd("H:/ERSA2016")
#setwd("/Volumes/NO NAME/ERSA2016")


list.files()


# =====================
# (B) IMPORT DATABASE 
# =====================

ori<-read.csv( "data/ebm_survey_v8.csv",
               header=TRUE,
               sep="\t",
               dec=".",
               encoding="utf-8"
)
head(ori)
# codify the city of survey
ori$G_place<-paste(ori$G_State,ori$G_City,sep="_")

# Selection of questionnary with minimum 1 answer to question B1

tab<-ori
tab<-tab[tab$B1_CIT_NB!=0,]

# Selection of questionnary with minimum 1 answer to each question B1 & B2
answer<-table(tab$B1_CIT_NB,tab$B2_STA_NB)

# Evaluation of selected sample size by city of survey

NB_ori<-data.frame(table(ori$G_place))
names(NB_ori)<-c("City","total")

NB_tab<-data.frame(table(tab$G_place))
names(NB_tab)<-c("City","answer")

Sample<-merge(NB_ori,NB_tab,by="City", all.y=TRUE)
Sample$pct<-Sample$answer/Sample$total
names(Sample)<-c("city_survey","tot","nba","pct")
write.table(Sample,"data/ebm_supertab_city_survey.txt",quote=FALSE,row.names=FALSE,sep="\t", dec=",")


# Evaluation of selected sample size by state of survey

NB_ori<-data.frame(table(ori$G_State))
names(NB_ori)<-c("state","total")

NB_tab<-data.frame(table(tab$G_State))
names(NB_tab)<-c("state","answer")


Sample<-merge(NB_ori,NB_tab,by="state", all.y=TRUE)
Sample$pct<-Sample$answer/Sample$total
names(Sample)<-c("state_survey","tot","nba","pct")
write.table(Sample,"data/ebm_supertab_state_survey.txt",quote=FALSE,row.names=FALSE,sep="\t", dec=",")


# ===========================
# (C) CREATION OF SUPER_TABLE 
# ===========================

# (C.1) State ... like to live
head(tab)
R1<-data.frame(tab$Code,tab$B2_STALIK1_iso)
names(R1)<-c("Code","state")
R1$city<-NA
R1$name<-tab$B2_STALIK1_eng
R1$type<-"B2"
R1$rank<-1

R2<-data.frame(tab$Code,tab$B2_STALIK2_iso)
names(R2)<-c("Code","state")
R2$city<-NA
R2$name<-tab$B2_STALIK2_eng
R2$type<-"B2"
R2$rank<-2

R3<-data.frame(tab$Code,tab$B2_STALIK3_iso)
names(R3)<-c("Code","state")
R3$city<-NA
R3$name<-tab$B2_STALIK3_eng
R3$type<-"B2"
R3$rank<-3

R4<-data.frame(tab$Code,tab$B2_STALIK4_iso)
names(R4)<-c("Code","state")
R4$city<-NA
R4$name<-tab$B2_STALIK4_eng
R4$type<-"B2"
R4$rank<-4

R5<-data.frame(tab$Code,tab$B2_STALIK5_iso)
names(R5)<-c("Code","state")
R5$city<-NA
R5$name<-tab$B2_STALIK5_eng
R5$type<-"B2"
R5$rank<-5

stalik<-rbind(R1,R2,R3,R4,R5)
stalik$lik<-1

# (C.2) State ... not like to live

R1<-data.frame(tab$Code,tab$B2_STAUNL1_iso)
names(R1)<-c("Code","state")
R1$city<-NA
R1$name<-tab$B2_STAUNL1_eng
R1$type<-"B2"
R1$rank<-1

R2<-data.frame(tab$Code,tab$B2_STAUNL2_iso)
names(R2)<-c("Code","state")
R2$city<-NA
R2$name<-tab$B2_STAUNL2_eng
R2$type<-"B2"
R2$rank<-2

R3<-data.frame(tab$Code,tab$B2_STAUNL3_iso)
names(R3)<-c("Code","state")
R3$city<-NA
R3$name<-tab$B2_STAUNL3_eng
R3$type<-"B2"
R3$rank<-3

R4<-data.frame(tab$Code,tab$B2_STAUNL4_iso)
names(R4)<-c("Code","state")
R4$city<-NA
R4$name<-tab$B2_STAUNL4_eng
R4$type<-"B2"
R4$rank<-4

R5<-data.frame(tab$Code,tab$B2_STAUNL5_iso)
names(R5)<-c("Code","state")
R5$city<-NA
R5$name<-tab$B2_STAUNL5_eng
R5$type<-"B2"
R5$rank<-5

staunl<-rbind(R1,R2,R3,R4,R5)
staunl$lik<--1



# (C.3) City ... like to live

R1<-data.frame(tab$Code,tab$B1_CITLIK1_State,tab$B1_CITLIK1_Code,tab$B1_CITLIK1_Name)
names(R1)<-c("Code","state","city","name")
R1$type<-"B1"
R1$rank<-1

R2<-data.frame(tab$Code,tab$B1_CITLIK2_State,tab$B1_CITLIK2_Code,tab$B1_CITLIK2_Name)
names(R2)<-c("Code","state","city","name")
R2$type<-"B1"
R2$rank<-2

R3<-data.frame(tab$Code,tab$B1_CITLIK3_State,tab$B1_CITLIK3_Code,tab$B1_CITLIK3_Name)
names(R3)<-c("Code","state","city","name")
R3$type<-"B1"
R3$rank<-3

R4<-data.frame(tab$Code,tab$B1_CITLIK4_State,tab$B1_CITLIK4_Code,tab$B1_CITLIK4_Name)
names(R4)<-c("Code","state","city","name")
R4$type<-"B1"
R4$rank<-4

R5<-data.frame(tab$Code,tab$B1_CITLIK5_State,tab$B1_CITLIK5_Code,tab$B1_CITLIK5_Name)
names(R5)<-c("Code","state","city","name")
R5$type<-"B1"
R5$rank<-5

citlik<-rbind(R1,R2,R3,R4,R5)
citlik$lik<-1

# (C.4) City ... not like to live

R1<-data.frame(tab$Code,tab$B1_CITUNL1_State,tab$B1_CITUNL1_Code,tab$B1_CITUNL1_Name)
names(R1)<-c("Code","state","city","name")
R1$type<-"B1"
R1$rank<-1

R2<-data.frame(tab$Code,tab$B1_CITUNL2_State,tab$B1_CITUNL2_Code,tab$B1_CITUNL2_Name)
names(R2)<-c("Code","state","city","name")
R2$type<-"B1"
R2$rank<-2

R3<-data.frame(tab$Code,tab$B1_CITUNL3_State,tab$B1_CITUNL3_Code,tab$B1_CITUNL3_Name)
names(R3)<-c("Code","state","city","name")
R3$type<-"B1"
R3$rank<-3

R4<-data.frame(tab$Code,tab$B1_CITUNL4_State,tab$B1_CITUNL4_Code,tab$B1_CITUNL4_Name)
names(R4)<-c("Code","state","city","name")
R4$type<-"B1"
R4$rank<-4

R5<-data.frame(tab$Code,tab$B1_CITUNL5_State,tab$B1_CITUNL5_Code,tab$B1_CITUNL5_Name)
names(R5)<-c("Code","state","city","name")
R5$type<-"B1"
R5$rank<-5

citunl<-rbind(R1,R2,R3,R4,R5)
citunl$lik<-(-1)

# (C.5)Compilation of all places 

mega<-rbind(stalik,staunl,citlik,citunl)

# =================================
# (D) CORRECTION OF COUNTRIES CODES 
# =================================

# (D.1) Recodification of part of countries

GBR<-mega[substr(mega$state,3,5)=="GBR",]
GBR$state<-"GBR"
mega<-mega[substr(mega$state,3,5)!="GBR",]

USA<-mega[substr(mega$state,3,5)=="USA",]
USA$state<-"USA"
mega<-mega[substr(mega$state,3,5)!="USA",]

CHN<-mega[substr(mega$state,3,5)=="CHN",]
CHN$state<-"CHN"
mega<-mega[substr(mega$state,3,5)!="CHN",]

RUS<-mega[substr(mega$state,3,5)=="RUS",]
RUS$state<-"RUS"
mega<-mega[substr(mega$state,3,5)!="RUS",]

RUS2<-mega[mega$state=="SUHH",]
RUS2$state<-"RUS"
mega<-mega[mega$state!="SUHH",]

YUG<-mega[mega$state=="YUCS",]
YUG$state<-"SRB"
mega<-mega[mega$state!="YUCS",]

YUG2<-mega[mega$state=="X-SRB1",]
YUG2$state<-"SRB"
mega<-mega[mega$state!="X-SRB1",]

# (D.2) Fusion of countries

FRA<-mega[mega$state=="MCO",]
FRA$state<-"FRA"
mega<-mega[mega$state!="MCO",]

CHE<-mega[mega$state=="LIE",]
CHE$state<-"CHE"
mega<-mega[mega$state!="LIE",]

CHE2<-mega[mega$state=="SWZ",]
CHE2$state<-"CHE"
mega<-mega[mega$state!="SWZ",]

YUG3<-mega[mega$state=="MNE",]
YUG3$state<-"SRB"
mega<-mega[mega$state!="MNE",]

USA2<-mega[mega$state=="UMI",]
USA2$state<-"USA"
mega<-mega[mega$state!="UMI",]

ITA<-mega[mega$state=="VAT",]
ITA$state<-"ITA"
mega<-mega[mega$state!="VAT",]

#mega<-mega[mega$state!="",]
#mega<-mega[substr(mega$state,4,4)=="",]

mega<-rbind(mega,GBR,USA,USA2,CHN,RUS,RUS2,YUG,YUG2,YUG3,FRA,CHE,CHE2,ITA)

mega$state<-as.character(mega$state)

# =================================
# (E) CORRECTION OF CITIES CODES 
# =================================

# (E.1) Fusion & Recodification of cities

NOCITY<-mega[mega$type!="B1",]
mega<-mega[mega$type=="B1",]

OTHER1<-mega[mega$city=="CAM",]
OTHER1$city<-"OTHER"
mega<-mega[mega$city!="CAM",]

OTHER2<-mega[mega$city=="GEC",]
OTHER2$city<-"OTHER"
mega<-mega[mega$city!="GEC",]

OTHER3<-mega[mega$city=="XXXX",]
OTHER3$city<-"OTHER"
mega<-mega[mega$city!="XXXX",]

OTHER4<-mega[mega$city=="GEO",]
OTHER4$city<-"OTHER"
mega<-mega[mega$city!="GEO",]

OTHER5<-mega[mega$city=="GOI",]
OTHER5$city<-"OTHER"
mega<-mega[mega$city!="GOI",]

OTHER6<-mega[mega$city=="SJO",]
OTHER6$city<-"OTHER"
mega<-mega[mega$city!="SJO",]

CGN<-mega[mega$city=="BON1",]
CGN$city<-"CGN"
mega<-mega[mega$city!="BON1",]

GUA<-mega[mega$city=="MIX",]
GUA$city<-"GUA"
mega<-mega[mega$city!="MIX",]

ISB<-mega[mega$city=="RAW",]
ISB$city<-"ISB"
mega<-mega[mega$city!="RAW",]

JNB<-mega[mega$city=="SOW",]
JNB$city<-"JNB"
mega<-mega[mega$city!="SOW",]

KIN1<-mega[mega$city=="NLK",]
KIN1$city<-"KIN1"
mega<-mega[mega$city!="NLK",]

LAX<-mega[mega$city=="HOL",]
LAX$city<-"LAX"
mega<-mega[mega$city!="HOL",]

KWI<-mega[mega$city=="HAW",]
KWI$city<-"KWI"
mega<-mega[mega$city!="HAW",]

NCE<-mega[mega$city=="CAN2",]
NCE$city<-"NCE"
mega<-mega[mega$city!="CAN2",]

OSA<-mega[mega$city=="KOB",]
OSA$city<-"OSA"
mega<-mega[mega$city!="KOB",]

ROM<-mega[mega$city=="VAT",]
ROM$city<-"ROM"
mega<-mega[mega$city!="VAT",]

SZG<-mega[mega$city=="SAL2",]
SZG$city<-"SZG"
mega<-mega[mega$city!="SAL2",]

TYO<-mega[mega$city=="YOK",]
TYO$city<-"TYO"
mega<-mega[mega$city!="YOK",]

MFM<-mega[mega$city=="MFM",]
MFM$state<-"CHN"
mega<-mega[mega$city!="MFM",]

final<-rbind(NOCITY,mega,OTHER1,OTHER2,OTHER3,OTHER4,OTHER5,OTHER6,CGN,GUA,ISB,JNB,KIN1,KWI,LAX,NCE,OSA,ROM,SZG,TYO,MFM)
final$city<-as.character(final$city)


# ====================================
# (F) ADDITION OF INDIVIDUAL ATTRIBUTES
# ====================================


# Addition of other variable of interest
head(tab,1)
supvar<-data.frame(tab$Code,tab$G_place,tab$G_Study,tab$A1_Gender,tab$B1_CITLIK_NB,tab$B1_CITUNL_NB,tab$B2_STALIK_NB,tab$B2_STAUNL_NB,tab$A4_Nat1_State)
names(supvar)<-c("Code","survey","study","gender","citlik_nb","citunl_nb","stalik_nb","staunl_nb","stnat")
supertab<-merge(final,supvar,by="Code", all.y=TRUE)
supertab<-supertab[order(supertab$Code,supertab$type,supertab$lik,supertab$rank),]
tail(supertab,5)
# ===========================
# (G) EXPORTATION OF SUPER_TABLE 
# ===========================


write.table(supertab,"data/ebm_supertab_questB.txt",
            row.names=FALSE,
            sep="\t", 
            dec=",",
            fileEncoding="utf-8")
warnings()