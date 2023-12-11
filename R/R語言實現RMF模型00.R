#R語言實現RMF模型
#R Language to implement the RMF model

# RMF模型說明
# RMF model description

# RMF模型是客戶管理中，常被用來衡量客戶價值和客戶創利能力的重要方法。
# 它主要考量三個指標：
# # RMF model is an important method in customer management that is often used to measure customer value and customer profitability.
# It mainly considers three indicators:

# 1. R 最近一次消費-Recency：近期購買的客戶傾向於再度購買。
#    R Last consumption-Recency: Customers who bought recently tend to buy again.

# 2. R 消費頻率-Frequency：經常購買的客戶再次購買概率高。
#    R Frequency of consumption-Frequency: Customers who buy frequently have a high probability of repurchasing.

# 3. M 消費金額-Monetary：消費金額較多的客戶再次消費可能性更大。
#    M Consumption amount-Monetary: Customers who spend more money are more likely to spend again.

# 根據上述三個維度，對客戶做細分，假定每個維度劃分成五個等級，
# 得到客戶的R值（1-5），F值（1-5），M值（1-5）。
# 那麼客戶就被分作5*5*5 <- 125個細分群，
# 我們可以根據客戶交易行為的差異針對不同群體做不同的推薦。
# According to the above three dimensions, customer segmentation, assuming that each dimension is divided into five levels,
# Get the customer's R value (1-5), F value (1-5), M value (1-5).
# Then the customers are divided into 5*5*5 <- 125 sub-groups,
# We can make different recommendations for different groups according to the differences in customer transaction behavior.

# 或者進一步針對不同的業務場景，對R、F、M賦予不同權重Wr、Wf、Wm，
# 得到每個使用者的得分：W = Wr * R + Wf * F + Wm * M。
# 根據最終得分W排序，再劃分等級，採用的營銷策略。
# For different business scenarios, assign different weights Wr, Wf, Wm to R, F, and M,
# Get the score of each user: W = Wr * R + Wf * F + Wm * M.
# according to the final score W, and then classify the marketing strategy adopted. 

# RFM模型其實很簡單，其重點應該是在：
# 1. 如何做劃分，不管是針對三個維度的劃分還是三個維度取不同權重的和W的劃分，都要依據實際業務場景情況確定。
# 2. 針對不同的客戶群如何選定合適的營銷手段，這個則需要對每個客戶群體有正確的解讀，並且對實際業務場景理解比較深入。
# RFM model is actually very simple, its focus should be on:
# 1. How to do the division, whether it is for the three-dimensional division or the three-dimensional division with different weights and W, must be determined according to the actual business scenario.
# 2. How to choose suitable marketing methods for different customer groups, this requires a correct interpretation of each customer group, and a deeper understanding of actual business scenarios.

# R語言實現RMF
# R language implements RMF

# 用來做分析的資料應該是一段時間裡累計的客戶的消費記錄，
# 每筆記錄至少需要客戶名稱、消費時間、消費金額三個要素。
# The data used for analysis should be customer consumption records accumulated over a period of time.
# Each record requires at least three elements: customer name, consumption time, and consumption amount.

# 用R生成模擬隨機消費記錄資料。
# 客戶編號為1000-1999共1000人，消費記錄10000條，
# 消費記錄產生時間在2019-01-01到2020-12-29之間。
# Use R to generate simulated random consumption records.
# The customer number is 1000-1999, a total of 1,000 people, 10,000 consumption records,
# The consumption record is generated between 2019-01-01 and 2020-12-29.

sales <- data.frame(sample(1000:1999, replace=T, size =10000),
                    abs(round(rnorm(10000,178,55))) + 1)
#隨機第一列產生使用者ID，第二列產生使用者消費資料
#Randomly the first row generates user ID, the second row generates user consumption data
sales.dates<- as.Date("2019/1/1") + 729*sort(stats::runif(10000)) 
# runif(n,min = 0, max = 1)產生隨機數
# 產生隨機數 = Generate random numbers
sales<- cbind(sales,sales.dates)

names(sales)<- c("使用者ID","消費金額","消費時間")
# 使用者ID = User ID,消費金額 = Consumption amount,消費時間 = Consumption time
str(sales)
#檢視data.frame的格式
#View the format of "data.frame"

#'data.frame':	10000 obs. of  3 variables:
# $ 使用者ID    : int  1220 1719 1323 1462 1699 1512 1668 1565 1297 ...
# $ 消費金額: num  189 201 160 103 251 243 48 253 196 236 ...
# $ 消費時間: Date, format: "2019-01-01" "2019-01-01" ....

### 根據上述消費記錄，得到Recency、Frequency、Monetary的值。 -----
### According to Consumption Records, We can get the values of Recency,Frequency,Monetary. ----- 
sales$距離時間 <- round(as.numeric(difftime(Sys.Date(),
                                        sales[,3],units="days")))

salesM<- aggregate(sales[,2],list(sales$使用者ID),sum) #總消費金額(Total Consumption Amount)

names(salesM)<- c("使用者ID","Monetization")

salesF<- aggregate(sales[,2],list(sales$使用者ID),length) #消費次數(Consumption Frequency)

names(salesF)<- c("使用者ID","Frequency")

salesR<- aggregate(sales[,4],list(sales$使用者ID),min) #最近一次消費時間(Last Consumption Time)

names(salesR)<- c("使用者ID","Recency")

test1<- merge(salesF,salesR,"使用者ID")

salesRFM<- merge(salesM,test1,"使用者ID")

### 根據上述說明，對三個維度每個維度劃分為5個層次，做均值劃分。------
# 並給R、F、M分別賦權重0.5,0.3,0.2來求客戶最終得分，
# 客戶最終得分在1-5之間。
### According to the description, each of the three dimensions is divided into 5 levels, and the average is divided. ------
# And assign weights 0.5, 0.3, 0.2 to R, F, and M to obtain the final score of the customer.
# The customer's final score is between 1-5.

#均值劃分
#Average division
salesRFM0 <- salesRFM
salesRFM0$rankR <- cut(salesRFM0$Recency, 5,labels=F)
salesRFM0$rankR <- 6 - salesRFM0$rankR 
#rankR，5是最近，1是最遠
#rankR, 5 is the nearest, 1 is the farthest

salesRFM0$rankF <- cut(salesRFM0$Frequency, 5,labels=F) 
#rankF，1是最少，5是最頻繁
#rankF, 1 is the least, 5 is the most frequent

salesRFM0$rankM<- cut(salesRFM0$Monetization, 5,labels=F) 
#rankM，1是最少，5是最多
#rankM, 1 is the least, 5 is the most

salesRFM0$rankRMF<- 0.5*salesRFM0$rankR + 0.3*salesRFM0$rankF + 
  0.2*salesRFM0$rankM

summary(salesRFM0)

### 對Receny、Frequency、Monetary標準化後，-----
# 以權重權重0.5,0.3,0.2來求客戶最終得分，客戶最終得分在0-1之間。
### After standardizing Receny, Frequency and Monetary, -----
# Use weights of 0.5, 0.3, 0.2 to find the final score of the customer. The final score of the customer is between 0-1.

#標準化後劃分
#Division after Standardization
salesRFM1<- salesRFM
salesRFM1$rankR<-(salesRFM1$Recency-min(salesRFM1$Recency))/(max(salesRFM1$Recency)-min(salesRFM1$Recency))
salesRFM1$rankR<- 1-salesRFM1$rankR #rankR，1是最近，0是最遠; rankR, 1 is the nearest, 0 is the farthest

salesRFM1$rankF<-(salesRFM1$Frequency-min(salesRFM1$Frequency))/(max(salesRFM1$Frequency)-min(salesRFM1$Frequency))#rankF，0是最少，1是最頻繁

salesRFM1$rankM<- (salesRFM1$Monetization-min(salesRFM1$Monetization))/(max(salesRFM1$Monetization)-min(salesRFM1$Monetization))#rankM，0是最少，1是最多

salesRFM1$rankRMF<- 0.5*salesRFM1$rankR + 0.3*salesRFM1$rankF + 
  0.2*salesRFM1$rankM

summary(salesRFM1)

# 以上用到的權重需要根據實際情況考量選定。
# 得到的客戶評分rankRMF，是客戶細分的一個參考依據，實際場景中，我們可能還有客戶的其他資料，可以綜合來看。
#資料來源: https://www.itread01.com/content/1546946462.html
# The weights used above need to be selected based on actual conditions.
# The obtained customer rating rankRMF is a reference basis for customer segmentation. In actual scenarios, we may have other customer information, which can be comprehensively viewed.
#Source: https://www.itread01.com/content/1546946462.html
