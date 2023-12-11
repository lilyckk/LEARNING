# 產生Colab R 程式環境: https://colab.research.google.com/notebook#create=true&language=r

install.packages("dplyr")
install.packages("ggplot2")

# Data Wrangling and Manipulation
# 數據整理和操作
library(dplyr) 
# 視覺化 Visualization
library(ggplot2)

### Bank Marketing Data Set 銀行營銷數據集------
# https://archive.ics.uci.edu/ml/datasets/bank+marketing

# Abstract: The data is related with direct marketing campaigns (phone calls) of a Portuguese banking institution. The classification goal is to predict if the client will subscribe a term deposit (variable y).
# 摘要：數據與葡萄牙銀行機構的直接營銷活動（電話）有關。
# 分類的目的是預測客戶是否將認購定期存款（變量y）。

# Attribute Information:
#   
#   Input variables:
#   # bank client data:
#   1 - age (numeric)
# 2 - job : type of job (categorical: 'admin.','blue-collar','entrepreneur','housemaid','management','retired','self-employed','services','student','technician','unemployed','unknown')
# 3 - marital : marital status (categorical: 'divorced','married','single','unknown'; note: 'divorced' means divorced or widowed)
# 4 - education (categorical: 'basic.4y','basic.6y','basic.9y','high.school','illiterate','professional.course','university.degree','unknown')
# 5 - default: has credit in default? (categorical: 'no','yes','unknown')
# 6 - housing: has housing loan? (categorical: 'no','yes','unknown')
# 7 - loan: has personal loan? (categorical: 'no','yes','unknown')
# # related with the last contact of the current campaign:
# 8 - contact: contact communication type (categorical: 'cellular','telephone')
# 9 - month: last contact month of year (categorical: 'jan', 'feb', 'mar', ..., 'nov', 'dec')
# 10 - day_of_week: last contact day of the week (categorical: 'mon','tue','wed','thu','fri')
# 11 - duration: last contact duration, in seconds (numeric). Important note: this attribute highly affects the output target (e.g., if duration=0 then y='no'). Yet, the duration is not known before a call is performed. Also, after the end of the call y is obviously known. Thus, this input should only be included for benchmark purposes and should be discarded if the intention is to have a realistic predictive model.
# # other attributes:
# 12 - campaign: number of contacts performed during this campaign and for this client (numeric, includes last contact)
# 13 - pdays: number of days that passed by after the client was last contacted from a previous campaign (numeric; 999 means client was not previously contacted)
# 14 - previous: number of contacts performed before this campaign and for this client (numeric)
# 15 - poutcome: outcome of the previous marketing campaign (categorical: 'failure','nonexistent','success')
# # social and economic context attributes
# 16 - emp.var.rate: employment variation rate - quarterly indicator (numeric)
# 17 - cons.price.idx: consumer price index - monthly indicator (numeric)
# 18 - cons.conf.idx: consumer confidence index - monthly indicator (numeric)
# 19 - euribor3m: euribor 3 month rate - daily indicator (numeric)
# 20 - nr.employed: number of employees - quarterly indicator (numeric)
# 
# Output variable (desired target):
# 21 - y - has the client subscribed a term deposit? (binary: 'yes','no')

conversionsDF <- read.csv(
  file="bank-additional-full.csv", 
  header=TRUE, 
  sep=","
)

# Shape of conversionsDF
# 轉化形式
dim(conversionsDF)
# [1] 41188    21

# Quick look at conversionsDF
# 快速瀏覽 conversionsDF
head(conversionsDF)
#   age       job marital   education default housing loan   contact month day_of_week duration
# 1  56 housemaid married    basic.4y      no      no   no telephone   may         mon      261
# 2  57  services married high.school unknown      no   no telephone   may         mon      149
# 3  37  services married high.school      no     yes   no telephone   may         mon      226
# 4  40    admin. married    basic.6y      no      no   no telephone   may         mon      151
# 5  56  services married high.school      no      no  yes telephone   may         mon      307

summary(conversionsDF)
#      age            job              marital           education           default         
# Min.   :17.00   Length:41188       Length:41188       Length:41188       Length:41188      
# 1st Qu.:32.00   Class :character   Class :character   Class :character   Class :character  
# Median :38.00   Mode  :character   Mode  :character   Mode  :character   Mode  :character  
# Mean   :40.02                                                                              
# 3rd Qu.:47.00                                                                              
# Max.   :98.00    

### Encode conversions as 0s and 1s ------
# 將轉換編碼為0和1
head(conversionsDF$y)
# [1] "no" "no" "no" "no" "no" "no"
conversionsDF$y[1:10]
# [1] "no" "no" "no" "no" "no" "no" "no" "no" "no" "no"
sum(conversionsDF$y[1:10])
# Error in sum(conversionsDF$y[1:10]) : 'type' (character) 的引數無效
sum(conversionsDF$age)
# [1] 1648511
mean(conversionsDF$age);max(conversionsDF$age);min(conversionsDF$age)
sd(conversionsDF$age)

ggplot(conversionsDF, aes(x=age)) +
  geom_histogram(alpha=0.6, binwidth=2, fill = "blue") +
  ggtitle("Customer age distribution map 顧客年齡分佈圖")+
  xlab("Customer age顧客年齡") + 
  ylab("Number of people of that age 該年齡人數數量")

conversionsDF$conversion <- ifelse(conversionsDF$y  == "no", 0, 1)

dim(conversionsDF)
# [1] 41188    22
tail(conversionsDF)
#       euribor3m nr.employed   y conversion
# 41183     1.028      4963.6  no          0
# 41184     1.028      4963.6 yes          1
# 41185     1.028      4963.6  no          0
# 41186     1.028      4963.6  no          0
# 41187     1.028      4963.6 yes          1
# 41188     1.028      4963.6  no          0
ifelse(conversionsDF$y[41188]  == "no", 0, 1)
# [1] 0
ifelse(conversionsDF$y[41187]  == "no", 0, 1)
# [1] 1

#### 1. Aggregate Conversion Rate ####
#### 1.總轉化率 ####
sum(conversionsDF$conversion)  
# [1] 4640
sum(conversionsDF$conversion[41183:41188]) 
nrow(conversionsDF)
# [1] 41188

dim(conversionsDF)[1]
dim(conversionsDF)[2]

sprintf("total conversions: %i out of %i", sum(conversionsDF$conversion), nrow(conversionsDF))
# [1] "total conversions: 4640 out of 41188"
sprintf("conversion rate: %0.2f%%", sum(conversionsDF$conversion)/nrow(conversionsDF)*100.0)
# [1] "conversion rate: 11.27%"

#### 2. Conversion Rates by Number of Contacts ####
#### 2.按聯繫數的轉化率 ####
conversionsByNumContact <- conversionsDF %>% 
  group_by(NumContact=campaign) %>% 
  summarise(TotalCount=n(), NumConversions=sum(conversion)) %>%
  mutate(ConversionRate=NumConversions/TotalCount*100.0)

conversionsByNumContact
#   NumContact TotalCount NumConversions ConversionRate
# *      <int>      <int>          <dbl>          <dbl>
# 1          1      17642           2300          13.0 
# 2          2      10570           1211          11.5 
# 3          3       5341            574          10.7 
# 4          4       2651            249           9.39
# 5          5       1599            120           7.50

head(conversionsByNumContact, 10)

# line chart
# 折線圖
ggplot(data=head(conversionsByNumContact, 56), aes(x=NumContact, y=ConversionRate)) +
  geom_line() +
  ggtitle('Conversion Rates by Number of Contacts 聯繫數的轉化率') +
  xlab("Number of Contacts 聯繫數") +
  ylab("Conversion Rate 轉化率 (%)") +
  ylim(c(0, 15)) +
  theme(plot.title = element_text(hjust = 0.5))

### Q1: What did you get from this diagram? 您從該圖中得到了什麼？ -------------

#### 3. Conversion Rates by Age ####
#### 3.按年齡劃分的轉化率####

# a. by age
# a. 按年齡
conversionsByAge <- conversionsDF %>% 
  group_by(Age=age) %>% 
  summarise(TotalCount=n(), NumConversions=sum(conversion)) %>%
  mutate(ConversionRate=NumConversions/TotalCount*100.0)

conversionsByAge

head(conversionsByAge)
#     Age TotalCount NumConversions ConversionRate
#   <int>      <int>          <dbl>          <dbl>
# 1    17          5              2           40  
# 2    18         28             12           42.9
# 3    19         42             20           47.6
# 4    20         65             23           35.4
# 5    21        102             29           28.4
# 6    22        137             36           26.3

# line chart
# 折線圖
ggplot(data=conversionsByAge, aes(x=Age, y=ConversionRate)) +
  geom_line() +
  ggtitle('Conversion Rates by Age') +
  xlab("Age") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5))

#### Q2: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

conversionsByAge %>% filter(ConversionRate >= 80)
#     Age TotalCount NumConversions ConversionRate
#   <int>      <int>          <dbl>          <dbl>
# 1    87          1              1            100
# 2    89          2              2            100
# 3    98          2              2            100

conversionsByAge %>% filter(ConversionRate == 0)
#     Age TotalCount NumConversions ConversionRate
# <int>      <int>          <dbl>          <dbl>
# 1    91          2              0              0
# 2    94          1              0              0
# 3    95          1              0              0

### b. by age groups -------
# b. 按年齡層
conversionsByAgeGroup <- conversionsDF %>% 
  group_by(AgeGroup=cut(age, breaks= seq(20, 70, by = 10)) ) %>% 
  summarise(TotalCount=n(), NumConversions=sum(conversion)) %>%
  mutate(ConversionRate=NumConversions/TotalCount*100.0)

conversionsByAgeGroup
#  AgeGroup TotalCount NumConversions ConversionRate
# * <fct>         <int>          <dbl>          <dbl>
# 1 (20,30]        7243           1067          14.7 
# 2 (30,40]       16385           1597           9.75
# 3 (40,50]       10240            837           8.17
# 4 (50,60]        6270            668          10.7 
# 5 (60,70]         488            212          43.4 
# 6 NA              562            259          46.1 

conversionsByAgeGroupBy5 <- conversionsDF %>% 
  group_by(AgeGroup=cut(age, breaks= seq(20, 70, by = 5)) ) %>% 
  summarise(TotalCount=n(), NumConversions=sum(conversion)) %>%
  mutate(ConversionRate=NumConversions/TotalCount*100.0)
conversionsByAgeGroupBy5

conversionsByAgeGroup$AgeGroup
# [1] (20,30] (30,40] (40,50] (50,60] (60,70] <NA>   
# Levels: (20,30] (30,40] (40,50] (50,60] (60,70]
class(conversionsByAgeGroup$AgeGroup)
#[1] "factor"
conversionsByAgeGroup$AgeGroup <- as.character(conversionsByAgeGroup$AgeGroup)
conversionsByAgeGroup$AgeGroup
# [1] "(20,30]" "(30,40]" "(40,50]" "(50,60]" "(60,70]" NA  

conversionsByAgeGroup$AgeGroup[6] <- "70+"
conversionsByAgeGroup$AgeGroup
# [1] "(20,30]" "(30,40]" "(40,50]" "(50,60]" "(60,70]" "70+"

conversionsByAgeGroup
#   AgeGroup TotalCount NumConversions ConversionRate
# <chr>         <int>          <dbl>          <dbl>
# 1 (20,30]        7243           1067          14.7 
# 2 (30,40]       16385           1597           9.75
# 3 (40,50]       10240            837           8.17
# 4 (50,60]        6270            668          10.7 
# 5 (60,70]         488            212          43.4 
# 6 70+             562            259          46.1 

### bar chart -----
# 長條圖
ggplot(conversionsByAgeGroup, aes(x=AgeGroup, y=ConversionRate, fill = 2:7)) +
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Conversion Rates by Age Groups') +
  xlab("Age") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 

#### Q3: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

#### 4. Conversions vs. Non-Conversions ####
#### 4.轉化與非轉化 ####

# 4.1. Marital Status
# 4.1. 婚姻狀況
conversionsByMaritalStatus <- conversionsDF %>% 
  group_by(Marital=marital, Conversion=conversion) %>% 
  summarise(Count=n())

conversionsByMaritalStatus
#   Marital  Conversion Count
#   <chr>         <dbl> <int>
# 1 divorced          0  4136
# 2 divorced          1   476
# 3 married           0 22396
# 4 married           1  2532
# 5 single            0  9948
# 6 single            1  1620
# 7 unknown           0    68
# 8 unknown           1    12

### pie chart --------------
# 圓餅圖
ggplot(conversionsByMaritalStatus, aes(x="", y=Count, fill=Marital)) + 
  geom_bar(width=1, stat = "identity", position=position_fill()) +
  geom_text(aes(x=1.25, label=Count), position=position_fill(vjust = 0.5)) +
  coord_polar("y") +
  facet_wrap(~Conversion) +
  ggtitle('Marital Status (0: Non Conversions, 1: Conversions)') +
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    plot.title=element_text(hjust=0.5),
    legend.position='bottom'
  )
#### Q4: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

### 4.2. Education --------------
# 4.2. Education 教育程度
conversionsByEducation <- conversionsDF %>% 
  group_by(Education=education, Conversion=conversion) %>% 
  summarise(Count=n())

conversionsByEducation
#   Education           Conversion Count
#   <chr>                    <dbl> <int>
# 1 basic.4y                     0  3748
# 2 basic.4y                     1   428
# 3 basic.6y                     0  2104
# 4 basic.6y                     1   188
# 5 basic.9y                     0  5572
# 6 basic.9y                     1   473
# 7 high.school                  0  8484
# 8 high.school                  1  1031
# 9 illiterate                   0    14
# 10 illiterate                   1     4
# 11 professional.course          0  4648
# 12 professional.course          1   595
# 13 university.degree            0 10498
# 14 university.degree            1  1670
# 15 unknown                      0  1480
# 16 unknown                      1   251

# pie chart
# 圓餅圖
ggplot(conversionsByEducation, aes(x="", y=Count, fill=Education)) + 
  geom_bar(width=1, stat = "identity", position=position_fill()) +
  geom_text(aes(x=1.25, label=Count), position=position_fill(vjust = 0.5)) +
  coord_polar("y") +
  facet_wrap(~Conversion) +
  ggtitle('Education (0: Non Conversions, 1: Conversions)') +
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    plot.title=element_text(hjust=0.5),
    legend.position='bottom'
  )

#### Q5: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

### 4.3.1. Last Contact Duration by seconds -----------
# 4.3.1. 上次聯絡時間(以秒計算)

ggplot(conversionsDF, aes(x="", y=duration)) + 
  geom_boxplot() +
  facet_wrap(~conversion) +
  ylab("duration (in seconds)") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Last Contact Duration") +
  theme(plot.title=element_text(hjust=0.5))

# 4.3.1. Last Contact Duration by seconds
# 4.3.1. 上次聯絡時間(以小時計算)

conversionsDF$durationHr <- conversionsDF$duration / (60*60)

ggplot(conversionsDF, aes(x="", y=durationHr)) + 
  geom_boxplot() +
  facet_wrap(~conversion) +
  ylab("duration (in hours)") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Last Contact Duration") +
  theme(plot.title=element_text(hjust=0.5))

conversionsDFsd = conversionsDF %>% 
  filter(conversionsDF$duration <= (mean(conversionsDF$duration)+ 
                                      2 * sd(conversionsDF$duration)))

ggplot(conversionsDFsd, aes(x="", y=durationHr)) + 
  geom_boxplot() +
  facet_wrap(~conversion) +
  ylab("duration (in hours)") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Last Contact Duration") +
  theme(plot.title=element_text(hjust=0.5))

ggplot(conversionsDFsd, aes(x="", y=duration)) + 
  geom_boxplot() +
  facet_wrap(~conversion) +
  ylab("duration (in hours)") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Last Contact Duration") +
  theme(plot.title=element_text(hjust=0.5))

#### Q6: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

#### 5. Conversions by Age Groups & Marital Status ####
#### 5.按年齡段和婚姻狀況劃分的轉換 ####
conversionsByAgeMarital <- conversionsDF %>% 
  group_by(AgeGroup=cut(age, breaks= seq(20, 70, by = 10)), Marital=marital) %>% 
  summarise(Count=n(), NumConversions=sum(conversion)) %>%
  mutate(TotalCount=sum(Count)) %>%
  mutate(ConversionRate=NumConversions/TotalCount)

conversionsByAgeMarital$AgeGroup <- as.character(conversionsByAgeMarital$AgeGroup)
conversionsByAgeMarital$AgeGroup[is.na(conversionsByAgeMarital$AgeGroup)] <- "70+"

# bar chart
# 長條圖
ggplot(conversionsByAgeMarital, aes(x=AgeGroup, y=ConversionRate, fill=Marital)) + 
  geom_bar(width=0.5, stat="identity", position="dodge") +
  ylab("Conversion Rate (%)") +
  xlab("Age") +
  ggtitle("Conversion Rates by Age and Marital Status") +
  theme(plot.title=element_text(hjust=0.5))

#### Q7: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

# stacked bar chart
# 堆積長條圖
ggplot(conversionsByAgeMarital, aes(x=AgeGroup, y=ConversionRate, fill=Marital)) + 
  geom_bar(width=0.9, stat="identity", position="stack") +
  ylab("Conversion Rate (%)") +
  xlab("Age") +
  ggtitle("Conversion Rates by Age and Marital Status") +
  theme(plot.title=element_text(hjust=0.5))

#### Q8: What did you get from this diagram? 您從該圖中得到了什麼？ ------------

names(conversionsDF)
# [1] "age"            "job"            "marital"        "education"      "default"       
# [6] "housing"        "loan"           "contact"        "month"          "day_of_week"   
# [11] "duration"       "campaign"       "pdays"          "previous"       "poutcome"      
# [16] "emp.var.rate"   "cons.price.idx" "cons.conf.idx"  "euribor3m"      "nr.employed"   
# [21] "y"              "conversion"     "durationHr"   

#### Homework: Using "job" "housing" and "loan" to practice.-----
#### 用“工作”，“住房”和“貸款”進行練習。 -----------------