# -*- coding: utf-8 -*-
"""Chapter04PythonFromEngagementToConversions_DecisionTree.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1hgPyIKdmlUilLpilF7K9gjxAHNsGpOCT

**Chapter04 Python From Engagement To Conversions - Decision Tree**
  第04章Python從參與到轉化 —— 決策樹
"""
# In[] From Engagement To Conversions 從參與到轉化
import matplotlib.pyplot as plt  # Data Visualization 
import pandas as pd              # 資料處理和資料分析套件 Data processing and data analysis

#import linear algebra and data manipulation libraries
import numpy as np
import pandas as pd

#import standard visualization
import matplotlib.pyplot as plt
import seaborn as sns

# In[] From Engagement To Conversions 從參與到轉化
#df = pd.read_csv(r'E:\2021\2021-09 python\python 機器學習\DSdata\bank-full.csv', sep=';')
df = pd.read_csv(r'bank-full.csv', sep=';')

df.shape  # 顯示欄位和資料 Display fields and data
#(45211, 17)

# 印出前 5 筆資訊
df.head()
#    age           job  marital  education  ... pdays  previous poutcome   y
# 0   58    management  married   tertiary  ...    -1         0  unknown  no
# 1   44    technician   single  secondary  ...    -1         0  unknown  no
# 2   33  entrepreneur  married  secondary  ...    -1         0  unknown  no
# 3   47   blue-collar  married    unknown  ...    -1         0  unknown  no
# 4   33       unknown   single    unknown  ...    -1         0  unknown  no
# [5 rows x 17 columns]

df.columns
# Index(['age', 'job', 'marital', 'education', 'default', 'balance', 'housing',
#        'loan', 'contact', 'day', 'month', 'duration', 'campaign', 'pdays',
#        'previous', 'poutcome', 'y'],
#       dtype='object')

df['y'].head()
# 0    no
# 1    no
# 2    no
# 3    no
# 4    no
# Name: y, dtype: object

# Encode y as 0 or 1 對 y 進行編碼，以 0 或 1 表示 
df['conversion'] = df['y'].apply(lambda x: 0 if x == 'no' else 1)

df.shape#顯示欄位和資料
#(45211, 18)

df.columns
# Index(['age', 'job', 'marital', 'education', 'default', 'balance', 'housing',
#        'loan', 'contact', 'day', 'month', 'duration', 'campaign', 'pdays',
#        'previous', 'poutcome', 'y', 'conversion'],
#       dtype='object')

df['conversion'].head()
# 0    0
# 1    0
# 2    0
# 3    0
# 4    0
# Name: conversion, dtype: int64

df[['y','conversion']].head()
#     y  conversion
# 0  no           0
# 1  no           0
# 2  no           0
# 3  no           0
# 4  no           0

df[['y','conversion']].tail()
#          y  conversion
# 45206  yes           1
# 45207  yes           1
# 45208  yes           1
# 45209   no           0
# 45210   no           0

df.head()
#    age           job  marital  education  ... previous  poutcome   y conversion
# 0   58    management  married   tertiary  ...        0   unknown  no          0
# 1   44    technician   single  secondary  ...        0   unknown  no          0
# 2   33  entrepreneur  married  secondary  ...        0   unknown  no          0
# 3   47   blue-collar  married    unknown  ...        0   unknown  no          0
# 4   33       unknown   single    unknown  ...        0   unknown  no          0

# [5 rows x 18 columns]

# In[] Data Analysis
###2. Data Analysis
df.columns

list(df.columns)
# ['age',
#  'job',
#  'marital',
#  'education',
#  'default',
#  'balance',
#  'housing',
#  'loan',
#  'contact',
#  'day',
#  'month',
#  'duration',
#  'campaign',
#  'pdays',
#  'previous',
#  'poutcome',
#  'y',
#  'conversion']

tuple(list(df.columns))

# Data Exploration
# https://www.kaggle.com/aleksandradeis/bank-marketing-analysis
# After we imported the dataset, we have to look at the total number of rows in the dataset and analyze the number of missing values.

# number of rows in dataset
print("Bank marketing dataset consists of {rows} rows.".format(rows = len(df)))
# Bank marketing dataset consists of 45211 rows.

# In[] find percentage of missing values for each column
df.isnull()
#          age    job  marital  education  ...  previous  poutcome      y  conversion
# 0      False  False    False      False  ...     False     False  False       False
# 1      False  False    False      False  ...     False     False  False       False

df.isnull().mean()
# age           0.0
# job           0.0
# marital       0.0
# education     0.0
# default       0.0
# balance       0.0
# housing       0.0
# loan          0.0
# contact       0.0
# day           0.0
# month         0.0
# duration      0.0
# campaign      0.0
# pdays         0.0
# previous      0.0
# poutcome      0.0
# y             0.0
# conversion    0.0
# dtype: float64
df.isnull().sum()
# age           0.0
# job           0.0
# marital       0.0

missing_values = df.isnull().mean()*100

missing_values.sum()
# 0.0

# So we see that there are no missing values.

# In[] Categorical columns exploration 類別型變數
# In the dataset we have both categorical and numerical columns. 
# Let's look at the values of categorical columns first.
df.columns
# Index(['age', 'job', 'marital', 'education', 'default', 'balance', 'housing',
#        'loan', 'contact', 'day', 'month', 'duration', 'campaign', 'pdays',
#        'previous', 'poutcome', 'y', 'conversion'],
#       dtype='object')
df.info()
# <class 'pandas.core.frame.DataFrame'>
# RangeIndex: 45211 entries, 0 to 45210
# Data columns (total 18 columns):
#  #   Column      Non-Null Count  Dtype 
# ---  ------      --------------  ----- 
#  0   age         45211 non-null  int64 
#  1   job         45211 non-null  object v
#  2   marital     45211 non-null  object v
#  3   education   45211 non-null  object v
#  4   default     45211 non-null  object v
#  5   balance     45211 non-null  int64 
#  6   housing     45211 non-null  object v
#  7   loan        45211 non-null  object v
#  8   contact     45211 non-null  object v
#  9   day         45211 non-null  int64 
#  10  month       45211 non-null  object v
#  11  duration    45211 non-null  int64 
#  12  campaign    45211 non-null  int64 
#  13  pdays       45211 non-null  int64 
#  14  previous    45211 non-null  int64 
#  15  poutcome    45211 non-null  object v
#  16  y           45211 non-null  object
#  17  conversion  45211 non-null  int64 
# dtypes: int64(8), object(10)
# memory usage: 6.2+ MB

cat_columns = ['job', 'marital', 'education', 'default', 'housing', 'loan', 'contact', 'month','y']

fig, axs = plt.subplots(3, 3, sharex=False, sharey=False, figsize=(20, 15))

counter = 0
for cat_column in cat_columns:
    value_counts = df[cat_column].value_counts()
    
    trace_x = counter // 3
    trace_y = counter % 3
    x_pos = np.arange(0, len(value_counts))
    
    axs[trace_x, trace_y].bar(x_pos, value_counts.values, tick_label = value_counts.index)
    
    axs[trace_x, trace_y].set_title(cat_column)
    
    for tick in axs[trace_x, trace_y].get_xticklabels():
        tick.set_rotation(90)
    
    counter += 1

plt.show()

# In[] example for for loop
for i in range (1, 10, 1):
    print(i)
    
for i in range (1, 10, 2):
    print(i)
    
for i in range (2, 10, 2):
    print(i)
    
for i in range (1, 10):
    print(i)
    
for i in range (10):
    print(i)
    
for cat_column in cat_columns:
    print(cat_column)
    
# In[Homework] 單一類別變數 Bar Charts
# Bar Charts
# https://waynestalk.com/python-bar-charts/
# 下面的範例顯示如何用 bar() 繪製長條圖。

import numpy as np
import matplotlib.pyplot as plt
students = ['Jack', 'Mary', 'Mike', 'David']
math_scores = [78, 67, 90, 81]
x = np.arange(len(students))
plt.bar(x, math_scores, color=['red', 'green', 'blue', 'yellow'])
plt.xticks(x, students)
plt.xlabel('Students')
plt.ylabel('Math')
plt.title('Final Term')
plt.show()

#for cat_column in cat_columns:

value_counts = df['marital'].value_counts()
maritalDF = pd.DataFrame(value_counts)
x = np.arange(len(maritalDF))
maritalDF.index
# Index(['married', 'single', 'divorced'], dtype='object')
maritalDF.marital
# married     27214
# single      12790
# divorced     5207
# Name: marital, dtype: int64

plt.bar(x, value_counts, color=['red', 'green', 'blue'])
plt.xticks(x, maritalDF.index)
plt.xlabel('Marital Status')
plt.ylabel('value_counts')
plt.title('Marital Status')
plt.show()


plt.bar(x, maritalDF.marital, color=['red', 'green', 'blue'])
plt.xticks(x, maritalDF.index)
plt.xlabel('Marital Status')
plt.ylabel('value_counts')
plt.title('Marital Status')
plt.show()

plt.bar(x, maritalDF, color=['red', 'green', 'blue'])
plt.xticks(x, maritalDF.index)
plt.xlabel('Marital Status')
plt.ylabel('value_counts')
plt.title('Marital Status')
plt.show()
# ERROR
# TypeError: only size-1 arrays can be converted to Python scalars

# In[Homework 01 ] 單一類別變數 Bar Charts for each Categorical columns exploration 類別型變數
# 'job', 'marital', 'education', 'default', 'housing', 'loan', 'contact', 'month','y'

# In[Homework 02] Please explain the meaning of each bar chart.

# In[] Numerical columns exploration 數值/連續型變數
# Now let's look at the numerical columns' values. 
# The most convenient way to look at the numerical values is plotting histograms.

df.info()
#  #   Column      Non-Null Count  Dtype 
# ---  ------      --------------  ----- 
#  0   age         45211 non-null  int64     v
#  1   job         45211 non-null  object
#  2   marital     45211 non-null  object
#  3   education   45211 non-null  object
#  4   default     45211 non-null  object
#  5   balance     45211 non-null  int64     v 
#  6   housing     45211 non-null  object
#  7   loan        45211 non-null  object
#  8   contact     45211 non-null  object
#  9   day         45211 non-null  int64     v 
#  10  month       45211 non-null  object
#  11  duration    45211 non-null  int64     v 
#  12  campaign    45211 non-null  int64     v 
#  13  pdays       45211 non-null  int64     v 
#  14  previous    45211 non-null  int64     v 
#  15  poutcome    45211 non-null  object
#  16  y           45211 non-null  object
#  17  conversion  45211 non-null  int64     v 
# dtypes: int64(8), object(10)
# memory usage: 6.2+ MB

num_columns = ['balance', 'day','duration', 'campaign', 'pdays', 'conversion']

fig, axs = plt.subplots(2, 3, sharex=False, sharey=False, figsize=(20, 15))

counter = 0
for num_column in num_columns:
    
    trace_x = counter // 3
    trace_y = counter % 3
    
    axs[trace_x, trace_y].hist(df[num_column])
    
    axs[trace_x, trace_y].set_title(num_column)
    
    counter += 1

plt.show()

# We can see that numerical columns have outliers (especially 'pdays', 'campaign' and 'conversion' columns). 
# Possibly there are incorrect values (noisy data), so we should look closer at the data and decide how do we manage the noise.

num_columns2 = ['age', 'balance', 'day','duration', 'campaign', 'pdays','previous', 'conversion']

fig, axs = plt.subplots(3, 3, sharex=False, sharey=False, figsize=(20, 15))

counter = 0
for num_column in num_columns2:
    
    trace_x = counter // 3
    trace_y = counter % 3
    
    axs[trace_x, trace_y].hist(df[num_column])
    
    axs[trace_x, trace_y].set_title(num_column)
    
    counter += 1

plt.show()

# In[Homework] 單一連續型變數 繪製直方圖 hist Charts for Continuous variable
# 從資料列表中使用 Matplotlib 繪製直方圖
import matplotlib.pyplot as plt

data = [3,4,2,3,4,5,4,7,8,5,4,6,2,1,0,9,7,6,6,5,4]

n, bins, patches=plt.hist(data)
plt.xlabel("Values")
plt.ylabel("Frequency")
plt.title("Histogram")
plt.show() 


n, bins, patches=plt.hist(df['balance'])
plt.xlabel("Values")
plt.ylabel("Frequency")
plt.title("Histogram of balance")
plt.show()

n, bins, patches=plt.hist(df['balance'],bins=50)
plt.xlabel("Values")
plt.ylabel("Frequency")
plt.title("Histogram of balance")
plt.show()

n, bins, patches=plt.hist(df['campaign'],bins=50)
plt.xlabel("Values")
plt.ylabel("Frequency")
plt.title("Histogram of campaign")
plt.show()

# In[Homework 03] 單一連續型變數 繪製直方圖 hist Charts for Continuous variable
# ['age', 'balance', 'day','duration', 'campaign', 'pdays','previous', 'conversion']

# In[] Let's look closer at the values of 'campaign', 'pdays' and 'previous' columns:

df[['pdays', 'campaign', 'previous', 'conversion']].describe()
#               pdays      campaign      previous    conversion
# count  45211.000000  45211.000000  45211.000000  45211.000000
# mean      40.197828      2.763841      0.580323      0.116985
# std      100.128746      3.098021      2.303441      0.321406
# min       -1.000000      1.000000      0.000000      0.000000
# 25%       -1.000000      1.000000      0.000000      0.000000
# 50%       -1.000000      2.000000      0.000000      0.000000
# 75%       -1.000000      3.000000      0.000000      0.000000
# max      871.000000     63.000000    275.000000      1.000000

df[['age', 'balance', 'day','duration', 'campaign', 'pdays','previous', 'conversion']].describe()

# In[] Analysis of the response (y) column
# It is very important to look at the response column, which holds the information, which we are going to predict. In our case we should look at 'deposit' column and compare its values to other columns.
# First of all we should look at the number of 'yes' and 'no' values in the response column 'deposit'.

value_counts = df['y'].value_counts()
value_counts

value_counts.plot.bar(title = 'response (y) value counts')

# pandas.DataFrame.plot.bar
# https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.plot.bar.html

# In[] Let's see how response 'y' column value varies depending on other categorical columns' values:

#job and response
j_df = pd.DataFrame()

j_df['yes'] = df[df['y'] == 'yes']['job'].value_counts()
j_df['no'] = df[df['y'] == 'no']['job'].value_counts()

j_df.plot.bar(title = 'Job and response (y)')

j_df
#                 yes    no
# management     1301  8157
# technician      840  6757
# blue-collar     708  9024
# admin.          631  4540
# retired         516  1748
# services        369  3785
# student         269   669
# unemployed      202  1101
# self-employed   187  1392
# entrepreneur    123  1364
# housemaid       109  1131
# unknown          34   254

# In[] #marital status and response
m_df = pd.DataFrame()

m_df['yes'] = df[df['y'] == 'yes']['marital'].value_counts()
m_df['no'] = df[df['y'] == 'no']['marital'].value_counts()

m_df.plot.bar(title = 'Marital status and response')
m_df
#            yes     no
# married   2755  24459
# single    1912  10878
# divorced   622   4585

# In[] #education and response
edu_df = pd.DataFrame()

edu_df['yes'] = df[df['y'] == 'yes']['education'].value_counts()
edu_df['no'] = df[df['y'] == 'no']['education'].value_counts()

edu_df.plot.bar(title = 'Education and response')

edu_df
#             yes     no
# secondary  2450  20752
# tertiary   1996  11305
# primary     591   6260
# unknown     252   1605

# In[] #type of contact and response
contact_df = pd.DataFrame()

contact_df['yes'] = df[df['y'] == 'yes']['contact'].value_counts()
contact_df['no'] = df[df['y'] == 'no']['contact'].value_counts()

contact_df.plot.bar(title = 'Type of contact and response')

contact_df
#             yes     no
# cellular   4369  24916
# unknown     530  12490
# telephone   390   2516

# In[] Regarding the diagrams we can tell that according to our dataset:
#      關於圖表，我們可以根據我們的數據集判斷：

# 1. Customers with 'blue-collar' and 'services' jobs are less likely to subscribe for term deposit.
# 1. 從事“藍領”和“服務”工作的客戶不太可能訂閱定期存款。
# 2. Married customers are less likely to subscribe for term deposit.
# 2. 已婚客戶不太可能認購定期存款。
# 3. Customers with 'cellular' type of contact are less likely to subscribe for term deposit.
# 3. 具有“手機”類型聯繫人的客戶不太可能訂閱定期存款。

# In[] Now let's look how numerical columns affect term deposit subscription.
# 現在讓我們看看數字列如何影響定期存款訂閱。

#balance and deposit

b_df = pd.DataFrame()
b_df['balance_yes'] = (df[df['y'] == 'yes'][['y','balance']].describe())['balance']
b_df['balance_no'] = (df[df['y'] == 'no'][['y','balance']].describe())['balance']

b_df
#         balance_yes     balance_no
# count   5289.000000   39922.000000
# mean    1804.267915    1303.714969
# std     3501.104777    2974.195473
# min    -3058.000000   -8019.000000
# 25%      210.000000      58.000000
# 50%      733.000000     417.000000
# 75%     2159.000000    1345.000000
# max    81204.000000  102127.000000

# In[] plot Balance and deposit statistics
b_df.plot.bar(title = 'Balance and deposit statistics')

b_df.drop(['count', '25%', '50%', '75%']).plot.bar(title = 'Balance and deposit statistics')

# In[] #age and deposit

a_df = pd.DataFrame()
a_df['age_yes'] = (df[df['y'] == 'yes'][['y','age']].describe())['age']
a_df['age_no'] = (df[df['y'] == 'no'][['y','age']].describe())['age']

a_df
#            age_yes        age_no
# count  5289.000000  39922.000000
# mean     41.670070     40.838986
# std      13.497781     10.172662
# min      18.000000     18.000000
# 25%      31.000000     33.000000
# 50%      38.000000     39.000000
# 75%      50.000000     48.000000
# max      95.000000     95.000000

# In[] plot Age and deposit statistics

a_df.drop(['count', '25%', '50%', '75%']).plot.bar(title = 'Age and deposit statistics')

# In[] #number of contacts performed during this campaign ('campaign') and deposit (y)
c_df = pd.DataFrame()
c_df['campaign_yes'] = (df[df['y'] == 'yes'][['y','campaign']].describe())['campaign']
c_df['campaign_no'] = (df[df['y'] == 'no'][['y','campaign']].describe())['campaign']

c_df
#        campaign_yes   campaign_no
# count   5289.000000  39922.000000
# mean       2.141047      2.846350
# std        1.921826      3.212767
# min        1.000000      1.000000
# 25%        1.000000      1.000000
# 50%        2.000000      2.000000
# 75%        3.000000      3.000000
# max       32.000000     63.000000

# In[] plot Number of contacts performed during this campaign and deposit statistics
c_df.drop(['count', '25%', '50%', '75%']).plot.bar(title = 'Number of contacts performed during this campaign and deposit statistics')

c_df.drop(['count', 'min', '25%', '50%', '75%', 'max']).plot.bar(title = 'Number of contacts performed during this campaign and deposit statistics')


# In[] Data Cleaning 數據清洗
# https://www.kaggle.com/aleksandradeis/bank-marketing-analysis

# In[] Conversion Rate
# 1. Conversion Rate
# 2. 表示顧客訂閱定期存款客戶
conversion_rate_df = pd.DataFrame(
    df.groupby('conversion').count()['y'] / df.shape[0] * 100.0
)

conversion_rate_df
#                    y
# conversion          
# 0           88.30152
# 1           11.69848

### 解析
conversion_rate_df_count = pd.DataFrame(
    df.groupby('conversion').count()['y'])
conversion_rate_df_count
#                 y
# conversion       
# 0           39922
# 1            5289

df.shape[0]
# 45211

39922/45211  
#0.8830151954170445
### end of 解析

# In[補充] Groupby用法詳解
# https://reurl.cc/1YrLvW
# 在日常的數據分析中，經常需要將數據 在Pandas中，上述的數據處理操作主要運用
# groupby groupby agg transform apply

# 為了後續圖解的方便，採用模擬生成的10個樣本數據，代碼和數據如下：

company=["A","B","C"]
data = pd.DataFrame({
    "company":[company[x] for x in np.random.randint(0,len(company),15)],
    "salary":np.random.randint(5,50,15),
    "age":np.random.randint(15,50,15)})
data
#    company  salary  age
# 0        C      29   47
# 1        A      19   24
# 2        B      26   41
# 3        B      33   18
# 4        A      12   26
# 5        A      23   22
# 6        C      37   15
# 7        B      11   39
# 8        B      29   39
# 9        B      23   19
# 10       B       8   35
# 11       B      48   40
# 12       C      44   44
# 13       C      23   20
# 14       C      18   20

#一、Groupby的基本原理
# 在pandas中，實現分組操作的代碼很簡單，僅需一行代碼，在這裡，將上面的數據集按照 company
groupCompany = data.groupby("company")
groupCompany
# <pandas.core.groupby.generic.DataFrameGroupBy object at 0x000001CFCF64BFD0>

# 那這個生成的 對 所返回的結果是其內存地址，並不利於直觀地理解，為了看看
list(groupCompany)
# [('A',
#     company  salary  age
#   1       A      19   24
#   4       A      12   26
#   5       A      23   22),
#  ('B',
#      company  salary  age
#   2        B      26   41
#   3        B      33   18
#   7        B      11   39
#   8        B      29   39
#   9        B      23   19
#   10       B       8   35
#   11       B      48   40),
#  ('C',
#      company  salary  age
#   0        C      29   47
#   6        C      37   15
#   12       C      44   44
#   13       C      23   20
#   14       C      18   20)]
### 轉換成列表的形式後，可以看到，列表由三個元組組成，每個元組中，第一個元素是組別

# 二、agg 聚合操作
# 聚合操作是 聚合操作可以用來求和、均值、最大值、最小值等，下面的表格列出了Pandas中常見的聚合操作
# count
# sum
# mean
# median
# std, var
# min, max
# prod
# first, last

# 針對樣例數據集，如果我想求不同公司員工的平均年齡和平均薪水，可以按照下方的代碼進行：
data.groupby("company").agg('mean')
#             salary   age
# company                 
# A        18.000000  24.0
# B        25.428571  33.0
# C        30.200000  29.2

# 如果想對針對不同的列求不同的值，比如要計算不同公司員工的平均年齡以及薪水的中位數，
# 可以利用字典進行聚合操作的指定：

data.groupby('company').agg({'salary':'median','age':'mean'})

#          salary   age
# company              
# A            19  24.0
# B            26  33.0
# C            29  29.2

# 三、transform
# 在上面的 如果按照正常的步驟來計算，需要先求得不同公司的平均薪水，
# 然後按照員工和公司的對應關係填充到對應的位置
avg_salary_dict = data.groupby('company')['salary'].mean().to_dict()
avg_salary_dict 
# {'A': 34.5, 'B': 27.25, 'C': 31.285714285714285}

data['avg_salary01'] = data['company'].map(avg_salary_dict)
data
#    company  salary  age  avg_salary01
# 0        C      29   47     30.200000
# 1        A      19   24     18.000000
# 2        B      26   41     25.428571
# 3        B      33   18     25.428571
# 4        A      12   26     18.000000
# 5        A      23   22     18.000000
# 6        C      37   15     30.200000
# 7        B      11   39     25.428571
# 8        B      29   39     25.428571
# 9        B      23   19     25.428571
# 10       B       8   35     25.428571
# 11       B      48   40     25.428571
# 12       C      44   44     30.200000
# 13       C      23   20     30.200000
# 14       C      18   20     30.200000

# 如果使用transform
data['avg_salary'] = data.groupby('company')['salary'].transform('mean')
data
#    company  salary  age  avg_salary01  avg_salary
# 0        C      29   47     30.200000   30.200000
# 1        A      19   24     18.000000   18.000000
# 2        B      26   41     25.428571   25.428571
# 3        B      33   18     25.428571   25.428571
# 4        A      12   26     18.000000   18.000000
# 5        A      23   22     18.000000   18.000000
# 6        C      37   15     30.200000   30.200000
# 7        B      11   39     25.428571   25.428571
# 8        B      29   39     25.428571   25.428571
# 9        B      23   19     25.428571   25.428571
# 10       B       8   35     25.428571   25.428571
# 11       B      48   40     25.428571   25.428571
# 12       C      44   44     30.200000   30.200000
# 13       C      23   20     30.200000   30.200000
# 14       C      18   20     30.200000   30.200000

# 四、apply
# Suppose I now need to obtain the data of the oldest employee in each company, how can I achieve it? It can be implemented with the following code:
# 假設我現在需要獲取各個公司年齡最大的員工的數據，該怎麼實現呢？可以用以下代碼實現：
def get_oldest_staff(x):
     df = x.sort_values(by = 'age',ascending=True)
     return df.iloc[-1,:]

oldest_staff = data.groupby('company',as_index=False).apply(get_oldest_staff)
oldest_staff

#   company  salary  age  avg_salary01  avg_salary
# 0       A      12   26     18.000000   18.000000
# 1       B      26   41     25.428571   25.428571
# 2       C      29   47     30.200000   30.200000

# In[補充 Homework 04] 善用Pandas套件的Groupby與Aggregate方法提升資料解讀效率
# https://reurl.cc/831V1X
# Pandas套件篩選資料的常見語法應用，包含：

# 1. Pandas單一條件篩選資料
# 2. Pandas多條件篩選資料
# 3. Pandas篩選字串資料
# 利用Pandas套件的read_csv()方法(Method)來讀取，如下範例：
# Starbucks satisfactory survey.csv
#https://www.kaggle.com/mahirahmzh/starbucks-customer-retention-malaysia-survey

import pandas as pd
StarbucksDF = pd.read_csv(r'Starbucks satisfactory survey.csv')
print(StarbucksDF)

# 1. Pandas單一條件篩選資料
#假設，我們想要篩選出職業為學生的資料集，就可以像邏輯判斷式一樣，存取Job(職業)欄位，並且指定條件，
#接著，放入Pandas套件的loc[]語法中來進行篩選，如下範例：
StarbucksDF.columns
filt = (StarbucksDF['3. Are you currently....?'] == 'Student')
print(StarbucksDF[filt])

# In[] Transpose data frame 轉置資料框
conversion_rate_df.T
# conversion         0         1
# y           88.30152  11.69848

# In[] 2. Conversion Rates by Marital Status
conversion_rate_by_marital = df.groupby(
    by='marital')['conversion'].sum() / df.groupby(
    by='marital'
)['conversion'].count() * 100.0
        
conversion_rate_by_marital
# marital
# divorced    11.945458
# married     10.123466
# single      14.949179
# Name: conversion, dtype: float64

### 解析
conversion_rate_by_marital_sum = df.groupby(by = 'marital')['conversion'].sum()
print(conversion_rate_by_marital_sum)

conversion_rate_by_marital_count = df.groupby(by = 'marital')['conversion'].count()
print(conversion_rate_by_marital_count)

conversion_rate_by_marital_div = df.groupby(by = 'marital')['conversion'].sum() / df.groupby(by = 'marital')['conversion'].count()  
print(conversion_rate_by_marital_div)
### end of 解析

#Plot 1.
ax = conversion_rate_by_marital.plot(
    kind='bar',
    color='skyblue',
    grid=True,
    figsize=(10, 7),
    title='Conversion Rates by Marital Status'
)

ax.set_xlabel('Marital Status')
ax.set_ylabel('conversion rate (%)')

plt.show()

# In[] 3. Conversion Rates by Job
# 3. 不同職業類別轉換率
conversion_rate_by_job = df.groupby(
    by='job'
)['conversion'].sum() / df.groupby(
    by='job'
)['conversion'].count() * 100.0
    
conversion_rate_by_job

#Plot 2.
ax = conversion_rate_by_job.plot(
    kind='barh',
    color='skyblue',
    grid=True,
    figsize=(10, 7),
    title='Conversion Rates by Job'
)

ax.set_xlabel('conversion rate (%)')
ax.set_ylabel('Job')

plt.show()

conversion_rate_by_job

# In[] 4. Default Rates by Conversions
# 4. 訂閱與未訂閱定期存款之間的利率差異
default_by_conversion_df = pd.pivot_table(
    df, 
    values='y', 
    index='default', 
    columns='conversion', 
    aggfunc=len
)

default_by_conversion_df

list(default_by_conversion_df.columns)

default_by_conversion_df.columns = ['non_conversions', 'conversions']

list(default_by_conversion_df.columns)

default_by_conversion_df

#分析預設利率
#Plot 3.
default_by_conversion_df.plot(
    kind='pie',
    figsize=(15, 7),
    startangle=90,
    subplots=True,
    autopct=lambda x: '%0.1f%%' % x
)

plt.show()

# In[] 5. Bank Balance by Conversions
#Plot 3.
#箱形圖
ax = df[['conversion', 'balance']].boxplot(
    by='conversion',
    showfliers=True,
    figsize=(10, 7)
)

ax.set_xlabel('Conversion')
ax.set_ylabel('Average Bank Balance')
ax.set_title('Average Bank Balance Distributions by Conversion')

plt.suptitle("")
plt.show()

# In[]Plot 4. #排除離群值
ax = df[['conversion', 'balance']].boxplot(
    by='conversion',
    showfliers=False,  #排除離群值
    figsize=(10, 7)
)

ax.set_xlabel('Conversion')
ax.set_ylabel('Average Bank Balance')
ax.set_title('Average Bank Balance Distributions by Conversion')

plt.suptitle("")
plt.show()

# In[] 6. Conversions by Number of Contacts
conversions_by_num_contacts = df.groupby(
    by='campaign'
)['conversion'].sum() / df.groupby(
    by='campaign'
)['conversion'].count() * 100.0

conversions_by_num_contacts

type(conversions_by_num_contacts)
# pandas.core.series.Series

pd.DataFrame(conversions_by_num_contacts)
type(conversions_by_num_contacts)

# 聯絡次數與轉換率之間的影響
#Plot 5.
ax = conversions_by_num_contacts.plot(
    kind='bar',
    figsize=(10, 7),
    title='Conversion Rates by Number of Contacts',
    grid=True,
    color='skyblue'
)

ax.set_xlabel('Number of Contacts')
ax.set_ylabel('Conversion Rate (%)')

plt.show()

# In[] Decision Tree 1: how it works  >> please watch youtube video forst!
# https://youtu.be/eKD5gxPPeY0

# In[] 7. Encoding Categorical Variables 編碼分類變量
list(df.columns)

df.describe()

df.describe().columns

list(df.describe().columns)
# 連續型變數 欄位名稱

categorical_vars = [
    'job',
    'marital',
    'education',
    'default',
    'housing',
    'loan',
    'contact',
    'month'
]
# 類別變數

categorical_vars

# 取得不重複值 Get unique value
df['month'].unique()

months = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec']

months[0]

months[6]

months.index('jul')

months.index('jul') + 1

df['month'].head()

df['month'] = df['month'].apply(
    lambda x: months.index(x)+1
)

df['month'].head()

# 以數字將 month 的序列進行編碼 Encode the sequence of month as a number
df['month'].unique()

df.groupby('month').count()['conversion']

df['job'].unique()
list(df['job'].unique())

# 初學Python手記#3-資料前處理( Label encoding、 One hot encoding)
# 這兩個編碼方式的目的是為了將類別 (categorical)或是文字(text)的資料轉換成數字，
# 而讓程式能夠更好的去理解及運算。
# Label encoding : 把每個類別 mapping 到某個整數，不會增加新欄位
# One hot encoding : 為每個類別新增一個欄位，用 0/1 表示是否

# https://reurl.cc/Q7oqRM

# In[] 8. 建立虛擬變數 Create dummy variables
# One hot encoding : 為每個類別新增一個欄位，用 0/1 表示是否

jobs_encoded_df = pd.get_dummies(df['job']) #建立虛擬變數 Create dummy variables
jobs_encoded_df.head()

jobs_encoded_df.columns

['job_%s' % x for x in jobs_encoded_df.columns]

jobs_encoded_df.columns = ['job_%s' % x for x in jobs_encoded_df.columns]
jobs_encoded_df.head()

df = pd.concat([df, jobs_encoded_df], axis=1)
df.head()

# encoding 'marital'
marital_encoded_df = pd.get_dummies(df['marital'])
marital_encoded_df.columns = ['marital_%s' % x for x in marital_encoded_df.columns]

marital_encoded_df.head()

df = pd.concat([df, marital_encoded_df], axis=1)
df.head()

df['housing'].unique()

df['housing'] = df['housing'].apply(lambda x: 1 if x == 'yes' else 0)

df['loan'].unique()

df['loan'] = df['loan'].apply(lambda x: 1 if x == 'yes' else 0)

#說明是否負擔房貸與個人貸款 Indicate whether you can afford mortgages and personal loans

df['housing'].head()

## 投入變數 x , Input variable x
features = [
    'age',
    'balance',
    'campaign',
    'previous',
    'housing',
] + list(jobs_encoded_df.columns) + list(marital_encoded_df.columns)

features

## 目標變數 y , Target variable y
response_var = 'conversion'
response_var

### # 9. 決策樹 Decision tree Model
from sklearn import tree

dt_model = tree.DecisionTreeClassifier(
    max_depth=4
)

# 決策樹建模 x,y , Decision tree modeling x,y
dt_model.fit(df[features], df[response_var])

dt_model.classes_

# In[] 10. Interpreting Decision Tree Model
#conda install python-graphviz

import graphviz
#視覺化決策樹模型 Visual decision tree model
# ERROR >>> ModuleNotFoundError: No module named 'graphviz'
# please install >>> python-graphviz 請安裝 >>> python-graphviz
# conda install python-graphviz

dot_data = tree.export_graphviz(
    dt_model, 
    out_file=None, 
    feature_names=features,  
    class_names=['0', '1'],  
    filled=True, 
    rounded=True,  
    special_characters=True
) 

graph = graphviz.Source(dot_data)

from IPython.core.display import display, HTML
display(HTML("<style>text {font-size: 10px;}</style>"))

graph

# In[] 討論 discuss
# previous , housing, age , balance


# In[] Data Cleaning for Machine Learning for prediction of campaign outcome
# https://www.kaggle.com/aleksandradeis/bank-marketing-analysis

# In[] Decision Trees
# https://scikit-learn.org/stable/modules/tree.html
from sklearn.datasets import load_iris
from sklearn import tree
iris = load_iris()
X, y = iris.data, iris.target
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X, y)

tree.plot_tree(clf)


# In[]
import graphviz 
dot_data = tree.export_graphviz(clf, out_file=None) 
graph = graphviz.Source(dot_data) 
graph.render("iris") 

dot_data = tree.export_graphviz(clf, out_file=None, 
                     feature_names=iris.feature_names,  
                     class_names=iris.target_names,  
                     filled=True, rounded=True,  
                     special_characters=True)  
graph = graphviz.Source(dot_data)  
graph 

