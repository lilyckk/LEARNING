# In[1] Customer Behaviors 消費者行為的探索式分析

## 1.載入資料 ##
import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv('./DSdata/WA_Fn-UseC_-Marketing-Customer-Value-Analysis.csv')

'''
IBM Watson Marketing Customer Value Data
IBM Watson Analytics
# https://www.kaggle.com/pankajjsh06/ibm-watson-marketing-customer-value-data/code
Context
Using Watson Analytics, you can predict behavior to retain your customers. 
You can analyze all relevant customer data and develop focused customer retention programs.

Inspiration
Understand customer demographics and buying behavior. 
Use predictive analytics to analyze the most profitable customers and how they interact. Take targeted actions to increase profitable customer response, retention, and growth.
語境
使用 Watson Analytics，您可以預測行為以留住客戶。 
您可以分析所有相關的客戶數據並製定有針對性的客戶保留計劃。

靈感
了解客戶人口統計和購買行為。 
使用預測分析來分析最有利可圖的客戶及其互動方式。 採取有針對性的行動來提高可盈利的客戶響應、保留和增長。
'''

df.shape
# (9134, 24)
df.head()  ##顯示前五筆資料
#   Customer       State  ...  Vehicle Class Vehicle Size
# 0  BU79786  Washington  ...   Two-Door Car      Medsize
# 1  QZ44356     Arizona  ...  Four-Door Car      Medsize
# 2  AI49188      Nevada  ...   Two-Door Car      Medsize
# 3  WW63253  California  ...            SUV      Medsize
# 4  HB64268  Washington  ...  Four-Door Car      Medsize

# [5 rows x 24 columns]

list(df.columns)
# ['Customer',
#  'State',
#  'Customer Lifetime Value',
#  'Response',
#  'Coverage',
#  'Education',
#  'Effective To Date',
#  'EmploymentStatus',
#  'Gender',
#  'Income',
#  'Location Code',
#  'Marital Status',
#  'Monthly Premium Auto',
#  'Months Since Last Claim',
#  'Months Since Policy Inception',
#  'Number of Open Complaints',
#  'Number of Policies',
#  'Policy Type',
#  'Policy',
#  'Renew Offer Type',
#  'Sales Channel',
#  'Total Claim Amount',
#  'Vehicle Class',
#  'Vehicle Size']

'''
＃ '顧客'，
＃  '狀態'，
# '客戶終身價值',
＃  '回复'，
# '覆蓋',
＃  '教育'，
# '至今有效',
＃  '就業狀況'，
＃  '性別'，
＃  '收入'，
# '位置代碼',
＃  '婚姻狀況'，
# “每月高級汽車”，
# '自上次索賠以來的幾個月'，
# '政策制定後的幾個月'，
# '公開投訴的數量',
# '政策數量',
# '政策類型',
＃  '政策'，
# '更新優惠類型',
# '銷售渠道',
# '索賠總額',
# '車輛等級',
#'車輛尺寸'
'''

df.info()
# <class 'pandas.core.frame.DataFrame'>
# RangeIndex: 9134 entries, 0 to 9133
# Data columns (total 24 columns):
#  #   Column                         Non-Null Count  Dtype  
# ---  ------                         --------------  -----  
#  0   Customer                       9134 non-null   object 
#  1   State                          9134 non-null   object 
#  2   Customer Lifetime Value        9134 non-null   float64 *
#  3   Response                       9134 non-null   object   *****
#  4   Coverage                       9134 non-null   object 
#  5   Education                      9134 non-null   object 
#  6   Effective To Date              9134 non-null   object 
#  7   EmploymentStatus               9134 non-null   object 
#  8   Gender                         9134 non-null   object 
#  9   Income                         9134 non-null   int64   *
#  10  Location Code                  9134 non-null   object 
#  11  Marital Status                 9134 non-null   object 
#  12  Monthly Premium Auto           9134 non-null   int64   *  
#  13  Months Since Last Claim        9134 non-null   int64   *  
#  14  Months Since Policy Inception  9134 non-null   int64   *  
#  15  Number of Open Complaints      9134 non-null   int64   *  
#  16  Number of Policies             9134 non-null   int64   *  
#  17  Policy Type                    9134 non-null   object 
#  18  Policy                         9134 non-null   object 
#  19  Renew Offer Type               9134 non-null   object 
#  20  Sales Channel                  9134 non-null   object 
#  21  Total Claim Amount             9134 non-null   float64   *
#  22  Vehicle Class                  9134 non-null   object 
#  23  Vehicle Size                   9134 non-null   object 
# dtypes: float64(2), int64(6), object(16)
# memory usage: 1.7+ MB

# In[2] Analyze participating customers 對參與客戶進行分析 ##
## 1. Overall participation rate 整體參與率
## 2. Participation rate by offer type 按優惠類型的參與率 
## 3. Participation rate by discount type and vehicle class按優惠類型與車輛等級的參與率 

## 1. Overall participation rate 整體參與率 >>> Response ##
df.groupby('Response').count()
#           Customer  State  ...  Vehicle Class  Vehicle Size
# Response                   ...                             
# No            7826   7826  ...           7826          7826
# Yes           1308   1308  ...           1308          1308

# [2 rows x 23 columns]

df.groupby('Response').mean()
#           Customer Lifetime Value  ...  Total Claim Amount
# Response                           ...                    
# No                    8030.022305  ...          432.084497
# Yes                   7854.871361  ...          446.080868

# [2 rows x 8 columns]

df["Response"].unique()
#  array(['No', 'Yes'], dtype=object)
df["Response"].nunique()
# 2

df["Sales Channel"].unique()
# array(['Agent', 'Call Center', 'Web', 'Branch'], dtype=object)
df["Sales Channel"].nunique()
# 4

### Just select the Customer field 僅選擇 Customer 欄位即可
df.groupby('Response').count()['Customer']
# Response
# No     7826
# Yes    1308
# Name: Customer, dtype: int64

# In[2.1] Plot Marketing Engagment bar chart
#         繪製營銷參與條形圖
ax = df.groupby('Response').count()['Customer'].plot(
    kind='bar',
    color='skyblue',
    grid=True,
    figsize=(10, 7),
    title='Marketing Engagment'
)

ax.set_xlabel('Engaged')
ax.set_ylabel('Count')

plt.show()

# In[3] Shows the percentage of customers who responded to marketing calls
#       以百分比呈現回應行銷電話的客戶人數比
df.shape[0]
# 9134

# Shows the percentage of customers who responded to marketing calls  
# 以百分比呈現回應行銷電話的客戶人數比
df.groupby('Response').count()['Customer']/df.shape[0]
# Response
# No     0.856799
# Yes    0.143201
# Name: Customer, dtype: float64

# In[4]  Participation rate by offer type 按優惠類型的參與率 ##
## 2.  Participation rate by offer type 按優惠類型的參與率 
by_offer_type_df = df.loc[
    df['Response'] == 'Yes'
].groupby([
    'Renew Offer Type'
]).count()['Customer']/df.groupby('Renew Offer Type').count()['Customer']

by_offer_type_df
# Renew Offer Type
# Offer1    0.158316
# Offer2    0.233766
# Offer3    0.020950
# Offer4         NaN
# Name: Customer, dtype: float64

## EXplain:
## Participation rate by offer type with 'Response' == 'Yes'
df.loc[df['Response'] == 'Yes']
#      Customer       State  ...  Vehicle Class Vehicle Size
# 5     OC83172      Oregon  ...   Two-Door Car      Medsize
# 6     XZ87318      Oregon  ...  Four-Door Car      Medsize
# 8     DY87989      Oregon  ...  Four-Door Car      Medsize
# 13    SJ95423     Arizona  ...            SUV      Medsize
# 22    YH23384     Arizona  ...  Four-Door Car      Medsize
#       ...         ...  ...            ...          ...
# 9110  RA89822  California  ...     Sports Car      Medsize
# 9119  YX35990  California  ...  Four-Door Car        Small
# 9122  FH43628  California  ...  Four-Door Car        Small
# 9123  WZ45103  California  ...  Four-Door Car        Small
# 9130  PK87824  California  ...  Four-Door Car      Medsize

# [1308 rows x 24 columns]

df.loc[df['Response'] == 'Yes'].groupby(['Renew Offer Type']).count()
#                   Customer  State  ...  Vehicle Class  Vehicle Size
# Renew Offer Type                   ...                             
# Offer1                 594    594  ...            594           594
# Offer2                 684    684  ...            684           684
# Offer3                  30     30  ...             30            30
# [3 rows x 23 columns]

df.loc[df['Response'] == 'Yes'].groupby(['Renew Offer Type']).count()['Customer']
# Renew Offer Type
# Offer1    594
# Offer2    684
# Offer3     30
# Name: Customer, dtype: int64

df.groupby('Renew Offer Type').count()['Customer']
# Renew Offer Type
# Offer1    3752
# Offer2    2926
# Offer3    1432
# Offer4    1024
# Name: Customer, dtype: int64

df.loc[df['Response'] == 'No'].groupby(['Renew Offer Type']).count()
#                   Customer  State  ...  Vehicle Class  Vehicle Size
# Renew Offer Type                   ...                             
# Offer1                3158   3158  ...           3158          3158
# Offer2                2242   2242  ...           2242          2242
# Offer3                1402   1402  ...           1402          1402
# Offer4                1024   1024  ...           1024          1024

# [4 rows x 23 columns]

df['Renew Offer Type'].unique()  
# array(['Offer1', 'Offer3', 'Offer2', 'Offer4'], dtype=object)

## End of EXplain:

# In[5] Plot Engagement Rate (%) using by_offer_type_df 
by_offer_type_df
# Renew Offer Type
# Offer1    0.158316
# Offer2    0.233766
# Offer3    0.020950
# Offer4         NaN
# Name: Customer, dtype: float64

ax = (by_offer_type_df * 100.0).plot(
    kind='bar',
    figsize=(7, 7),
    color='skyblue',
    grid=True
)

ax.set_ylabel('Engagement Rate (%)')
plt.show() 

# Can you describe the diagram? 你能描述一下圖表嗎？

# In[6] Participation rate by discount type and vehicle class
## 3. Participation rate by discount type and vehicle class 
## 3. 按優惠類型 與 車輛等級的參與率 

df['Renew Offer Type'].unique()
# array(['Offer1', 'Offer3', 'Offer2', 'Offer4'], dtype=object)
df['Vehicle Class'].unique()
# array(['Two-Door Car', 'Four-Door Car', 'SUV', 'Luxury SUV', 'Sports Car',
#       'Luxury Car'], dtype=object)
df['Renew Offer Type'].nunique()
# 4
df['Vehicle Class'].nunique()
# 6
        
by_offer_type_df = df.loc[
    df['Response'] == 'Yes'
].groupby([
    'Renew Offer Type', 'Vehicle Class'
]).count()['Customer']/df.groupby('Renew Offer Type').count()['Customer']

by_offer_type_df
# Renew Offer Type  Vehicle Class
# Offer1            Four-Door Car    0.070362
#                   Luxury Car       0.001599
#                   Luxury SUV       0.004797
#                   SUV              0.044776
#                   Sports Car       0.011194
#                   Two-Door Car     0.025586
# Offer2            Four-Door Car    0.114833
#                   Luxury Car       0.002051
#                   Luxury SUV       0.004101
#                   SUV              0.041012
#                   Sports Car       0.016405
#                   Two-Door Car     0.055366
# Offer3            Four-Door Car    0.016760
#                   Two-Door Car     0.004190
# Name: Customer, dtype: float64


# In[7] The following is easy to read and use unstack() for pivot analysis
#      以下為方便閱讀使用 unstack() 進行樞紐分析 ###
by_offer_type_df = by_offer_type_df.unstack().fillna(0)
by_offer_type_df
# Vehicle Class     Four-Door Car  Luxury Car  ...  Sports Car  Two-Door Car
# Renew Offer Type                             ...                          
# Offer1                 0.070362    0.001599  ...    0.011194      0.025586
# Offer2                 0.114833    0.002051  ...    0.016405      0.055366
# Offer3                 0.016760    0.000000  ...    0.000000      0.004190

# [3 rows x 6 columns]

# After pivot analysis using unstack(), Vehicle Class is converted into field data
# 使用 unstack() 進行樞紐分析後 Vehicle Class 轉成欄位資料。

# In[8] Polt Engagement Rate (%) with Renew Offer Type and Vehicle Class 
#      使用續訂報價類型和車輛類別繪製參與率 (%)

ax = (by_offer_type_df * 100.0).plot(
    kind='bar',
    figsize=(10, 7),
    grid=True
)

ax.set_ylabel('Engagement Rate (%)')

plt.show()

# In[9] Discussion about Renewal offer type and vehicle category drawing participation rate
# 討論續訂報價類型和車輛類別繪製參與率 (%):

# In[10] 按銷售渠道的參與率 ##
by_sales_channel_df = df.loc[
    df['Response'] == 'Yes'
].groupby([
    'Sales Channel'
]).count()['Customer']/df.groupby('Sales Channel').count()['Customer']

by_sales_channel_df

ax = (by_sales_channel_df*100.0).plot(
    kind='bar',
    figsize=(7, 7),
    color='skyblue',
    grid=True
)

ax.set_ylabel('Engagement Rate (%)')

plt.show()

##按銷售渠道與車輛大小的參與率 ##
by_sales_channel_df = df.loc[
    df['Response'] == 'Yes'
].groupby([
    'Sales Channel', 'Vehicle Size'
]).count()['Customer']/df.groupby('Sales Channel').count()['Customer']

by_sales_channel_df

by_sales_channel_df = by_sales_channel_df.unstack().fillna(0) ##一樣使用了樞紐分析
by_sales_channel_df

ax = (by_sales_channel_df*100.0).plot(
    kind='bar',
    figsize=(10, 7),
    grid=True
)

ax.set_ylabel('Engagement Rate (%)')

plt.show()

## 按照保單開始月份的參與率 ##
by_months_since_inception_df = df.loc[
    df['Response'] == 'Yes'
].groupby(
    by='Months Since Policy Inception'
)['Response'].count() / df.groupby(
    by='Months Since Policy Inception'
)['Response'].count() * 100.0

by_months_since_inception_df.fillna(0)


ax = by_months_since_inception_df.fillna(0).plot(
    figsize=(10, 7),
    title='Engagement Rates by Months Since Inception',
    grid=True,
    color='skyblue'
)

ax.set_xlabel('Months Since Policy Inception')
ax.set_ylabel('Engagement Rate (%)')

plt.show()

## 3.區隔消費者群體 
df['Customer Lifetime Value']

df['CLV Segment'] = df['Customer Lifetime Value'].apply(
    lambda x: 'High' if x > df['Customer Lifetime Value'].median() else 'Low' 
) ##將高於平均值的顧客定義為高CLV顧客，低於平均值的定義為低CLV顧客
df['Months Since Policy Inception'].describe()

df['Policy Age Segment'] = df['Months Since Policy Inception'].apply(
    lambda x: 'High' if x > df['Months Since Policy Inception'].median() else 'Low'
) ##同理將高於及低於Months Since Policy Inception平均值的顧客給予定義

ax = df.loc[
    (df['CLV Segment'] == 'High') & (df['Policy Age Segment'] == 'High')
].plot.scatter(
    x='Months Since Policy Inception',
    y='Customer Lifetime Value',
    logy=True,
    color='red'
)

df.loc[
    (df['CLV Segment'] == 'Low') & (df['Policy Age Segment'] == 'High')
].plot.scatter(
    ax=ax,
    x='Months Since Policy Inception',
    y='Customer Lifetime Value',
    logy=True,
    color='blue'
)

df.loc[
    (df['CLV Segment'] == 'High') & (df['Policy Age Segment'] == 'Low')
].plot.scatter(
    ax=ax,
    x='Months Since Policy Inception',
    y='Customer Lifetime Value',
    logy=True,
    color='orange'
)

df.loc[
    (df['CLV Segment'] == 'Low') & (df['Policy Age Segment'] == 'Low')
].plot.scatter(
    ax=ax,
    x='Months Since Policy Inception',
    y='Customer Lifetime Value',
    logy=True,
    color='green',
    grid=True,
    figsize=(10, 7)
)

ax.set_ylabel('CLV (in log scale)')
ax.set_xlabel('Months Since Policy Inception')

ax.set_title('Segments by CLV and Policy Age')

plt.show()

## 按CLV Segment和Policy Age Segment兩個新建欄位對資料進行分組 ##
engagment_rates_by_segment_df = df.loc[
    df['Response'] == 'Yes'
].groupby(
    ['CLV Segment', 'Policy Age Segment']
).count()['Customer']/df.groupby(
    ['CLV Segment', 'Policy Age Segment']
).count()['Customer']

engagment_rates_by_segment_df

ax = (engagment_rates_by_segment_df.unstack()*100.0).plot(
    kind='bar',
    figsize=(10, 7),
    grid=True
)

ax.set_ylabel('Engagement Rate (%)')
ax.set_title('Engagement Rates by Customer Segments')

plt.show()