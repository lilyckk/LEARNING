### 常貴客？新客？ 讓RFM模型簡簡單單解釋一切！(資料來源)-----

# Regular guest? New guest? Let the RFM model explain everything simply! (source)-----

# 在行銷資料科學裡，有項工具可協助公司找出 
# R「新客」（近期有消費的人）、 
# F「常客」（常常來消費的人）、
# M「貴客」（消費金額大的人），這項工具稱為「RFM模型」。
# In marketing data science, there is a tool to help companies find
# R "new customers" (people who have recently spent money)
# F "frequent customers" (people who often come to consume)
# M "VIP" (people who spend a lot of money), this tool is called "RFM model".

# RFM模型是由喬治·卡利南（George Cullinan）於1961年所提出，他發現資料庫分析中，
# 有三項重要的指標：
# 最近一次消費（Recency）、
# 消費頻率（Frequency）、與
# 消費金額（Monetary），
# 這三項指標的英文字母的分別為R、F、M，所以就稱為「RFM模型」。
# The RFM model was proposed by George Cullinan in 1961. He found that in the database analysis,
# There are three important indicators:
# The most recent consumption (Recency),
# Frequency of consumption (Frequency), and
# Consumption amount (Monetary),
# The English letters of these three indicators are R, F, and M, so they are called "RFM model".

# 接下來，我們將介紹RFM模型的簡單概念:
# 最近一次消費（Recency）：
# 指消費者至今再次購買與上次購買產品的時間差，
# 舉例來說，將「購買日期分為五等分」，每一等分為資料庫的20%：
# 最近消費的前20%，編碼為5
# 20%~40%編碼為4，以此類推
# 到80%~100%編碼為1。
# 也就是編碼等級越高的消費者，重複購買比率較高。
# Next, we will introduce the simple concept of the RFM model:
# Last consumption (Recency):
# Refers to the time difference between the consumer's purchase and 
# the last purchase of the product so far,
# For example, divide the "purchase date into five equal parts", 
# each divided into 20% of the database:
# The top 20% of recent consumption, coded as 5
# 20%~40% is coded as 4, and so on
# To 80%~100% is coded as 1.
# That is consumers with higher coding levels have a higher repeat purchase rate.

# 2. 消費頻率（Frequency）：
# 指消費者在一定期間內購買該產品的次數。舉例來說：
# 次數最多的前20%，編碼為5
# 20%~40%編碼為4，以此類推
# 80%~100%編碼為1。
# 編碼等級越高的消費者，其消費頻率越高，忠誠度與顧客價值也越高。
# 2. Frequency of consumption (Frequency):
# Refers to the number of times consumers have purchased the product in a certain period. 
# for example:
# The top 20% of the most frequent, coded as 5
# 20%~40% is coded as 4, and so on
# 80%~100% is coded as 1.
# Consumers with higher coding levels have higher consumption frequency and 
# higher loyalty and customer value.

# 3. 消費金額（Monetary）：
# 指消費者在一定期間內購買該產品的總金額。
# 金額最大的前20%，編碼為5
# 20%~40%編碼為4，以此類推
# 80%~100%編碼為1。
# 編碼等級越高的消費者，其消費金額越高，顧客價值也越高。
# 3. Consumption amount (Monetary):
# Refers to the total amount of the product purchased by consumers in a certain period.
# The top 20% of the largest amount, coded as 5
# 20%~40% is coded as 4, and so on
# 80%~100% is coded as 1.
# Consumers with higher coding levels have higher consumption and higher customer value

# 利用以上的編碼方式，我們可以將顧客，依（R,F,M）的分數，共分成125群，
# 亦即從最低的（1,1,1）（3分）到最高的（5,5,5）（15分）。
# Using the above coding method, we can divide customers into 125 groups according to 
# the scores of (R, F, M),
# That is, from the lowest (1,1,1) (3 points) to the highest (5,5,5) (15 points).

# RFM模型能協助企業區分顧客，並預測每種顧客類型的消費者行為。
# 當企業對顧客進行分群後，再進一步從公司的顧客資料庫中，分析各群顧客背後的消費者行為，
# 進而發展預測模式。
# 讓公司的顧客關係管理（CRM）系統在應用上，能夠提升到策略性的層級。
# RFM模型實戰去！
# RFM model can help companies distinguish customers and 
# predict consumer behavior for each customer type.
# After the company divides its customers into groups, 
# it further analyzes the consumer behavior behind each group of customers from 
# the company’s customer database.
# Further develop the forecasting model.
# Let the company's customer relationship management (CRM) system be applied to a strategic level.
# RFM model to go to actual combat!

# 接下來的範例，我們將會使用R語言展示
# 如何使用RFM模型在「最近一次消費（Recency）」及「消費頻率（Frequency）」的分析應用，
# 會使用R與F的主要原因，是因為「最近一次消費（R）」的期間，關乎消費者的存留狀況，
# 以及「消費頻率（F）」影響顧客的顧客生命週期。
# 所以我們會依照 R 與 F 將顧客分類成不同客群，並觀察其與產品、銷售之間的關係，以達到下列目的：
# The next example, we will use R language to show
# How to use the RFM model in the analysis and application of "Recency" and "Frequency",
# The main reason for using R and F is because the period of "Last Consumption (R)" 
# is related to the retention status of consumers.
# And "Consumption Frequency (F)" affect the customer's customer life cycle.
# So we will classify customers into different customer groups according to R and F and 
# observe the relationship between them and products and sales to achieve the following goals:

# 1.了解目前銷售狀況。
# 2.有效的運用行銷預算，在對的產品上花對的錢。
# 3.對不同的客群給予不同的優惠。
# 4.增加顧客生命週期，培養每一位顧客成為忠實/常貴客 。
# 1. Understand the current sales status.
# 2. Use the marketing budget effectively and spend the right money on the right products.
# 3. Give different discounts to different customer groups.
# 4. Increase the customer life cycle and train every customer to become a loyal/regular customer.

# 我們即將使用某一匿名賣場的資料，並挑選出其中三件商品，切入R及F的模型分析。
# 可以想一下，當我們賣場內部資料有：
# 交易代號（orderId）
# 顧客編號（clientId）
# 產品（product）
# 性別（gender）
# 最後交易日期（orderdate）
# We are about to use the information of an anonymous store, and select three of them, 
# cut into the R and F model analysis.
# Think about it, when the internal information of our store has:
# Transaction code (orderId)
# Customer ID (clientId)
# Product (product)
# Gender (gender)
# Last transaction date (orderdate)

# 那我們就要開始問自己幾個問題：
# 應該從資料中擷取何種價值? 
# 到底應該如何透過這些資料，讓手上的資源分配更有利? 
# 我的顧客針對不同產品有偏好? 不同的顧客到底應該多銷售哪種產品?
# Then we will start to ask ourselves some questions:
# What value should be extracted from the data?
# How to use these information to make the allocation of resources more beneficial?
# My customers have preferences for different products? 
# Which products should different customers sell more?

# 那...既然這些問題都可以透過R及F的模式來做簡單的分析，到底R及F本身的性質是什麼?
# 其實就是我們在基礎敘述性統計中時常看到的「交叉分析」
# 交叉分析就可以解決並增加營收!
# These problems can be simply analyzed through the R and F model, 
# what is the nature of R and F itself?
# In fact, it is the "cross analysis" we often see in basic narrative statistics
# Cross-analysis can solve and increase revenue!

# 資料：
# 首先讓我們來看看本次賣場的資料型態。本次資料共4402筆資料，可在我們提供的檔案連結下載數據。
# https://drive.google.com/open?id=1JGkDV3X7CRLHM4H2Zd7UBpDNy3UIToKZ
# 部份原始資料的具體模樣:
# Data:
# First, let's take a look at the data type of this store. 
# This time there are 4402 records in total, which can be downloaded from the file link provided by us.
# https://drive.google.com/open?id=1JGkDV3X7CRLHM4H2Zd7UBpDNy3UIToKZ
# The specific appearance of some original data:

# 載入library
# Loading library

library(dplyr)
library(reshape2)
library(ggplot2)
library(stringr)
# start from here

library(readr)
orders <- read_csv("orders.csv", col_types = cols(orderdate = col_date(format = "%Y-%m-%d")))
View(orders)

str(orders)
# tibble [4,384 x 7] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
# $ X1       : num [1:4384] 1 2 3 4 5 6 7 8 9 10 ...
# $ product  : chr [1:4384] "高麗菜" "高麗菜" "高麗菜" "高麗菜" ...
# $ orderId  : num [1:4384] 582 2 725 597 761 95 426 321 239 822 ...
# $ clientId : num [1:4384] 230 276 277 279 92 190 241 115 15 164 ...
# $ gender   : chr [1:4384] "女性" "男性" "女性" "男性" ...
# $ orderdate: Date[1:4384], format: "2017-01-08" "2017-02-18" "2017-02-03" ...
# $ grossmarg: num [1:4384] 10 10 10 10 10 10 10 10 10 10 ...

# orders$orderdate = as.Date(orders$orderdate, origin="2017-01-01")

# 高麗菜 = Cabbage, 女性 = Female, 男性 = Male

summary(orders)
# 報告日期
# Report date
today <- as.Date('2017-04-11', format='%Y-%m-%d')

names(orders)
# [1] "X1"   "product"   "orderId"   "clientId"  "gender"    "orderdate" "grossmarg"

head(orders)
# A tibble: 6 x 7
#      X1 product orderId clientId gender orderdate  grossmarg
#   <dbl> <chr>     <dbl>    <dbl> <chr>  <date>         <dbl>
# 1     1 高麗菜      582      230 女性   2017-01-08        10
# 2     2 高麗菜        2      276 男性   2017-02-18        10
# 3     3 高麗菜      725      277 女性   2017-02-03        10
# 4     4 高麗菜      597      279 男性   2017-03-05        10
# 5     5 高麗菜      761       92 女性   2017-02-08        10
# 6     6 高麗菜       95      190 男性   2017-04-05        10

# 高麗菜 = Cabbage
# 女性 = Female, 男性 = Male

# 資料處理
# Data processing

?dcast
# cast {reshape2}	R Documentation
# Cast functions Cast a molten data frame into an array or data frame.

orders01 <- dcast(orders, orderId + clientId + gender + orderdate ~ product, value.var='product', fun.aggregate=length)

head(orders01)
#   orderId clientId gender  orderdate 牛奶麵包 高麗菜 瓶裝水
# 1       1      166   男性 2017-04-07        1      2      3
# 2       2      276   男性 2017-02-18        2      1      7
# 3       4       95   女性 2017-03-28        2      0      4
# 4       5      253   女性 2017-01-27        2      0      5
# 5       6       34   男性 2017-03-16        1      1      4
# 6       7      215   男性 2017-04-08        1      0      1

# 計算 frequency recency 频率   新近度
# Calculate frequency recency
orders02 <- orders01 %>%
  group_by(clientId) %>%
  mutate(frequency=n(),
         recency=as.numeric(today-orderdate)) %>%
  filter(orderdate==max(orderdate)) %>%
  filter(orderId==max(orderId)) %>%
  ungroup()

### 看看filter做甚麼動作?
### See what the filter does?
orders022 <- orders01 %>%
  group_by(clientId) %>%
  mutate(frequency=n(),
         recency=as.numeric(today-orderdate))

orders022Order <- orders01 %>%
  group_by(clientId) %>%
  mutate(frequency=n(),
         recency=as.numeric(today-orderdate)) %>%
  arrange(clientId)

head(orders02)
# A tibble: 6 x 9
#   orderId clientId gender   orderdate  牛奶麵包 高麗菜 瓶裝水 frequency recency
#     <dbl>    <dbl> <chr>  <date>        <int>  <int>  <int>     <int>   <dbl>
# 1       1      166 男性   2017-04-07        1      2      3         2       4
# 2       4       95 女性   2017-03-28        2      0      4         4      14
# 3       6       34 男性   2017-03-16        1      1      4         3      26
# 4       8      230 女性   2017-04-01        1      0      2         7      10
# 5      10       59 女性   2017-04-03        4      1      2         3       8
# 6      23      233 男性   2017-03-18        0      1      2         2      24

orders022 %>% filter(clientId == 166)
#   orderId clientId gender orderdate  牛奶麵包 高麗菜 瓶裝水 frequency recency
#     <dbl>    <dbl> <chr>  <date>        <int>  <int>  <int>     <int>   <dbl>
# 1       1      166 男性   2017-04-07        1      2      3         2       4
# 2     795      166 男性   2017-03-08        2      0      1         2      34

orders022 %>% filter(clientId == 95)
#   orderId clientId gender orderdate  牛奶麵包 高麗菜 瓶裝水 frequency recency
#     <dbl>    <dbl> <chr>  <date>        <int>  <int>  <int>     <int>   <dbl>
# 1       4       95 女性   2017-03-28        2      0      4         4      14
# 2     186       95 女性   2017-02-23        2      0      3         4      47
# 3     789       95 女性   2017-01-17        1      1      5         4      84
# 4     959       95 女性   2017-01-30        1      0      2         4      71

# 牛奶麵包= Milk Bread, 高麗菜= Cabbage, 瓶裝水 = Bottled Water,女性 = Female, 男性 = Male

### R與F 频率/新近度 模型分析： ------
### R and F Frequency/Recency Model Analysis: ------

#繪製出RF分佈圖
#Draw out the RF distribution map

# 圖形主题
# Graphic theme
howard_theme <- function(base_size = 12, base_family = "sans"){
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      axis.text.x = element_text(size=20, angle = 65, vjust = 1, hjust=1),
      axis.text.y = element_text(size=20),
      axis.title = element_text(size = 20),
      panel.grid.major = element_line(color = "grey"),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "aliceblue"),
      strip.background = element_rect(fill = "navy", color = "navy", size = 1),
      strip.text = element_text(face = "bold", size = 10, color = "white"),
      legend.position = "right",
      legend.justification = "bottom",
      legend.background = element_blank(),
      legend.text=element_text(size=15),
      panel.border = element_rect(color = "grey", fill = NA, size = 0.05),
      title = element_text(size = 15),
      plot.caption=element_text(size = 10)
    )
}

#消費頻率與訂單數量分佈圖
#Consumption frequency and order quantity distribution chart
ggplot(orders02, aes(x=frequency)) +
  theme_bw() +
  scale_x_continuous(breaks=c(1:10)) +
  geom_histogram(alpha=0.6, binwidth=1, fill = "blue") +
  ggtitle("消費頻率與訂單數量分佈圖")+
  xlab("消費頻率") + 
  ylab("訂單數量") +howard_theme()+
  theme(plot.title = element_text(color="red", size=30),
        axis.title.x = element_text(color="blue", size=20),
        axis.title.y = element_text(color="#993333", size=20))

#R 最近一次（天）的消費 頻率分佈圖
#R The most recent (day) consumption frequency distribution chart
ggplot(orders02, aes(x=recency)) +
  theme_bw() +
  geom_histogram(alpha=0.6, binwidth=1, fill = "blue") +
  scale_x_continuous(breaks=c(0:91))+
  ggtitle("最近一次（天）的消費與購買量分佈圖")+
  xlab("距離上次購買的天數") + 
  ylab("訂單數量") + howard_theme()+
  theme(plot.title = element_text(color="red", size=30),
        axis.title.x = element_text(color="blue", size=20),
        axis.title.y = element_text(color="#993333", size=20),
        panel.background = element_rect(fill = "aliceblue"),
        strip.background = element_rect(fill = "navy", color = "navy", size = 1),
        strip.text = element_text(face = "bold", size = 10, color = "white"))
# 距離上次購買的天數 = Days since last , 訂單數量 = quantity of order

# 從F與R圖上，很明顯可以發現，最近1天內消費與最近3天內消費的消費者，在購買量上，擁有極大的差距，但是最近76天內消費跟88天內消費的消費者在購買量上，並沒有差距。這就是為何我們要畫出這兩張長條圖來決定交叉分析時「不同邊界」的原因。
# 所以我們就可以開始定義每個群體的邊界，而尋找邊界的方式可以利用上述F與R的分佈圖或結合業務方面的知識分析來定義不同的級距。
# 本次我們的邊界根據r與f的圖來判斷每一間隔的級距定義之：
# 頻率分布邊界：1, 2, 3, 4, 5, >5
# 近因分布邊界：0–7, 8–15, 16–22, 23–30, 31–55, >55
# 於是我們就可以立即製作出R與F的「交叉分析」：
# From the graphs of F and R, it is obvious that consumers who consume in the last 1 day and those who consume in the last 3 days have a huge difference in purchase volume, but those who consume in the last 76 days and consume in 88 days There is no gap in consumer purchases. This is why we have to draw these two bar graphs to determine the "different boundaries" for cross-analysis.
# So we can start to define the boundaries of each group, and the way to find the boundaries can use the above distribution map of F and R or combine business knowledge analysis to define different levels.
# This time our boundary is defined according to the graph of r and f to determine the level of each interval:
# Frequency distribution boundary: 1, 2, 3, 4, 5, >5
# Proximate distribution boundary: 0–7, 8–15, 16–22, 23–30, 31–55, >55
# So we can immediately make a "cross analysis" of R and F:

# 切割頻率
# Cutting frequency
orders02.segm <- orders02 %>%
  mutate(buy_freq=ifelse(between(frequency, 1, 1), '1',
                         ifelse(between(frequency, 2, 2), '2',
                                ifelse(between(frequency, 3, 3), '3',
                                       ifelse(between(frequency, 4, 4), '4',
                                              ifelse(between(frequency, 5, 5), '5', '>5')))))) %>%
  mutate(segm.rec=ifelse(between(recency, 0, 7), '0-7 天',
                         ifelse(between(recency, 8, 15), '8-15 天',
                                ifelse(between(recency, 16, 22), '16-22 天',
                                       ifelse(between(recency, 23, 30), '23-30 天',
                                              ifelse(between(recency, 31, 55), '31-55 天', '>55 天')))))) %>%
  mutate(cart=paste(ifelse(瓶裝水!=0, '、瓶裝水', ''),
                    ifelse(牛奶麵包!=0, '、牛奶麵包', ''),
                    ifelse(高麗菜!=0, '、高麗菜', ''), sep='')) %>%
  arrange(clientId)

# '瓶裝水(Bottled Water)','牛奶麵包(Milk Bread)','高麗菜(Cabbage)'

# 定義邊界的順序
# Define the order of boundaries
orders02.segm$buy_freq <- factor(orders02.segm$buy_freq, levels=c('>5', '5', '4', '3', '2', '1'))
orders02.segm$segm.rec <- factor(orders02.segm$segm.rec, levels=c('>55 天', '31-55 天', '23-30 天', '16-22 天', '8-15 天', '0-7 天'))
orders02.segm$cart = str_split_fixed(orders02.segm$cart, '、', 2)[,2]

str(orders02.segm)
# $ buy_freq : Factor w/ 6 levels ">5","5","4","3",..: 2 6 1 6 3 3 2 4 6 4 ...
# $ segm.rec : Factor w/ 6 levels ">55 天","31-55 天",..: 5 5 6 1 4 3 2 6 2 6 ...
# $ cart     : chr [1:289] "瓶裝水、牛奶麵包" "瓶裝水、牛奶麵包" 

lcg <- orders02.segm %>%
  group_by(segm.rec, buy_freq) %>%
  summarise(quantity=n()) %>%
  mutate(client='顧客人數') %>%
  ungroup()
head(lcg)
# A tibble: 6 x 4
#   segm.rec buy_freq quantity client  
#   <fct>    <fct>       <int> <chr>   
# 1 >55 天   4               2 顧客人數
# 2 >55 天   3               4 顧客人數
# 3 >55 天   2               7 顧客人數
# 4 >55 天   1              21 顧客人數
# 5 31-55 天 >5              5 顧客人數
# 6 31-55 天 5               9 顧客人數

# 顧客人數 = Number of customers

lcg.matrix= as.data.frame.matrix(table(orders02.segm$buy_freq, orders02.segm$segm.rec))
lcg.matrix$buy_freq = row.names(lcg.matrix) 
lcg.matrix
#    >55 天 31-55 天 23-30 天 16-22 天 8-15 天 0-7 天 buy_freq
# >5      0        5        1        5       9     14       >5
# 5       0        9        2        5       5     17        5
# 4       2        6        9       13      12     15        4
# 3       4       17        6        9      10     15        3
# 2       7       13       11        7       6     11        2
# 1      21        9        3        3       4      4        1

# 上述釋例如果能利用圖形化的方式呈現，可更有效提升判斷力：
# If the above example can be presented graphically, it can improve judgment more effectively:


### 繪製RFM分析圖 ------------
### Draw RFM analysis diagram ------------
lcg.adv <- lcg %>%
  mutate(rec.type = ifelse(segm.rec %in% c(">55 天", "31-55 天", "23-30 天"), "not recent", "recent"),
         freq.type = ifelse(buy_freq %in% c(">5", "5", "4"), "frequent", "infrequent"),
         customer.type = interaction(rec.type, freq.type))
head(lcg.adv)
#   segm.rec buy_freq quantity client   rec.type   freq.type  customer.type        
#   <fct>    <fct>       <int> <chr>    <chr>      <chr>      <fct>                
# 1 >55 天   4               2 顧客人數 not recent frequent   not recent.frequent  
# 2 >55 天   3               4 顧客人數 not recent infrequent not recent.infrequent
# 3 >55 天   2               7 顧客人數 not recent infrequent not recent.infrequent
# 4 >55 天   1              21 顧客人數 not recent infrequent not recent.infrequent
# 5 31-55 天 >5              5 顧客人數 not recent frequent   not recent.frequent  
# 6 31-55 天 5               9 顧客人數 not recent frequent   not recent.frequent

ggplot(lcg.adv, aes(x=client, y=quantity, fill=customer.type)) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  geom_rect(aes(fill = customer.type), xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf, alpha = 0.1) +
  facet_grid(buy_freq ~ segm.rec) +
  geom_bar(stat='identity', alpha=0.7) +
  geom_text(aes(y=max(quantity)/2, label=quantity), size=4) +
  ggtitle("R與F分析圖") +
  xlab("最近一次消費天數") + ylab("購買頻率")+ 
  theme(plot.title = element_text(color="red", size=30 ),
        axis.title.x = element_text(color="blue", size=20, face="bold"),
        axis.title.y = element_text(color="#993333", size=20, face="bold"))+
  guides(fill=guide_legend(title="客群顏色指示表"))+
  scale_fill_discrete(name="Experimental\nCondition",breaks = c('not recent.frequent','recent.frequent','not recent.infrequent','recent.infrequent'), labels = c('先前客','常貴客','一次性消費客人','新顧客'))

# R與F分析圖 = R and F analysis chart
# 最近一次消費天數 =  Days of last consumption 
# 購買頻率 = Purchase frequency 
# 客群顏色指示表 = Customer group color indicator table


# 圖片X軸為距離最近一次消費天數（R），而Y軸為購買頻率（F），
# 表格內方塊的數字則表示顧客人數，人數越多方塊內的顏色堆疊越多，
# 並且顏色將顧客區隔分成四大類：
# The X-axis of the picture is the number of days since the last purchase (R), and the Y-axis is the frequency of purchase (F),
# The number in the square in the table indicates the number of customers. The more the number of people, the more colors in the square are stacked.
# And the color divides customers into four categories:

# 綠色區塊：常貴客；在短時間內頻頻來光顧，他們是最重要的顧客，
#           他們在短時間內已經來訪許多次了，也是忠實老顧客，是公司主要的客源。
# Green block: VIP; frequent visitors in a short time, they are the most important customers,
#              They have visited many times in a short period of time, and they are also loyal and regular customers and the main source of customers for the company.

# 紫色區塊：新顧客；來訪的頻率不是特別高，也許是第一次來或者只是一次性消費的客人，
#           但其中還是有潛力成為常貴客，所以行銷方向要以「產品導向」導入他們進入常貴客群為主。
# Purple block: new customers; the frequency of visits is not particularly high, maybe it is the first time or just a one-time consumption customer,
#               But it still has the potential to become frequent customers, so the marketing direction should be "product-oriented" to introduce them into frequent customers.

# 紅色區塊：先前客；他們對於一般的公司來說，是長時間內，營收最大的來源，
#           公司必須要持續吸引他們，讓他們能於「更短時間內」再至來訪，重新產生購買，
#           否則有可能會漸漸流失。
# Red block: previous customers; for ordinary companies, they are the largest source of revenue for a long time.
#            The company must continue to attract them so that they can visit again in a "shorter time" to regenerate purchases.
#            Otherwise, it may gradually lose.

# 藍色區塊：一次性消費客人；若此區塊比例偏多，代表來過的客人都不會來第二次。
# Blue block: one-time consumption guests; if the proportion of this block is too large, it means that the guests who have been there will not come a second time.


### 已經有了顧客區分的概念:
#   接下來便可以針對不同的客群使用不同的行銷手段、價格、優惠，以達到最終目的！
# 那分隔區塊內能不能再依照不同人口變數或產品區分呢？
# 當然可以！ 接下來就讓我們「交叉再交叉」，進行子區段分析（Sub-segments analysis）：
### There is already a concept of customer differentiation:
#        Then you can use different marketing methods, prices, and discounts for different customer groups to achieve the ultimate goal!
# Can the divided blocks be distinguished according to different demographic variables or products?
# Sure you can! Next, let us "cross and cross" to perform Sub-segments analysis:

lcg.sub <- orders02.segm %>%
  group_by(gender, cart, segm.rec, buy_freq) %>%
  summarise(quantity=n()) %>%
  mutate(client='顧客人數') %>%
  ungroup()

# 繪製RFM分析圖(性別分類)  fill=
# Draw RFM analysis diagram (gender classification) fill=
lcg.sub$gender = factor(lcg.sub$gender, levels = c('女性', '男性'))
ggplot(lcg.sub, aes(x=client, y=quantity, fill=gender)) +
  theme_bw() +
  scale_fill_brewer(palette='Set1') +
  theme(panel.grid = element_blank())+
  geom_bar(stat='identity', position='fill' , alpha=0.6) +
  facet_grid(buy_freq ~ segm.rec) +
  ggtitle("R與F分析圖（性別）") +
  xlab("最近一次消費天數") + ylab("購買頻率")+ 
  theme(plot.title = element_text(color="red", size=30),
        axis.title.x = element_text(color="blue", size=20, face="bold"),
        axis.title.y = element_text(color="#993333", size=20, face="bold"))+
  guides(fill=guide_legend(title="顧客性別"))

# 顧客性別 = Customer gender


# 我們先將性別（gender）來做區隔，紅色區塊是女性，藍色區塊是男性，
# 如果我們僅看最重要的常貴客分群，由R與M分析圖（性別分類）可以看出一很有趣的現象，
# 購買頻率在0–7天內平均大於5次為男性居多，但剛好等於5次的則是女性居多。
# Let’s divide gender (gender) first, the red block is female, and the blue block is male.
# If we only look at the most important frequent guest groups, we can see a very interesting phenomenon from the R and M analysis diagram (gender classification).
# The average purchase frequency in the 0-7 days is more than 5 times for men, but the majority is for women who are exactly 5 times.

# 「So what? 那接下來我該怎做？ 能更吸引這群人來購買？」
# 這時候我們就要再從性別切出更細更產品類別：
# "So what? What should I do next? Can this group of people be more attracted to buy?"
# At this time we will cut out more detailed product categories from gender:


# 繪製RFM分析圖(商品分類)
# Draw RFM analysis diagram (commodity classification)
ggplot(lcg.sub, aes(x=gender, y=quantity, fill=cart)) +
  theme_bw() +
  scale_fill_brewer(palette='Set1') +
  theme(panel.grid = element_blank())+
  geom_bar(stat='identity', position='fill' , alpha=0.6) +
  facet_grid(buy_freq ~ segm.rec) +
  ggtitle("R與F分析圖(商品分類)") +
  xlab("最近一次消費天數") + ylab("購買頻率")+ 
  theme(plot.title = element_text(color="red", size=30),
        axis.title.x = element_text(color="blue", size=20, face="bold"),
        axis.title.y = element_text(color="#993333", size=20, face="bold"))+
  guides(fill=guide_legend(title="商品顏色指示表"))

# 這時候要推薦何種商品便一目了然～！ 
# 同學可以想想，如果你是行銷資料科學家或專業經理人，
# 有了這些資料，應該如何分配這一家店的資源？
# At this time, it is clear what product to recommend~!
# Students can think about it, if you are a marketing data scientist or professional manager,
# With these information, how should the resources of this store be allocated?


# 首先，我們先從性別分類圖來看：
# First, let’s look at the gender classification chart:

# 0–7天內大於5次購買頻率的多為男生，女生次之
#    男生喜好購買的優先順序為「瓶裝水、高麗菜」的組合及「瓶裝水、高麗菜、牛奶麵包」的組合。
#    女生則優先順序為「瓶裝水、牛奶麵包」的組合及「瓶裝水、高麗菜、牛奶麵包」。
# 0–7 days more than 5 times purchase frequency is mostly boys, followed by girls
#     The priority order of boys’ preferences is the combination of "bottled water, cabbage" and the combination of "bottled water, cabbage, milk and bread".
#     For girls, the priority is the combination of "bottled water, milk and bread" and "bottled water, cabbage, milk and bread".

# 0–7天內等於5次購買頻率的多為女生，男生次之
#    男生喜好購買的優先順序為「瓶裝水、高麗菜」的組合及「瓶裝水、高麗菜、牛奶麵包」的組合。
#    女生則優先順序為「瓶裝水、牛奶麵包」的組合、「瓶裝水、高麗菜、牛奶麵包」且單獨的「瓶裝水」產品。
# 0–7 days equal to 5 purchase frequency is mostly girls, followed by boys
#     The priority order of boys’ preferences is the combination of "bottled water, cabbage" and the combination of "bottled water, cabbage, milk and bread".
#     For girls, the priority is a combination of "bottled water, milk and bread", "bottled water, cabbage, milk and bread" and a separate "bottled water" product.

# 8–15天內大於5次購買頻率的多為女生，男生次之
#    男生喜好購買的優先順序為「瓶裝水、牛奶麵包」的組合。這群男生僅喜好一種組合，
#    如果要讓這群男生逐漸轉變為0–7天消費，商家可以考慮在有利潤的情形下，
#    對「瓶裝水、高麗菜」及「瓶裝水、高麗菜、牛奶麵包」的組合進行行銷活動，
#    讓這群男生逐漸變成0–7天消費5次以上，賺取更多營收。
#    女生則優先順序為「瓶裝水、牛奶麵包」的組合、「瓶裝水、高麗菜、牛奶麵包」。
# 8–15 days more than 5 times purchase frequency is mostly girls, followed by boys
#      The priority order of boys’ preference for purchase is the combination of "bottled water, milk and bread". This group of boys only likes one combination,
#      If you want this group of boys to gradually convert to 0-7 days of consumption, the business can consider profitable circumstances,
#      Conduct marketing activities for the combination of "bottled water, cabbage" and "bottled water, cabbage, milk and bread",
#      Let this group of boys gradually become more than 5 consumptions in 0-7 days and earn more revenue.
#      For girls, the priority is the combination of "bottled water, milk bread", "bottled water, cabbage, milk bread".

# 恩…還是沒感覺嗎？ 讓我們用「8–15天內大於5次購買頻率的男性顧客」算看看，
# 假設這群男生有200人，平均11.5天消費7.5次，而「瓶裝水、牛奶麵包」的組合利潤為100，
# 平均每天可以達到
# 一天200人平均消費＝(7.5/11.5)*200人＝130.4348
# 每天利潤＝100* 130.4348＝ 13043.48元
# Hmm... Still not feeling it? Let’s take a look at "male customers who buy more than 5 times in 8-15 days",
# Assuming that there are 200 boys in this group, they consume 7.5 times in 11.5 days on average, and the combined profit of "bottled water, milk and bread" is 100.
# Average daily
# Average consumption of 200 people per day = (7.5/11.5)*200 people=130.4348
# Daily profit = 100* 130.4348 = 13043.48 dollars

# 如果對「瓶裝水、高麗菜」及「瓶裝水、高麗菜、牛奶麵包」的組合進行行銷活動，舉例來說，「打折促銷」。
# 瓶裝水、高麗菜＝250元原利潤經過7折轉換＝145
# 瓶裝水、高麗菜、牛奶麵包＝210元原利潤79折轉換＝105
# 200人因收到該折扣而到0-7天的轉換率 ＝ 200人 * 20% = 40人
# 這200人因為此行銷活動，為公司帶來的每天總利潤
# 8–15天內大於5次購買頻率：(7.5次/11.5天)*160人*100＝ 10,435
# 40人轉到「0–7天內大於5次購買平率」：(7.5次/5天)*15人*145+ (7.5次/5天)*25人*105=7,200
# 所以40人轉換，每天就賺 10,435 +7,200＝17,635，
# 比起原本的13,044，每天還要多賺4,591。如果經濟、品牌等因素狀況不變
# 一個月就多賺137,730，這是將近14萬元阿！
# If the combination of "bottled water, cabbage" and "bottled water, cabbage, milk and bread" is used for marketing activities, for example, "discount promotion".
# Bottled water, cabbage = 250 yuan original profit after 30% conversion = 145
# Bottled water, cabbage, milk bread = 210 yuan original profit conversion = 105
# The conversion rate of 200 people from 0-7 days after receiving the discount = 200 people * 20% = 40 people
# The total daily profit that these 200 people brought to the company because of this marketing activity
# 8– More than 5 purchase frequency within 15 days: (7.5 times/11.5 days) *160 people*100 = 10,435
# 40 people go to "More than 5 times purchase average rate within 0-7 days": (7.5 times/5 days)*15 people*145+ (7.5 times/5 days)*25 people*105=7,200
# So 40 people convert and earn 10,435 +7,200=17,635 every day,
# Compared to the original 13,044, earn 4,591 more per day. If the economy, brand and other factors remain unchanged
# Earn 137,730 more in one month, which is nearly 140,000 dollars

# 一年就差了168萬阿！
# Nearly 1.68 million dollars in one year!

# 由此可見R與F分析技術可以有效率地將數據結合，並可在子段進行無限的變化，
# 就有很大的機會可以賺取更多的營收，只要有顧客相關的資料，
# 例如：職業、住址、甚至興趣習慣等…，再配合上業務方面知識分析，
# 便可製作出有指標性的視覺化資料，並且調整銷售策略。
# It can be seen that R and F analysis techniques can efficiently combine data and make unlimited changes in sub-segments.
#　There is a great opportunity to earn more revenue, as long as there is customer-related information,
# For example: occupation, residential address, even interest habits, etc..., coupled with business knowledge analysis,
# Can produce indicator visual data and adjust sales strategy.

##### homework 作業 -----
# RFM Model using R | CRM 客戶分群模型 Customer Segmentation | R 統計
# https://www.jamleecute.com/rfm-model-crm-customer-segmentation-r/
# 使用CDNOW dataset (1/10th sample)
# Try to Use CDNOW dataset (1/10th sample)