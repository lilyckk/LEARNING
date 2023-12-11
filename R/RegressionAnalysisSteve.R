# Objective:
#   The IBM-Watson Marketing Customer Value data set contains the results of an auto insurance company's marketing campaign to retain customers by offering customers with expiring policies one of four different renewal proposals. Unfortunately the purchase response rates to the offers have been low with most renewals denied. If customers who denied their proposal received one of the other 3 proposals would their response been different?
# 
# The main objective of this analysis will try to answer that question by creating a predictive model that will attempt to pair the customer with the one of four renewal proposals that has the highest probability of being accepted. Along the way, this analysis will also explore the data for insights about the customers that could lead to better customer retention.
# 目的：
# IBM-Watson營銷客戶價值數據集包含汽車保險公司營銷活動的結果，該營銷活動是通過為客戶提供四個不同續訂提案之一的到期保單來保留客戶。 不幸的是，對報價的購買響應率很低，大多數續訂都被拒絕。 如果拒絕投標的客戶收到了其他三個投標之一，他們的答復會有所不同嗎？
# 
# 該分析的主要目標將通過創建一個預測模型來嘗試回答該問題，該模型將嘗試將客戶與四個被接受的可能性最高的續訂提案之一配對。 在此過程中，此分析還將探索數據，以獲取有關客戶的見解，從而可以更好地留住客戶。

# Highlights:
#   Exploratory Data Analysis on Customer Lifetime Value, Renewal Offers and Customer Responses.
# Association Rules Mining (ARM) to discover customer qualities associated with accepting a renewal.
# Random Forest prediction model to pair customers with a renewal offer they are most likely to accept.
# K-Means Cluster Analysis for customer segmentation.
# Decision Tree Classification to identify potential Customer Lifetime Value.
# 強調：
# 關於客戶生命週期價值，續約報價和客戶響應的探索性數據分析。
# 關聯規則挖掘（ARM），以發現與接受續訂相關的客戶素質。
# 隨機森林預測模型可將客戶與他們最有可能接受的續訂報價配對。
# K-均值聚類分析用於客戶細分。
# 決策樹分類，以識別潛在的客戶生命週期價值。

# About the Data
# The data has 9134 customer records with 24 variables (14 policy profile variables and 10 customer profile variables). All customers in the data have policies expiring between Jan 1 to Feb 28, 2011. Definitions for each variable are provided below.
# 數據具有9134個客戶記錄，其中包含24個變量（14個策略配置文件變量和10個客戶配置文件變量）。 數據中的所有客戶的策略在2011年1月1日至2月28日之間到期。下面提供了每個變量的定義。
# 
# Policy Profile Variables
# 
# Customer: Customer ID number
# Customer Lifetime Value: Customer's total worth to business over life of the relationship
# Response: Yes or No response to a renewal offer
# Coverage: Type of policy (Basic, Extended, Premium)
# Monthly Premium Auto: Amount of customers' monthly insurance payments
# Months Since Last Claim: Number of months between customers' last reported insurance claim
# Months Since Policy Inception: Number of months since customer began an insurance policy
# Number of Open Complaints: Number of unresolved customer complaints
# Number of Policies: Number of policies customer currently owns
# Policy Type: (Corporate Auto, Personal Auto, Special Auto)
# Policy: 3 levels (L1, L2, L3) per Policy Type (Corporate, Personal, Special)
# Renew Offer Type: 4 types of renewal offers (Offer 1, Offer 2, Offer 3, Offer 4)
# Sales Channel: Channels to purchase a policy (Agent, Branch, Call Center, Web)
# Total Claim Amount: Cummulative amount of claims since policy inception
# 策略配置文件變量
# 
# 客戶：客戶編號
# 客戶生命週期價值：客戶在整個生命週期中對業務的總價值
# 回复：是或否。
# 承保範圍：保單類型（基本，擴展，高級）
# 每月高級汽車保險：客戶每月的保險金金額
# 自上次索賠以來的月數：客戶最近一次報告保險索賠之間的月數
# 自保單成立之月起：客戶開始購買保單以來的月數
# 未決投訴數量：未解決的客戶投訴數量
# 保單數量：客戶當前擁有的保單數量
# 策略類型：（公司自動，個人自動，特殊自動）
# 策略：每個策略類型（公司，個人，特殊）三個級別（L1，L2，L3）
# 續訂要約類型：4種續訂要約（要約1，要約2，要約3，要約4）
# 銷售渠道：購買保單的渠道（代理商，分支機構，呼叫中心，網絡）
# 索賠總額：自保單生效以來的累計索賠額
# Customer Profile Variables
# 
# State: State of residence or business
# Education: Level of education (High School or less, College, BA, MA , PHD)
# Effective To Date: Date the policy expires
# Employment Status: (Employed, Unemployed, Retired, Disabled, Medical Leave)
# Gender: Male or Female
# Income: Customers' annual income
# Location Code: (Rural, Suburban, Urban)
# Marital Status: (Single, Married, Divorced)
# Vehicle Class: Type of vehicle (4-Door, Luxury, Luxury SUV, Sports Car, SUV, 2-Door)
# Vehicle Size: (Large, Midsize, Small)
# 客戶資料變量
# 
# 州：居住或營業州
# 教育程度：受教育程度（高中或以下，大學，文學士，文學士，博士學位）
# 生效日期：保單過期的日期
# 就業狀況：（待業，待業，退休，殘疾，病假）
# 性別：男女
# 收入：客戶的年收入
# 位置代碼：（農村，郊區，城市）
# 婚姻狀況：（單身，已婚，離婚）
# 車輛類別：車輛類型（四門，豪華，豪華SUV，跑車，SUV，兩門）
# 車輛尺寸：（大，中，小）

install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)

# Load data
df <- read.csv(
  file="WA_Fn-UseC_-Marketing-Customer-Value-Analysis.csv", 
  header=TRUE, 
  sep=","
)
# df <- WA_Fn-UseC_-Marketing-Customer-Value-Analysis.csv

### variable introduction -------------
#變數介紹

# customer -->顧客                              Customer.Lifetime.Value --> 顧客終生價值
# State -->國家                                 Coverage -->覆蓋範圍
# Response -->回覆                              Education --> 教育程度
# Gender --> 性別                               Effective.To.Date -->生效日期
# Income --> 收入                               Location.Code --> 位置代碼
# Policy --> 保險                               Marital.Status --> 婚姻狀況
# EmploymentStatus --> 就業狀況                 Months.Since.Last.Claim --> 自聲言以來月數
# Monthly.Premium.Auto --> 每月保費             Months.Since.Policy.Inception --> 自保險成立以來的月數
# Number.of.Open.Complaints --> 公開投訴數量    Number.of.Policies --> 保險數量
# Policy.Type --> 保險類型                      Sales.Channel --> 銷售渠道
# Total.Claim.Amount --> 索賠總額               Vehicle.Size --> 車輛尺寸
# Renew.Offer.Type --> 續訂優惠類型             Vehicle.Class --> 車輛類別

#### 1. Engagement Rate ####
#### 1. 參與率 ####      
names(df)
# [1] "Customer"                      "State"                         "Customer.Lifetime.Value"      
# [4] "Response"                      "Coverage"                      "Education"                    
# [7] "Effective.To.Date"             "EmploymentStatus"              "Gender"                       
# [10] "Income"                        "Location.Code"                 "Marital.Status"               
# [13] "Monthly.Premium.Auto"          "Months.Since.Last.Claim"       "Months.Since.Policy.Inception"
# [16] "Number.of.Open.Complaints"     "Number.of.Policies"            "Policy.Type"                  
# [19] "Policy"                        "Renew.Offer.Type"              "Sales.Channel"                
# [22] "Total.Claim.Amount"            "Vehicle.Class"                 "Vehicle.Size"  
dim(df)
# [1] 9134   24

# Encode Response as 0s and 1s
##將  Response No跟Yes轉換成0和1
df$Response
# [1] "No"  "No"  "No"  "No"  "No"  "Yes" "Yes" "No"  "Yes" "No"  "No"  "No"  "No"  "Yes" "No"  "No" 
# [17] "No"  "No"  "No"  "No"  "No"  "No"  "Yes" "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" 
# [33] "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "Yes" "Yes" "No"  "No"  "No"  "No"  "No" 

sum(df$Total.Claim.Amount)
# [1] 3964967
mean(df$Total.Claim.Amount)
# [1] 434.0888

sum(df$Response)
# Error in sum(df$Response) : 'type' (character) 的引數無效

df$Engaged <- ifelse(df$Response  == "No", 0, 1)

dim(df)
#[1] 9134   25
names(df)
# [22] "Total.Claim.Amount"            "Vehicle.Class"                 "Vehicle.Size" 
# [25] "Engaged" 
engagementCount <- df %>% 
  group_by(Engaged) %>% 
  summarise(Count=n())
engagementCount
#   Engaged Count
# *   <dbl> <int>
# 1       0  7826
# 2       1  1308
nrow(df)
# [1] 9134

engagementRate <- df %>% 
  group_by(Engaged) %>% 
  summarise(Count=n()) %>%   ##利用n函數算出總客戶量(Count)
  mutate(Percentage=Count/nrow(df)*100.0)  ##加入欄Percentage計算參與率

engagementRate
# Engaged Count Percentage
# *   <dbl> <int>      <dbl>
# 1       0  7826       85.7
# 2       1  1308       14.3   參與率

# Transpose
##用t函數來轉置資料框,也就是將欄與列作對調
transposed <- t(engagementRate)  
transposed
#                     1          2
# Engaged       0.00000    1.00000
# Count      7826.00000 1308.00000
# Percentage   85.67988   14.32012

colnames(transposed) <- engagementRate$Engaged
transposed
#                     0          1
# Engaged       0.00000    1.00000
# Count      7826.00000 1308.00000
# Percentage   85.67988   14.32012

transposed <- transposed[-1,]

transposed
#                     0          1
# Count      7826.00000 1308.00000
# Percentage   85.67988   14.32012

#### 2. Renewal Offer Type 續訂優惠類型 ####
#### 將Renew.Offer.Type名稱改為Type 再利用group以Engaged和Type做分類
# Renew.Offer.Type --> 續訂優惠類型
summary(df$Renew.Offer.Type)
# Length     Class      Mode 
#   9134 character character 
str(df$Renew.Offer.Type)
# chr [1:9134] "Offer1" "Offer3" "Offer1"

summary(factor(df$Renew.Offer.Type))
# Offer1 Offer2 Offer3 Offer4 
#   3752   2926   1432   1024 

renewalOfferType <- df %>% 
  group_by(Engaged,Type=Renew.Offer.Type) %>% 
  summarise(Count=n())

names(renewalOfferType)
# [1] "Engaged" "Type"    "Count"  

renewalOfferType
#   Engaged Type   Count
#     <dbl> <chr>  <int>
# 1       0 Offer1  3158
# 2       0 Offer2  2242
# 3       0 Offer3  1402
# 4       0 Offer4  1024
# 5       1 Offer1   594
# 6       1 Offer2   684
# 7       1 Offer3    30

# pie chart
# 圓餅圖
ggplot(renewalOfferType, aes(x="", y=Count, fill=Type)) + 
  geom_bar(width=1, stat = "identity", position=position_fill()) +
  geom_text(aes(x=1.25, label=Count), position=position_fill(vjust = 0.5)) +
  coord_polar("y") +
  facet_wrap(~Engaged) +
  ggtitle('Renwal Offer Type (0: Not Engaged, 1: Engaged)') +
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    plot.title=element_text(hjust=0.5),
    legend.position='bottom'
  )

#### 3. Sales Channel 銷售渠道 ####
# Sales.Channel --> 銷售渠道
salesChannel <- df %>% 
  group_by(Engaged, Channel=Sales.Channel) %>% 
  summarise(Count=n())

salesChannel
#   Engaged Channel     Count
#     <dbl> <chr>       <int>
# 1       0 Agent        2811
# 2       0 Branch       2273
# 3       0 Call Center  1573
# 4       0 Web          1169
# 5       1 Agent         666
# 6       1 Branch        294
# 7       1 Call Center   192
# 8       1 Web           156

#Agent --> 代理人
#Branch --> 分行/分支機構
#Call center -->客服
#web -->網頁

# pie chart
ggplot(salesChannel, aes(x="", y=Count, fill=Channel)) + 
  geom_bar(width=1, stat = "identity", position=position_fill()) +
  geom_text(aes(x=1.25, label=Count), position=position_fill(vjust = 0.5)) +
  coord_polar("y") +
  facet_wrap(~Engaged) +
  ggtitle('Sales Channel (0: Not Engaged, 1: Engaged)') +
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    plot.title=element_text(hjust=0.5),
    legend.position='bottom'
  )

#### 4. Total Claim Amount ####
# Total.Claim.Amount --> 索賠總額 
#### 4. 索賠總額 ####

#### box plot ####
#### 箱形圖 ####
## 最大值 最小值 平均值 介於上下四分位數 離群值
ggplot(df, aes(x="", y=Total.Claim.Amount)) + 
  geom_boxplot() +
  facet_wrap(~Engaged) +
  ylab("Total Claim Amount") +
  xlab("0: Not Engaged, 1: Engaged") +
  ggtitle("Engaed vs. Not Engaged: Total Claim Amount") +
  theme(plot.title=element_text(hjust=0.5))

# without outliers
# 去除超出上下四分位數"離群值"
ggplot(df, aes(x="", y=Total.Claim.Amount)) + 
  geom_boxplot(outlier.shape = NA) + ##去除離群值
  scale_y_continuous(limits = quantile(df$Total.Claim.Amount, c(0.1, 0.9))) + 
  facet_wrap(~Engaged) +
  ylab("Total Claim Amount") +
  xlab("0: Not Engaged, 1: Engaged") +
  ggtitle("Engaed vs. Not Engaged: Total Claim Amount") +
  theme(plot.title=element_text(hjust=0.5))

#### 5. Income ####
#### 5. 收入####

# boxplot
#箱形圖
ggplot(df, aes(x="", y=Income)) + 
  geom_boxplot() +
  facet_wrap(~Engaged) +
  ylab("Income") +
  xlab("0: Not Engaged, 1: Engaged") +
  ggtitle("Engaed vs. Not Engaged: Income") +
  theme(plot.title=element_text(hjust=0.5))

# summary statistics
# 統計概述(配合income box plot)
incomeDescription <- df %>% 
  group_by(Engaged) %>% 
  summarise(
    Min=min(Income), Q1=quantile(Income, 0.25),  #收入的最小值
    Median=median(Income), Q3=quantile(Income, 0.75),  #收入中位數
    Max=max(Income)  ##收入最大值
  )

incomeDescription
#   Engaged   Min    Q1 Median     Q3   Max
# *   <dbl> <int> <dbl>  <dbl>  <dbl> <int>
# 1       0     0     0  34091 62454. 99981
# 2       1     0 18495  32234 60880  99845

#### 6. Regression Analysis 回歸分析 ####
# summary statistics per column
summary(df)

str(df)
# 'data.frame':	9134 obs. of  25 variables:
#   $ Customer                     : chr  "BU79786" "QZ44356" "AI49188" "WW63253" ...
# $ State                        : chr  "Washington" "Arizona" "Nevada" "California" ...
# $ Customer.Lifetime.Value      : num  2764 6980 12887 7646 2814 ...
# $ Response                     : chr  "No" "No" "No" "No" ...
# $ Coverage                     : chr  "Basic" "Extended" "Premium" "Basic" ...
# $ Education                    : chr  "Bachelor" "Bachelor" "Bachelor" "Bachelor" ...
# $ Effective.To.Date            : chr  "2/24/11" "1/31/11" "2/19/11" "1/20/11" ...
# $ EmploymentStatus             : chr  "Employed" "Unemployed" "Employed" "Unemployed" ...
# $ Gender                       : chr  "F" "F" "F" "M" ...
# $ Income                       : int  56274 0 48767 0 43836 62902 55350 0 14072 28812 ...
# $ Location.Code                : chr  "Suburban" "Suburban" "Suburban" "Suburban" ...
# $ Marital.Status               : chr  "Married" "Single" "Married" "Married" ...
# $ Monthly.Premium.Auto         : int  69 94 108 106 73 69 67 101 71 93 ...
# $ Months.Since.Last.Claim      : int  32 13 18 18 12 14 0 0 13 17 ...
# $ Months.Since.Policy.Inception: int  5 42 38 65 44 94 13 68 3 7 ...
# $ Number.of.Open.Complaints    : int  0 0 0 0 0 0 0 0 0 0 ...
# $ Number.of.Policies           : int  1 8 2 7 1 2 9 4 2 8 ...
# $ Policy.Type                  : chr  "Corporate Auto" "Personal Auto" "Personal Auto"  ...
# $ Policy                       : chr  "Corporate L3" "Personal L3" "Personal L3" "Corporate L2" ...
# $ Renew.Offer.Type             : chr  "Offer1" "Offer3" "Offer1" "Offer1" ...
# $ Sales.Channel                : chr  "Agent" "Agent" "Agent" "Call Center" ...
# $ Total.Claim.Amount           : num  385 1131 566 530 138 ...
# $ Vehicle.Class                : chr  "Two-Door Car" "Four-Door Car" "Two-Door Car" "SUV" ...
# $ Vehicle.Size                 : chr  "Medsize" "Medsize" "Medsize" "Medsize" ...
# $ Engaged                      : num  0 0 0 0 0 1 1 0 1 0 ...
# get data types of each column

# 得知每個欄位的類型如"charactor"-->類別 、 "numeric"-->數字 、 "integer"-->整數
sapply(df, class)
# Customer                        State                Customer.Lifetime.Value 
# "character"                   "character"                           "numeric" 
# Response                      Coverage                              Education 
# "character"                   "character"                         "character" 
# Effective.To.Date              EmploymentStatus                        Gender 
# "character"                   "character"                         "character" 

## 6.1. Continuous Variables 連續變數 - Regression Analysis 回歸分析 ##
## 6.1. 連續變數 ##

# get numeric columns
# 得到資料型態是數值的欄位
select_if(df, is.numeric)
head(select_if(df, is.numeric))
#   Customer.Lifetime.Value Income Monthly.Premium.Auto Months.Since.Last.Claim
# 1                2763.519  56274                   69                      32
# 2                6979.536      0                   94                      13
# 3               12887.432  48767                  108                      18
# 4                7645.862      0                  106                      18
# 5                2813.693  43836                   73                      12
# 6                8256.298  62902                   69                      14
#   Months.Since.Policy.Inception Number.of.Open.Complaints Number.of.Policies Total.Claim.Amount Engaged
# 1                             5                         0                  1           384.8111       0
# 2                            42                         0                  8          1131.4649       0
# 3                            38                         0                  2           566.4722       0
# 4                            65                         0                  7           529.8813       0
# 5                            44                         0                  1           138.1309       0
# 6                            94                         0                  2           159.3830       1

continuousDF <- select_if(df, is.numeric)  ##select_if
colnames(continuousDF)
# [1] "Customer.Lifetime.Value"       "Income"                        "Monthly.Premium.Auto"         
# [4] "Months.Since.Last.Claim"       "Months.Since.Policy.Inception" "Number.of.Open.Complaints"    
# [7] "Number.of.Policies"            "Total.Claim.Amount"            "Engaged"  

# Fit regression model with continuous variables
# 以連續變數擬合邏輯回歸模型
###輸出變數為Engaged
#Estimate -->估計值(負值代表10的-n次方)
#Z value -->z值(代表距離平均值差了多少個標準差)
#Pr(>|z|)-->p值(特徵與變數的關聯性強弱，任何小於0.05的p值代表較強的關聯性)
#Signif. codes -->代表關聯性強弱

logit.fit01 <- glm(Engaged ~ ., data = continuousDF, family = binomial)
summary(logit.fit01)
# Call:
#   glm(formula = Engaged ~ ., family = binomial, data = continuousDF)

# Deviance Residuals: 
#     Min       1Q   Median       3Q      Max  
# -0.7629  -0.5704  -0.5477  -0.5216   2.1018  
# 
# Coefficients:
#                                 Estimate Std. Error z value Pr(>|z|)    
# (Intercept)                   -1.787e+00  1.234e-01 -14.476   <2e-16 ***
# Customer.Lifetime.Value       -6.327e-06  4.863e-06  -1.301   0.1933    
# Income                         2.042e-06  1.092e-06   1.869   0.0616 .  
# Monthly.Premium.Auto          -1.194e-04  1.226e-03  -0.097   0.9224    
# Months.Since.Last.Claim       -4.489e-03  2.987e-03  -1.503   0.1329    
# Months.Since.Policy.Inception  2.125e-04  1.073e-03   0.198   0.8429    
# Number.of.Open.Complaints     -3.257e-02  3.379e-02  -0.964   0.3351    
# Number.of.Policies            -2.443e-02  1.283e-02  -1.904   0.0569 .  
# Total.Claim.Amount             2.772e-04  1.463e-04   1.895   0.0581 .  
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 7503.3  on 9133  degrees of freedom
# Residual deviance: 7488.1  on 9125  degrees of freedom
# AIC: 7506.1
# 
# Number of Fisher Scoring iterations: 4


## 6.2. Categorical Variables 類別型變數 - Regression Analysis 回歸分析##

# a. Education
# Fit regression model with Education factor variables
# 以教育程度擬合邏輯回歸模型
#College-->大學
#Doctor-->博士
#High School or Below -->高中或更低的學歷
#Master-->碩士

logit.fit02 <- glm(Engaged ~ factor(Education), data = df, family = binomial)
summary(logit.fit02)
# Coefficients:
#                                       Estimate Std. Error z value Pr(>|z|)    
# (Intercept)                           -1.83575    0.05538 -33.146   <2e-16 ***
# factor(Education)College               0.11816    0.07719   1.531   0.1258    
# factor(Education)Doctor                0.28819    0.15258   1.889   0.0589 .  
# factor(Education)High School or Below -0.06137    0.08019  -0.765   0.4441    
# factor(Education)Master                0.19191    0.11407   1.682   0.0925 .  

# b. Education + Gender
# Fit regression model with Education & Gender variables
# 以教育程度和性別擬合邏輯回歸模型
logit.fit03 <- glm(Engaged ~ factor(Education) + factor(Gender), data = df, family = binomial)
summary(logit.fit03)
# Coefficients:
#                                       Estimate Std. Error z value Pr(>|z|)    
# (Intercept)                           -1.84803    0.06257 -29.537   <2e-16 ***
# factor(Education)College               0.11782    0.07720   1.526   0.1269    
# factor(Education)Doctor                0.28759    0.15259   1.885   0.0595 .  
# factor(Education)High School or Below -0.06173    0.08019  -0.770   0.4415    
# factor(Education)Master                0.19223    0.11407   1.685   0.0919 .  
# factor(Gender)M                        0.02534    0.05979   0.424   0.6717    

## 6.3. Continuous & Categorical Variables - Regression Analysis 回歸分析 ##
## 合併連續與類別變數 ##

continuousDF$Gender <- factor(df$Gender)   #144行
continuousDF$Education <- factor(df$Education)

names(continuousDF)
# [1] "Customer.Lifetime.Value"       "Income"                        "Monthly.Premium.Auto"         
# [4] "Months.Since.Last.Claim"       "Months.Since.Policy.Inception" "Number.of.Open.Complaints"    
# [7] "Number.of.Policies"            "Total.Claim.Amount"            "Engaged"                      
# [10] "Gender"                        "Education"  

# Fit regression model with Education & Gender variables
# 以教育程度和性別擬合邏輯回歸模型
# 和172行的差別為採用的資料集不同
logit.fit04 <- glm(Engaged ~ ., data = continuousDF, family = binomial)
summary(logit.fit04)
# Coefficients:
#                                 Estimate Std. Error z value Pr(>|z|)    
# (Intercept)                   -1.837e+00  1.342e-01 -13.693   <2e-16 ***
# Customer.Lifetime.Value       -6.065e-06  4.872e-06  -1.245   0.2132    
# Income                         2.044e-06  1.094e-06   1.867   0.0618 .  
# Monthly.Premium.Auto          -4.619e-04  1.237e-03  -0.374   0.7087    
# Months.Since.Last.Claim       -4.717e-03  2.993e-03  -1.576   0.1150    
# Months.Since.Policy.Inception  1.856e-04  1.074e-03   0.173   0.8627    
# Number.of.Open.Complaints     -3.448e-02  3.378e-02  -1.021   0.3075    
# Number.of.Policies            -2.392e-02  1.285e-02  -1.862   0.0626 .  
# Total.Claim.Amount             3.471e-04  1.487e-04   2.335   0.0196 *  
# GenderM                        1.537e-02  6.017e-02   0.255   0.7984    
# EducationCollege               1.216e-01  7.731e-02   1.573   0.1158    
# EducationDoctor                3.107e-01  1.532e-01   2.028   0.0425 *  
# EducationHigh School or Below -7.456e-02  8.056e-02  -0.925   0.3547    
# EducationMaster                2.065e-01  1.149e-01   1.798   0.0722 .  
# ---

### Homework 01: Reference 參考資料01 ------------
# MODELS TO IMPROVE AUTO INSURANCE CUSTOMER RETENTION
# https://www.kaggle.com/juancarlosventosa/models-to-improve-customer-retention

### Homework 02: Reference 參考資料02 ------------
# Predict Customer Life-time Value (CLV)
# https://www.kaggle.com/dktalaicha/predict-customer-life-time-value-clv
