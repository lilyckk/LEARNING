#CH4_�q�ѻP�ר��ഫ�v
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

#### 1. Load Data ####(���J�ɮ�)
df <- read.csv(
  file="bank-full.csv", 
  header=TRUE, 
  sep=";"
)

# Encode conversions as 0s and 1s(���ܼ�y�i��s�X)
df$conversion <- ifelse(df$y == "no",0,1)

head(df)
##����ƱNy�ܼ��ܦ��Nno/yes�H0/1���ܡA�ñN�g�L�s�X�����x�s��s����줤�A���W�٬�conversion
##head(): ���data frame�����e6�����


#### 2. Data Analysis ####(��Ƥ��R)

# column names
colnames(df)
##colnames()���:�]�w column �W��


#### 2.1. Conversion Rate ####(�ഫ�v)
sprintf("total conversions: %i out of %i", sum(df$conversion), nrow(df))
sprintf("conversion rate: %0.2f%%", sum(df$conversion)/nrow(df)*100.0)
##�����U�ȭq�\�w���s�ڤ��ഫ�v(conversion���Ȭ�1�����)

#### 2.2. Conversion Rates by Marital Status ####(�H�B�ê��p�Ϥ����ഫ�v)
conversionsByMarital <- df %>% 
  group_by(Marital=marital) %>% 
  summarise(Count=n(), NumConversions=sum(conversion))%>% 
  mutate(ConversionRate=NumConversions/Count*100.0)
##group_by() ���]�w���ը̾�(���B�B���B�γ樭)
##summarise()�Ψӭp��έp��
##mutate()�W�[�s���(�o�̬O�s�W���o�C�@�ӱB�ê��p���O���`�ഫ�v�����)

conversionsByMarital

ggplot(conversionsByMarital, aes(x=Marital, y=ConversionRate)) + #�إ߫���������
  geom_bar(width=0.5, stat="identity") +
  ggtitle('Conversion Rates by Marital Status') +
  xlab("Marital Status") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 
#�վ�D��ƭ���ø�Ϫ��T�j�����G��r(text elements)�B�u��(line elements)�B���(rectangle elements)�C


#### 2.2. Conversion Rates by Job ####(�H¾�~�Ϥ����ഫ�v)
conversionsByJob <- df %>%  
  group_by(Job=job) %>%    #�Hjob�i����� 
  summarise(Count=n(), NumConversions=sum(conversion)) %>%   #��sum��ƹ�conversion���C��¾�~���O�i��[�`
  mutate(ConversionRate=NumConversions/Count*100.0)         

conversionsByJob

ggplot(conversionsByJob, aes(x=Job, y=ConversionRate)) +  #�إߤ���������
  geom_bar(width=0.5, stat="identity") +
  coord_flip() +                #�Φ���ƱN�����ഫ������������
  ggtitle('Conversion Rates by Job') +
  xlab("Job") +
  ylab("Conversion Rate (%)") +
  theme(plot.title = element_text(hjust = 0.5)) 

#### 2.3. Default Rates by Conversions ####(�H�ഫ�v�Ϥ����w�]�Q�v)
defaultByConversion <- df %>% 
  group_by(Default=default, Conversion=conversion) %>% 
  summarise(Count=n())
  #�Hdefault��conversion����ƶi����աA�Hn()�@���[�`���

defaultByConversion

ggplot(defaultByConversion, aes(x="", y=Count, fill=Default)) +  #ø�s����
  geom_bar(width=1, stat = "identity", position=position_fill()) +
  geom_text(aes(x=1.25, label=Count), position=position_fill(vjust = 0.5)) +
  coord_polar("y") +    
  facet_wrap(~Conversion) +    #������Ӷ���(�ഫ�ջP���ഫ��)
  ggtitle('Default (0: Non Conversions, 1: Conversions)') +
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    plot.title=element_text(hjust=0.5),
    legend.position='bottom')
#�Q��coord_polar("y")��ơA�i�H�z�L�����ϵe����



#### 2.4. Bank Balance by Conversions ####(�H�ഫ�v�Ϥ����b��l�B)
ggplot(df, aes(x="", y=balance)) + 
  geom_boxplot() +                 #�إ߽c�ι�
  facet_wrap(~conversion) +
  ylab("balance") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Balance") +
  theme(plot.title=element_text(hjust=0.5))
#�Ϥ����\�h���s�ȡA�G�ܧ�{���X����goem_boxplot() ->goem_boxplot(outlier.shape = NA)�H�ư����s��

ggplot(df, aes(x="", y=balance)) + 
  geom_boxplot(outlier.shape = NA) +
  scale_y_continuous(limits = c(-2000, 5000)) +
  facet_wrap(~conversion) +
  ylab("balance") +
  xlab("0: Non-Conversion, 1: Conversion") +
  ggtitle("Conversion vs. Non-Conversions: Balance") +
  theme(plot.title=element_text(hjust=0.5))

#### 2.5. Conversions by Number of Contacts ####(�H�ഫ�v�Ϥ����p������)
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

#ggplot2�Ѧ�:https://www.twblogs.net/a/5b8cac562b7177188334734e

#### 3. Encoding Categorical Variables ####(�����O�ܼƽs�X)
rapply(df, function(x) length(unique(x)))
##lapply�O�N�B�⪺�����a�J���J�ɮת��C�Ӥ����W�A��rapply�h�O���j������lapply


#### 3.1. encoding 'month' ####(������s�X)
# unique values
unique(df$month)
##unique()�ֳt���w��줤�����ƭ�
# convert to numbers
months = lapply(month.abb, function(x) tolower(x))
months
##tolower(x)�O�Nmonth.abb�`�ƪ����ܬ������p�g
##toupper(x)�h�O�|�ܬ������j�g

# test
match(unique(df$month), months)

# encode
df$month <- match(df$month, months)
# check
df %>% 
  group_by(month) %>% 
  summarise(Count=n())

#### 3.2. encoding job, housing, marital ####(���u�@�B�жU�αB�ê��p�s�X)
df$job <- factor(df$job)
df$housing <- factor(df$housing)
df$marital <- factor(df$marital)
##factor()�N�����O�ܼ��ରfactor��ƫ��A


#### 4. Fitting Decision Trees ####(�إߨM����)

# grow tree (�إߨM����ҫ�)
fit <- rpart(
  conversion ~ age + balance + campaign + previous + housing + job + marital,
  method="class", 
  data=df,
  control=rpart.control(maxdepth=4, cp=0.0001)
)
##rpart�ҫ����Ĥ@�h�޼Ʃw�q�F�S�x�P�ؼШ�ơA�b��������ϥΤF�e�z�ܼƧ@���S�x�A��conversion�����ؼШ��
##��176��H method="class"��J�ȡA�N�M����ҫ��w�q�������ҫ�
##��178��Hcontrol����J�Ƚվ�M����ҫ�(�Hmaxdepth�]�w�̤j�`�׬�4)

# plot tree (��Ū�M����)
fancyRpartPlot(fit)