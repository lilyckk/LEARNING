#CH4_從參與度到轉換率
install.packages("dplyr")
library(dplyr)

install.packages('ggplot2')
library(ggplot2)

install.packages('rattle')
library(rattle)	

install.packages('rpart')
library(rpart) # used to build decision tree

install.packages('rpart.plot')
library(rpart.plot)

#### 1. Load Data ####(載入檔案)
df <- read.csv(
  file="bank-full.csv", 
  header=TRUE, 
  sep=";"
)

# Encode conversions as 0s and 1s(對變數y進行編碼)
df$conversion <- ifelse(df$y == "no",0,1)

head(df)
##此函數將y變數變成將no/yes以0/1表示，並將經過編碼的值儲存到新的欄位中，欄位名稱為conversion
##head(): 顯示data frame中的前6筆資料


#### 2. Data Analysis ####(資料分析)

# column names
colnames(df)
##colnames()函數:設定 column 名稱


#### 2.1. Conversion Rate ####(轉換率)
sprintf("total conversions: %i out of %i", sum(df$conversion), nrow(df))
sprintf("conversion rate: %0.2f%%", sum(df$conversion)/nrow(df)*100.0)
##此為顧客訂閱定期存款之轉換率(conversion欄位值為1的資料)

#### 2.2. Conversion Rates by Marital Status ####(以婚姻狀況區分的轉換率)
conversionsByMarital <- df %>% 
  group_by(Marital=marital) %>% 
  summarise(Count=n(), NumConversions=sum(conversion))%>% 
  mutate(ConversionRate=NumConversions/Count*100.0)
##group_by() 為設定分組依據(離婚、結婚或單身)
##summarise()用來計算統計值
##mutate()增加新欄位(這裡是新增取得每一個婚姻狀況類別的總轉換率的欄位)

conversionsByMarital

ggplot(conversionsByMarital, aes(x=Marital, y=ConversionRate)) + #建立垂直長條圖
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Conversion Rates by Marital Status') +
  xlab("Marital Status") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 
#調整非資料面的繪圖的三大元素：文字(text elements)、線條(line elements)、方形(rectangle elements)。


#### 2.2. Conversion Rates by Job ####(以職業區分的轉換率)
conversionsByJob <- df %>%  
  group_by(Job=job) %>%    #以job進行分組 
  summarise(Count=n(), NumConversions=sum(conversion)) %>%   #用sum函數對conversion欄位每個職業類別進行加總
  mutate(ConversionRate=NumConversions/Count*100.0)         

conversionsByJob

ggplot(conversionsByJob, aes(x=Job, y=ConversionRate)) +  #建立水平長條圖
  geom_bar(width=0.5, stat="identity") +
  coord_flip() +                #用此函數將垂直轉換成水平長條圖
  ggtitle('Conversion Rates by Job') +
  xlab("Job") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 

#### 2.3. Default Rates by Conversions ####(以轉換率區分的預設利率)
defaultByConversion <- df %>% 
  group_by(Default=default, Conversion=conversion) %>% 
  summarise(Count=n())
  #以default跟conversion欄對資料進行分組，以n()作為加總函數

defaultByConversion

ggplot(defaultByConversion, aes(x="", y=Count, fill=Default)) +  #繪製圓餅圖
  geom_bar(width=1, stat = "identity", position=position_fill()) +
  geom_text(aes(x=1.25, label=Count), position=position_fill(vjust = 0.5)) +
  coord_polar("y") +    
  facet_wrap(~Conversion) +    #分成兩個圓餅圖(轉換組與未轉換組)
  ggtitle('Default (0: Non Conversions, 1: Conversions)') +
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    plot.title=element_text(hjust=0.5),
    legend.position='bottom')
#利用coord_polar("y")函數，可以透過長條圖畫圓餅圖



#### 2.4. Bank Balance by Conversions ####(以轉換率區分的帳戶餘額)
ggplot(df, aes(x="", y=balance)) + 
  geom_boxplot() +                 #建立箱形圖
  facet_wrap(~conversion) +
  ylab("balance") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Balance") +
  theme(plot.title=element_text(hjust=0.5))
#圖中有許多離群值，故變更程式碼中的goem_boxplot() ->goem_boxplot(outlier.shape = NA)以排除離群值

ggplot(df, aes(x="", y=balance)) + 
  geom_boxplot(outlier.shape = NA) +
  scale_y_continuous(limits = c(-2000, 5000)) +
  facet_wrap(~conversion) +
  ylab("balance") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Balance") +
  theme(plot.title=element_text(hjust=0.5))

#### 2.5. Conversions by Number of Contacts ####(以轉換率區分的聯絡次數)
conversionsByNumContacts <- df %>% 
  group_by(Campaign=campaign) %>% 
  summarise(Count=n(), NumConversions=sum(conversion)) %>%
  mutate(ConversionRate=NumConversions/Count*100.0)

conversionsByNumContacts

ggplot(conversionsByNumContacts, aes(x=Campaign, y=ConversionRate)) +
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Conversion Rates by Number of Contacts') +
  xlab("Number of Contacts") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5))

#ggplot2參考:https://www.twblogs.net/a/5b8cac562b7177188334734e

#### 3. Encoding Categorical Variables ####(為類別變數編碼)
rapply(df, function(x) length(unique(x)))
##lapply是將運算的公式帶入到輸入檔案的每個元素上，而rapply則是遞迴版本的lapply


#### 3.1. encoding 'month' ####(為月份編碼)
# unique values
unique(df$month)
##unique()快速給定欄位中不重複值
# convert to numbers
months = lapply(month.abb, function(x) tolower(x))
months
##tolower(x)是將month.abb常數的值變為全部小寫
##toupper(x)則是會變為全部大寫

# test
match(unique(df$month), months)

# encode
df$month <- match(df$month, months)
# check
df %>% 
  group_by(month) %>% 
  summarise(Count=n())

#### 3.2. encoding job, housing, marital ####(為工作、房貸及婚姻狀況編碼)
df$job <- factor(df$job)
df$housing <- factor(df$housing)
df$marital <- factor(df$marital)
##factor()將此類別變數轉為factor資料型態


#### 4. Fitting Decision Trees ####(建立決策樹)

# grow tree (建立決策樹模型)
fit <- rpart(
  conversion ~ age + balance + campaign + previous + housing + job + marital,
  method="class", 
  data=df,
  control=rpart.control(maxdepth=4, cp=0.0001)
)
##rpart模型的第一則引數定義了特徵與目標函數，在此樹當中使用了前述變數作為特徵，用conversion做為目標函數
##第176行以 method="class"輸入值，將決策樹模型定義為分類模型
##第178行以control的輸入值調整決策樹模型(以maxdepth設定最大深度為4)

# plot tree (解讀決策樹)
fancyRpartPlot(fit)
