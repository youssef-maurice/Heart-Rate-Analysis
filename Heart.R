---
title: "asgn2"
output: html_document
---
PART A:
```{r}
#PART A:
library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")
class(heart_tbl)
heart_tbl

ggplot(heart_tbl, aes(x=Sex, y=RestingBP,fill=Sex))+
 geom_boxplot() + ggtitle("a) RestingBP for each Sex")

ggplot(heart_tbl, aes(x=RestingBP,group=Sex,fill=Sex)) +
geom_histogram(bins=25,col="black") +
facet_wrap(~Sex)+ ggtitle("b) RestingBP for each Sex")

#the barplot is useless.
ggplot(heart_tbl,aes(x=Sex,fill=RestingECG)) +
 geom_bar(position="dodge") +
 ylab("RestingECG levels for each sex") + ggtitle("c) RestingECG for each Sex")
```
ANSWER:

To assess the patients' resting heart rates, two factors come into play: the resting BP and the Resting ECG as they are both related to the heart rate. From the boxplots (panel A), we can see that for both sexes that the median and the IQR are the same for the Resting BP. However, we can notice that when the sex is Male there are more outliers. The histograms (panel B), reiterate the fact that there is no dramatic difference between the sexes' Resting BP. The difference in size between the bins' lengths is due to the fact that there are only 193 females while there are 725 males. However the spreads are all the same and both histograms are slightly skewed to the right. From the barplot (panel c), we can see that the major proportion for both sexes' Resting ECG falls into the normal category. The only difference is that for the female subjects have an LVH RestingECG higher than an ST RestingECG, which is the inverse for the male subjects. In conclusion, we can deduce that there is no association between the sex of the patient and their resting heart rates. There is not a difference in distribution of the resting heart rates across the sexes.


PART B: CHOOSE SECOND OPTION
```{r}
#PART B:
library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")


ggplot(heart_tbl,aes(x=ChestPainType,fill=RestingECG)) +
 geom_bar() + scale_fill_viridis_d() + ylab("level of RestingECG")

#CHOOSE THIS ONE
ggplot(heart_tbl,aes(x=RestingECG,fill=ChestPainType)) +
 geom_bar() + scale_fill_viridis_d() + ylab("level of RestingECG")
```

PART C:
```{r}
#PART C:
library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")

heart_tbl %>% group_by(Sex,ChestPainType,RestingECG) %>%  summarise(count=n())  %>%
 mutate(prop=count/sum(count))

```

PART D:
```{r}
#PART D:
library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")

heart_tbl %>% group_by(ChestPainType) %>% select(ChestPainType,RestingBP,Cholesterol,FastingBS,MaxHR) %>%
 
        summarise_all(list(Avg=mean,Med=median,IQR=IQR)) %>%
 
        pivot_longer(cols= c("RestingBP_Avg","RestingBP_Med","RestingBP_IQR","Cholesterol_Avg","Cholesterol_Med","Cholesterol_IQR","FastingBS_Avg","FastingBS_Med","FastingBS_IQR","MaxHR_Avg","MaxHR_Med","MaxHR_IQR"),names_to = "Measure")# %>%
 
        #pivot_wider(id_cols=Measure,names_from=ChestPainType) %>%
 #arrange(desc(Measure))
```

PART E:
```{r}
#PART E:
library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")

ggplot(heart_tbl, aes(x=HeartDisease, y=RestingBP,fill=HeartDisease))+
 geom_boxplot() + ggtitle("Panel 1a")+ scale_fill_continuous(type = "viridis") +
facet_wrap(~HeartDisease)

ggplot(heart_tbl, aes(x=RestingBP,group=HeartDisease,fill=HeartDisease)) +
geom_histogram(bins=25,col="black") + ggtitle("Panel 1b") + scale_fill_continuous(type = "viridis") +
facet_grid(rows=vars(HeartDisease))

ggplot(heart_tbl, aes(x=HeartDisease, y=Cholesterol,fill=HeartDisease))+
 geom_boxplot() + ggtitle("Panel 2a")+ scale_fill_continuous(type = "viridis") +
facet_wrap(~HeartDisease)

ggplot(heart_tbl, aes(x=Cholesterol,group=HeartDisease,fill=HeartDisease)) +
geom_histogram(bins=25,col="black") + ggtitle("Panel 2b") + scale_fill_continuous(type = "viridis") +
facet_grid(rows=vars(HeartDisease))

ggplot(heart_tbl, aes(x=HeartDisease, y=MaxHR,fill=HeartDisease))+
 geom_boxplot() + ggtitle("Panel 3a")+ scale_fill_continuous(type = "viridis") +
facet_wrap(~HeartDisease)

ggplot(heart_tbl, aes(x=MaxHR,group=HeartDisease,fill=HeartDisease)) +
geom_histogram(bins=25,col="black") + ggtitle("Panel 3b") + scale_fill_continuous(type = "viridis") +
facet_grid(rows=vars(HeartDisease))

ggplot(heart_tbl,aes(x=FastingBS,fill=FastingBS)) +
 geom_bar()+ scale_fill_continuous(type = "viridis")+
 labs(title="Panel 4") + facet_wrap(~HeartDisease)
```
ANSWER:

From panels 1a and 1b, we can see that Resting BP is not associated with Heart Disease. According to the boxplot 1a, both heart conditions have approximately the same median, IQR and spread. In addition to this, both histograms in 1b are alike in shape.

From panels 2a and 2b, we can see that for all non zero values, Cholesterol and Heart Disease are not associated. In contrast, for a cholesterol value of 0, most of the subjects have heart disease. This is illustrated by the lower quartile in 2a which occupies a significantly larger area of the grid than that of those not having heart disease. Moreover, the first bin on the left in both histograms in panel 2b reiterates the fact that most subjects with cholesterol 0 have a heart disease because it surpasses a count of 150.

From panels 3a and 3b, we can see that Max HR is associated with Heart Disease, however not strongly. From the boxplot, we can note the median of those not having a heart disease is slightly higher reaching 150 whilst that of those with a disease is barely above 125. In addition to this, both histograms in 3b look fairly similar, however that belonging to those without a heart disease is skewed to the left whilst the other one is more symmetrical.

From panel 4, we can see that Fasting BS is strongly associated with Heart Disease. When the Fasting BS is 0, the distribution of subjects is fairly similar. The difference is illustrated by subjects having a FastingBS of 1. From the barplot, we can see that they are a lot more likely to have a heart disease than not.

In conclusion, we have seen that whilst Max HR is associated with Heart Disease, it is Cholesterol (for a value of 0) and Fasting BS (for a value of 1) that are strongly associated with Heart Disease.


PART F:
```{r}
#PART F:
library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")

#2D-HISTOGRAM
ggplot(heart_tbl,aes(x=RestingBP,y=MaxHR)) + geom_bin2d(bins=50) +
scale_fill_continuous(type = "viridis") +
labs(x="RestingBP",y="MaxHR")

#2D-CONTOUR PLOTS
ggplot(heart_tbl,aes(x=RestingBP,y=MaxHR)) +
stat_density_2d(bins=80,aes(fill = ..level..),
geom = "polygon") + scale_fill_continuous(type = "viridis") +
labs(x="RestingBP",y="MaxHR")+
ylim(c(0,250)) +
xlim(c(0,250))

```
ANSWER:

Both plots assess the association between RestingBP and MaxHR. We can see that the data is concentrated in the middle of the grid. Meaning that for a resting BP in between 100 and 150, and a max HR between 100 and 150, that is where most of the subjects lie. We can also note that on the periphery, the number of subjects is less since the color scale goes darker, leading us to believe that those are the more abnormal cases. Furthermore, we can see that there are some peculiar cases such as the group of patients having a resting BP of 200 with a max HR of 75 (in the contour plot). We can therefore deduce that the under normal conditions, both variables should fall between 100 and 150.

Personally, I think the 2-d contour plot is a better choice to asses the association between RestingBP and MaxHR than the 2-d histogram. The data given does not help us produce enough bins to determine a pattern from the 2-d histogram (even after changing the bins number). In addition to this it is harder to read because the bins with a higher count (colored in greenish yellow) are scattered and have darker ones in their middle, making it harder to extract any kind of information from the data. In contrast, by looking like a heat map, the 2-d contour plot helps us visualize the given data by representing the difference between levels gradually. We are therefore able to find the association between the two variables given.

PART G
```{r}
#PART G:

library(tidyverse)
library(ggplot2)
heart_tbl<-read_csv("heart.csv")

ggplot(heart_tbl,aes(x=RestingBP,y= MaxHR)) +
        stat_density2d(aes(fill=..level..),geom="polygon")+
        scale_fill_continuous(type = "viridis") +
        labs(x="RestingBP",y="MaxHR",title = "A)RestingBP and MaxHR for each ChestPainType")+
        ylim(c(50,210)) + xlim(c(80,210))+
        facet_wrap(vars(ChestPainType))

ggplot(heart_tbl,aes(x=RestingBP,y= MaxHR)) +
        stat_density2d(aes(fill=..level..),geom="polygon")+
        scale_fill_continuous(type = "viridis") +
        labs(x="RestingBP",y="MaxHR",title = "B) RestingBP and MaxHR for each HeartDisease")+
        ylim(c(50,210)) + xlim(c(80,210))+
        facet_wrap(vars(HeartDisease))

ggplot(heart_tbl,aes(x=RestingBP,y= MaxHR)) +
        stat_density2d(aes(fill=..level..),geom="polygon")+
        scale_fill_continuous(type = "viridis") +
        labs(x="RestingBP",y="MaxHR",title = "C) RestingBP and MaxHR for each ChestPainType/HeartDisease factor combination")+
        ylim(c(50,210)) + xlim(c(80,210))+
        facet_grid(cols=vars(ChestPainType),rows=vars(HeartDisease))
```
ANSWER:

To determine whether the association in  between RestingBP and MaxHR depends on either the Chest Pain Type or the Heart Disease status (or both), I produced three panels each containing multiple 2D contour plots. The first (panel A), illustrates the association shown in f with each Chest Pain Type. The second (panel B), the association shown in f with Heart Disease. The third (panel C), the association shown in f with both Chest Pain Type and Heart Disease.

From  panel A, we can see that approximately all the 2D contour plots have the same silhouette. For the ATA Chest Pain Type, the peak is slightly higher surpassing a MaxHr of 150. However the difference between all 4 plots is insignificant that no information of value can be deduced. 

From  panel B, we can see that approximately both 2D contour plots have the same silhouette. For subjects with Heart Disease, the peak of the plot seems to be lower than that of those without a disease on the MaxHR . However the difference between all 2 plots is insignificant that no information of value can be deduced.

From panel C, we can see that all 2D contour plots have the same silhouette. While some ChestPainType/HeartDisease factor combinations are different, such as the ATA/0, NAP/0 plotS with higher peaks than the others on the MaxHR scale. In contrast, ASY/1, NAP/1 and TA/1 are characterized by their low peaks on the MaxHR scale. In spite of these small differences, the range of where the data falls for all the 2D contour plot is the same. In other words the differences between all the 2D contour plots are insignificant, leading us to believe that the amount of data given, when divided into 8 subcategories does not give us much information to deduce any indicative association between the association shown in part f and the Chest Pain Type or the Heart Disease status (or both).














