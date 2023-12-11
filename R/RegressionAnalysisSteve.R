# Objective:
#   The IBM-Watson Marketing Customer Value data set contains the results of an auto insurance company's marketing campaign to retain customers by offering customers with expiring policies one of four different renewal proposals. Unfortunately the purchase response rates to the offers have been low with most renewals denied. If customers who denied their proposal received one of the other 3 proposals would their response been different?
# 
# The main objective of this analysis will try to answer that question by creating a predictive model that will attempt to pair the customer with the one of four renewal proposals that has the highest probability of being accepted. Along the way, this analysis will also explore the data for insights about the customers that could lead to better customer retention.
# �ت��G
# IBM-Watson��P�Ȥ���ȼƾڶ��]�t�T���O�I���q��P���ʪ����G�A����P���ʬO�q�L���Ȥᴣ�ѥ|�Ӥ��P��q���פ��@������O��ӫO�d�Ȥ�C �������O�A��������ʶR�T���v�ܧC�A�j�h����q���Q�ڵ��C �p�G�ڵ���Ъ��Ȥ᦬��F��L�T�ӧ�Ф��@�A�L�̪����_�|���Ҥ��P�ܡH
# 
# �Ӥ��R���D�n�ؼбN�q�L�Ыؤ@�ӹw���ҫ��ӹ��զ^���Ӱ��D�A�Ӽҫ��N���ձN�Ȥ�P�|�ӳQ�������i��ʳ̰�����q���פ��@�t��C �b���L�{���A�����R�ٱN�����ƾڡA�H��������Ȥ᪺���ѡA�q�ӥi�H��n�a�d���Ȥ�C

# Highlights:
#   Exploratory Data Analysis on Customer Lifetime Value, Renewal Offers and Customer Responses.
# Association Rules Mining (ARM) to discover customer qualities associated with accepting a renewal.
# Random Forest prediction model to pair customers with a renewal offer they are most likely to accept.
# K-Means Cluster Analysis for customer segmentation.
# Decision Tree Classification to identify potential Customer Lifetime Value.
# �j�աG
# ����Ȥ�ͩR�g�����ȡA��������M�Ȥ��T���������ʼƾڤ��R�C
# ���p�W�h�����]ARM�^�A�H�o�{�P������q�������Ȥ����C
# �H���˪L�w���ҫ��i�N�Ȥ�P�L�̳̦��i�౵������q�����t��C
# K-���ȻE�����R�Ω�Ȥ�Ӥ��C
# �M��������A�H�ѧO��b���Ȥ�ͩR�g�����ȡC

# About the Data
# The data has 9134 customer records with 24 variables (14 policy profile variables and 10 customer profile variables). All customers in the data have policies expiring between Jan 1 to Feb 28, 2011. Definitions for each variable are provided below.
# �ƾڨ㦳9134�ӫȤ�O���A�䤤�]�t24���ܶq�]14�ӵ����t�m����ܶq�M10�ӫȤ�t�m����ܶq�^�C �ƾڤ����Ҧ��Ȥ᪺�����b2011�~1��1���2��28�餧������C�U�����ѤF�C���ܶq���w�q�C
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
# �����t�m����ܶq
# 
# �Ȥ�G�Ȥ�s��
# �Ȥ�ͩR�g�����ȡG�Ȥ�b��ӥͩR�g������~�Ȫ��`����
# �^�`�G�O�Χ_�C
# �ӫO�d��G�O�������]�򥻡A�X�i�A���š^
# �C�밪�ŨT���O�I�G�Ȥ�C�몺�O�I�����B
# �ۤW�����ߥH�Ӫ���ơG�Ȥ�̪�@�����i�O�I���ߤ��������
# �۫O�榨�ߤ���_�G�Ȥ�}�l�ʶR�O��H�Ӫ����
# ���M��D�ƶq�G���ѨM���Ȥ��D�ƶq
# �O��ƶq�G�Ȥ���e�֦����O��ƶq
# ���������G�]���q�۰ʡA�ӤH�۰ʡA�S���۰ʡ^
# �����G�C�ӵ��������]���q�A�ӤH�A�S���^�T�ӯŧO�]L1�AL2�AL3�^
# ��q�n�������G4����q�n���]�n��1�A�n��2�A�n��3�A�n��4�^
# �P���D�G�ʶR�O�檺��D�]�N�z�ӡA������c�A�I�s���ߡA�����^
# �����`�B�G�۫O��ͮĥH�Ӫ��֭p�����B
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
# �Ȥ����ܶq
# 
# �{�G�~������~�{
# �Ш|�{�סG���Ш|�{�ס]�����ΥH�U�A�j�ǡA��Ǥh�A��Ǥh�A�դh�Ǧ�^
# �ͮĤ���G�O��L�������
# �N�~���p�G�]�ݷ~�A�ݷ~�A�h��A�ݯe�A�f���^
# �ʧO�G�k�k
# ���J�G�Ȥ᪺�~���J
# ��m�N�X�G�]�A���A���ϡA�����^
# �B�ê��p�G�]�樭�A�w�B�A���B�^
# �������O�G���������]�|���A���ءA����SUV�A�]���ASUV�A����^
# �����ؤo�G�]�j�A���A�p�^

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
#�ܼƤ���

# customer -->�U��                              Customer.Lifetime.Value --> �U�Ȳץͻ���
# State -->��a                                 Coverage -->�л\�d��
# Response -->�^��                              Education --> �Ш|�{��
# Gender --> �ʧO                               Effective.To.Date -->�ͮĤ��
# Income --> ���J                               Location.Code --> ��m�N�X
# Policy --> �O�I                               Marital.Status --> �B�ê��p
# EmploymentStatus --> �N�~���p                 Months.Since.Last.Claim --> ���n���H�Ӥ��
# Monthly.Premium.Auto --> �C��O�O             Months.Since.Policy.Inception --> �۫O�I���ߥH�Ӫ����
# Number.of.Open.Complaints --> ���}��D�ƶq    Number.of.Policies --> �O�I�ƶq
# Policy.Type --> �O�I����                      Sales.Channel --> �P���D
# Total.Claim.Amount --> �����`�B               Vehicle.Size --> �����ؤo
# Renew.Offer.Type --> ��q�u�f����             Vehicle.Class --> �������O

#### 1. Engagement Rate ####
#### 1. �ѻP�v ####      
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
##�N  Response No��Yes�ഫ��0�M1
df$Response
# [1] "No"  "No"  "No"  "No"  "No"  "Yes" "Yes" "No"  "Yes" "No"  "No"  "No"  "No"  "Yes" "No"  "No" 
# [17] "No"  "No"  "No"  "No"  "No"  "No"  "Yes" "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No" 
# [33] "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "No"  "Yes" "Yes" "No"  "No"  "No"  "No"  "No" 

sum(df$Total.Claim.Amount)
# [1] 3964967
mean(df$Total.Claim.Amount)
# [1] 434.0888

sum(df$Response)
# Error in sum(df$Response) : 'type' (character) ���޼ƵL��

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
  summarise(Count=n()) %>%   ##�Q��n��ƺ�X�`�Ȥ�q(Count)
  mutate(Percentage=Count/nrow(df)*100.0)  ##�[�J��Percentage�p��ѻP�v

engagementRate
# Engaged Count Percentage
# *   <dbl> <int>      <dbl>
# 1       0  7826       85.7
# 2       1  1308       14.3   �ѻP�v

# Transpose
##��t��ƨ���m��Ʈ�,�]�N�O�N��P�C�@���
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

#### 2. Renewal Offer Type ��q�u�f���� ####
#### �NRenew.Offer.Type�W�٧אּType �A�Q��group�HEngaged�MType������
# Renew.Offer.Type --> ��q�u�f����
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
# ����
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

#### 3. Sales Channel �P���D ####
# Sales.Channel --> �P���D
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

#Agent --> �N�z�H
#Branch --> ����/������c
#Call center -->�ȪA
#web -->����

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
# Total.Claim.Amount --> �����`�B 
#### 4. �����`�B ####

#### box plot ####
#### �c�ι� ####
## �̤j�� �̤p�� ������ ����W�U�|����� ���s��
ggplot(df, aes(x="", y=Total.Claim.Amount)) + 
  geom_boxplot() +
  facet_wrap(~Engaged) +
  ylab("Total Claim Amount") +
  xlab("0: Not Engaged, 1: Engaged") +
  ggtitle("Engaed vs. Not Engaged: Total Claim Amount") +
  theme(plot.title=element_text(hjust=0.5))

# without outliers
# �h���W�X�W�U�|�����"���s��"
ggplot(df, aes(x="", y=Total.Claim.Amount)) + 
  geom_boxplot(outlier.shape = NA) + ##�h�����s��
  scale_y_continuous(limits = quantile(df$Total.Claim.Amount, c(0.1, 0.9))) + 
  facet_wrap(~Engaged) +
  ylab("Total Claim Amount") +
  xlab("0: Not Engaged, 1: Engaged") +
  ggtitle("Engaed vs. Not Engaged: Total Claim Amount") +
  theme(plot.title=element_text(hjust=0.5))

#### 5. Income ####
#### 5. ���J####

# boxplot
#�c�ι�
ggplot(df, aes(x="", y=Income)) + 
  geom_boxplot() +
  facet_wrap(~Engaged) +
  ylab("Income") +
  xlab("0: Not Engaged, 1: Engaged") +
  ggtitle("Engaed vs. Not Engaged: Income") +
  theme(plot.title=element_text(hjust=0.5))

# summary statistics
# �έp���z(�t�Xincome box plot)
incomeDescription <- df %>% 
  group_by(Engaged) %>% 
  summarise(
    Min=min(Income), Q1=quantile(Income, 0.25),  #���J���̤p��
    Median=median(Income), Q3=quantile(Income, 0.75),  #���J�����
    Max=max(Income)  ##���J�̤j��
  )

incomeDescription
#   Engaged   Min    Q1 Median     Q3   Max
# *   <dbl> <int> <dbl>  <dbl>  <dbl> <int>
# 1       0     0     0  34091 62454. 99981
# 2       1     0 18495  32234 60880  99845

#### 6. Regression Analysis �^�k���R ####
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

# �o���C����쪺�����p"charactor"-->���O �B "numeric"-->�Ʀr �B "integer"-->���
sapply(df, class)
# Customer                        State                Customer.Lifetime.Value 
# "character"                   "character"                           "numeric" 
# Response                      Coverage                              Education 
# "character"                   "character"                         "character" 
# Effective.To.Date              EmploymentStatus                        Gender 
# "character"                   "character"                         "character" 

## 6.1. Continuous Variables �s���ܼ� - Regression Analysis �^�k���R ##
## 6.1. �s���ܼ� ##

# get numeric columns
# �o���ƫ��A�O�ƭȪ����
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
# �H�s���ܼ����X�޿�^�k�ҫ�
###��X�ܼƬ�Engaged
#Estimate -->���p��(�t�ȥN��10��-n����)
#Z value -->z��(�N���Z�������Ȯt�F�h�֭ӼзǮt)
#Pr(>|z|)-->p��(�S�x�P�ܼƪ����p�ʱj�z�A����p��0.05��p�ȥN�����j�����p��)
#Signif. codes -->�N�����p�ʱj�z

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
#   Signif. codes:  0 ��***�� 0.001 ��**�� 0.01 ��*�� 0.05 ��.�� 0.1 �� �� 1
# 
# (Dispersion parameter for binomial family taken to be 1)
# 
# Null deviance: 7503.3  on 9133  degrees of freedom
# Residual deviance: 7488.1  on 9125  degrees of freedom
# AIC: 7506.1
# 
# Number of Fisher Scoring iterations: 4


## 6.2. Categorical Variables ���O���ܼ� - Regression Analysis �^�k���R##

# a. Education
# Fit regression model with Education factor variables
# �H�Ш|�{�����X�޿�^�k�ҫ�
#College-->�j��
#Doctor-->�դh
#High School or Below -->�����Χ�C���Ǿ�
#Master-->�Ӥh

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
# �H�Ш|�{�שM�ʧO���X�޿�^�k�ҫ�
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

## 6.3. Continuous & Categorical Variables - Regression Analysis �^�k���R ##
## �X�ֳs��P���O�ܼ� ##

continuousDF$Gender <- factor(df$Gender)   #144��
continuousDF$Education <- factor(df$Education)

names(continuousDF)
# [1] "Customer.Lifetime.Value"       "Income"                        "Monthly.Premium.Auto"         
# [4] "Months.Since.Last.Claim"       "Months.Since.Policy.Inception" "Number.of.Open.Complaints"    
# [7] "Number.of.Policies"            "Total.Claim.Amount"            "Engaged"                      
# [10] "Gender"                        "Education"  

# Fit regression model with Education & Gender variables
# �H�Ш|�{�שM�ʧO���X�޿�^�k�ҫ�
# �M172�檺�t�O���ĥΪ���ƶ����P
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

### Homework 01: Reference �ѦҸ��01 ------------
# MODELS TO IMPROVE AUTO INSURANCE CUSTOMER RETENTION
# https://www.kaggle.com/juancarlosventosa/models-to-improve-customer-retention

### Homework 02: Reference �ѦҸ��02 ------------
# Predict Customer Life-time Value (CLV)
# https://www.kaggle.com/dktalaicha/predict-customer-life-time-value-clv