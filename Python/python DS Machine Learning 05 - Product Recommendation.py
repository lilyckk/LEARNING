# In[1] Product Recommendation 產品推薦

"""ProductRecommendation.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1QC6klTD2XcmgG13gITsShII_avhsIc76
"""

# In[2]
import pandas as pd

Originaldf = pd.read_excel('OnlineRetail.xlsx')
df = Originaldf

df.columns
# Index(['InvoiceNo', 'StockCode', 'Description', 'Quantity', 'InvoiceDate',
#       'UnitPrice', 'CustomerID', 'Country'],
#      dtype='object')

"""
# Online Retail Data Set
# https://archive.ics.uci.edu/ml/datasets/online+retail
# Abstract: 
# This is a transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.

# 1. variables introduction

InvoiceNo(發票編號): Invoice number. Nominal, a 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c', it indicates a cancellation.
    
StockCode(產品編碼) Product (item) code. Nominal, a 5-digit integral number uniquely assigned to each distinct product.

Description(介紹): Product (item) name. Nominal.

Quantity(數量): The quantities of each product (item) per transaction(交易). Numeric.

InvoiceDate(發票日期): Invoice Date and time. Numeric, the day and time when each transaction was generated.

UnitPrice(單位價格): Unit price. Numeric, Product price per unit in sterling(英鎊).

CustomerID(顧客身分): Customer number. Nominal, a 5-digit integral number uniquely assigned to each customer.

Country(國家): Country name. Nominal, the name of the country where each customer resides.

"""

df.head()
#   InvoiceNo StockCode  ... CustomerID         Country
# 0    536365    85123A  ...    17850.0  United Kingdom
# 1    536365     71053  ...    17850.0  United Kingdom
# 2    536365    84406B  ...    17850.0  United Kingdom
# 3    536365    84029G  ...    17850.0  United Kingdom
# 4    536365    84029E  ...    17850.0  United Kingdom

# [5 rows x 8 columns]

df.shape
#(541909, 8)

df['Quantity'].describe()
# count    541909.000000
# mean          9.552250
# std         218.081158
# min      -80995.000000
# 25%           1.000000
# 50%           3.000000
# 75%          10.000000
# max       80995.000000
# Name: Quantity, dtype: float64

# Check if "Quantity" <= 0 or not?
df['Quantity'] <= 0
# 0         False
# 1         False
# 2         False
# 3         False
# 4         False
# ... 
# 541904    False
# 541905    False
# 541906    False
# 541907    False
# 541908    False

# Select the data which Quantity <= 0
df.loc[df['Quantity'] <= 0]
#        InvoiceNo StockCode  ... CustomerID         Country
# 141      C536379         D  ...    14527.0  United Kingdom
# 154      C536383    35004C  ...    15311.0  United Kingdom
# [10624 rows x 8 columns]

df[df['Quantity'] <= 0]
#        InvoiceNo StockCode  ... CustomerID         Country
# 141      C536379         D  ...    14527.0  United Kingdom
# 154      C536383    35004C  ...    15311.0  United Kingdom
# [10624 rows x 8 columns]

# Select the data which Quantity > 0
df[df['Quantity'] > 0]
#        InvoiceNo StockCode  ... CustomerID         Country
# 0         536365    85123A  ...    17850.0  United Kingdom
# 1         536365     71053  ...    17850.0  United Kingdom
# [531285 rows x 8 columns]


# In[3] loc() is used to filter the data where'Quantity'> 0
#      loc()用以篩選 'Quantity' > 0 的資料
df = df.loc[df['Quantity'] > 0]

df.shape
# (531285, 8)

Originaldf.shape
# (541909, 8)

Originaldf.shape[0] - df.shape[0]
# 10624
# We delete 10624 rows which the Quantity is less than 0.
# # 我們刪除數量小於 0 的 10624 列資料。

# In[4] Data Preparation 資料準備
"""# 2. Data Preparation
        資料準備
Handle NaNs in CustomerID field

處理CustomerID的NaN(空值)
"""
df.info()
# <class 'pandas.core.frame.DataFrame'>
# Int64Index: 531285 entries, 0 to 541908
# Data columns (total 8 columns):
#  #   Column       Non-Null Count   Dtype         
# ---  ------       --------------   -----         
#  0   InvoiceNo    531285 non-null  object        
#  1   StockCode    531285 non-null  object        
#  2   Description  530693 non-null  object    ****     
#  3   Quantity     531285 non-null  int64         
#  4   InvoiceDate  531285 non-null  datetime64[ns]
#  5   UnitPrice    531285 non-null  float64       
#  6   CustomerID   397924 non-null  float64    ****     
#  7   Country      531285 non-null  object        
# dtypes: datetime64[ns](1), float64(2), int64(1), object(4)
# memory usage: 36.5+ MB

df['CustomerID'].describe()
# count    397924.000000
# mean      15294.315171
# std        1713.169877
# min       12346.000000
# 25%       13969.000000
# 50%       15159.000000
# 75%       16795.000000
# max       18287.000000
# Name: CustomerID, dtype: float64

# isna() is used to detect the missing value and then sum up with sum(). Calculate how many records lack'CustomerID'
#isna()用以偵測闕漏值再以sum()加總。計算多少筆紀錄缺少'CustomerID'
df['CustomerID'].isna().sum()
# 133361

# Explain 解釋:
df['CustomerID'].isna()

df['CustomerID'].isna().sum()
# 133361

sum(df['CustomerID'].isna())
# 133361

# End of explain:

# In[5] Display data to exclude records that lack'CustomerID'   
#       顯示排除缺少'CustomerID'的紀錄的資料
df.loc[df['CustomerID'].isna()].head()

print(df.shape)
# (531285, 8)
#顯示排除缺少'CustomerID'的紀錄之前的資料

#dropna() is used to exclude records with missing values in the data frame
#subset Check for missing values in the specified column
#dropna()用以排除資料框中含有闕漏值的紀錄
#subset 在指定列中查看是否有闕漏值

df = df.dropna(subset=['CustomerID'])

print(df.shape)
# (397924, 8)

# #Display the data after excluding the record lacking'CustomerID'
#顯示排除缺少'CustomerID'的紀錄之後的資料

df['CustomerID'].describe()
# count    397924.000000
# mean      15294.315171
# std        1713.169877
# min       12346.000000
# 25%       13969.000000
# 50%       15159.000000
# 75%       16795.000000
# max       18287.000000
# Name: CustomerID, dtype: float64

df.astype({'CustomerID': 'int32'}).dtypes
# df.astype({'col1': 'int32'}).dtypes

# InvoiceNo              object
# StockCode              object
# Description            object
# Quantity                int64
# InvoiceDate    datetime64[ns]
# UnitPrice             float64
# CustomerID              int32
# Country                object
# dtype: object

df['CustomerID']
# 0         17850.0
# 1         17850.0
# 2         17850.0
# 3         17850.0
# 4         17850.0
  
# 541904    12680.0
# 541905    12680.0
# 541906    12680.0
# 541907    12680.0
# 541908    12680.0
# Name: CustomerID, Length: 397924, dtype: float64

# In[6] Customer-Item Matrix 客戶-項目矩陣
"""# - Customer-Item Matrix
pivot table  樞紐分析表
# pandas.pivot_table
# https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.pivot_table.html

customer_item_matrix = df.pivot_table(
    index='CustomerID', 
    columns='StockCode', 
    values='Quantity',
    aggfunc='sum'
)

index : 
必要參數。此處輸入不想要變動的數據，作為想要比較的欄位基礎，該數據會成為第一欄的索引（index），此處能以 list、array 等方式輸入多個 index，則結果會以巢狀的方式呈現。

values(可選) :
可以對需要計算的數據做篩選，如果以 list、array 等方式輸入多個 value，則能夠分別獲得該欄位的不同數值。

columns(可選) : 
用以分割數據，去選出想比較的特定欄位。

aggfunc : 
function 參數。是 Pivot Table 裡最厲害的功能，能夠引入 max、min 等內建參數，甚至能自訂 function 使用。
"""

# pivot table
# 樞紐分析表
customer_item_matrix = df.pivot_table(
    index='CustomerID', 
    columns='StockCode', 
    values='Quantity',
    aggfunc='sum'
)
customer_item_matrix
# StockCode   10002  10080  10120  10125  10133  ...  C2  DOT    M  PADS  POST
# CustomerID                                     ...                          
# 12346.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 12347.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 12348.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   9.0
# 12349.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   1.0
# 12350.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   1.0
#           ...    ...    ...    ...    ...  ...  ..  ...  ...   ...   ...
# 18280.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 18281.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 18282.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 18283.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  2.0   NaN   NaN
# 18287.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN

# [4339 rows x 3665 columns]

# In[7] How many unique customers in these transactions? 
#       這些交易中有多少唯一客戶？
df['CustomerID'].unique()
# array([17850., 13047., 12583., ..., 13298., 14569., 12713.])
len(df['CustomerID'].unique())
# 4339

# In[8] How many unique StockCode (product Code) in these transactions? 
#       這些交易中有多少獨特的產品代碼？
df['StockCode'].unique()
# array(['85123A', 71053, '84406B', ..., '90214Z', 90089, 23843],
#      dtype=object)
len(df['StockCode'].unique())
# 3665

### Can you explain the dimension of pivot table now?
## [4339 rows x 3665 columns]

# In[9] Use head() to indicate 5 records starting from 12481
#       以head()表示從12481開始的5筆資料
customer_item_matrix.loc[12481:].head()
# StockCode   10002  10080  10120  10125  10133  ...  C2  DOT   M  PADS  POST
# CustomerID                                     ...                         
# 12481.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN NaN   NaN  32.0
# 12483.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN NaN   NaN  16.0
# 12484.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN NaN   NaN  21.0
# 12488.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN NaN   NaN   3.0
# 12489.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN NaN   NaN   2.0

# [5 rows x 3665 columns]

customer_item_matrix.shape
# (4339, 3665)

# In[10] Calculate the unique value of each row  ## .nunique()   .unique()
#        計算每一行的唯一值
"""https://vimsky.com/zh-tw/examples/usage/python-pandas-dataframe-nunique.html"""

df['StockCode'].nunique()
# 3665
# Calculate the unique value of each row
# 計算每一行的唯一值

df['CustomerID'].nunique()
# 4339

# In[11] We may check the products which each customer buy?
#        我們可以檢查每個客戶購買的產品？
customer_item_matrix.loc[12481]

c12481 = customer_item_matrix.loc[12481]

c12484 = customer_item_matrix.loc[12484]

c12488 = customer_item_matrix.loc[12488]

customer_item_matrix.loc[12481].sum()
# 3304.0

# In[12] applymap()對資料框所有元素套用指定函數 lambda
#        applymap()對資料框所有元素套用指定函數

# 稀疏矩阵（sparse matrix）
# In numerical analysis and scientific computing, a sparse matrix or sparse array is a matrix in which most of the elements are zero.
# https://en.wikipedia.org/wiki/Sparse_matrix

# customer_item_matrix is a sparse matrix.
customer_item_matrix
# StockCode   10002  10080  10120  10125  10133  ...  C2  DOT    M  PADS  POST
# CustomerID                                     ...                          
# 12346.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 12347.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 12348.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   9.0
# 12349.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   1.0
# 12350.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   1.0
#           ...    ...    ...    ...    ...  ...  ..  ...  ...   ...   ...
# 18280.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 18281.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 18282.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN
# 18283.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  2.0   NaN   NaN
# 18287.0       NaN    NaN    NaN    NaN    NaN  ... NaN  NaN  NaN   NaN   NaN

# [4339 rows x 3665 columns]


# We encode the matrix data with 0, 1!
# 我們對矩陣資料以0, 1 編碼!
customer_item_matrix01 = customer_item_matrix.applymap(lambda x: 1 if x > 0 else 0)

customer_item_matrix01
# StockCode   10002  10080  10120  10125  10133  ...  C2  DOT  M  PADS  POST
# CustomerID                                     ...                        
# 12346.0         0      0      0      0      0  ...   0    0  0     0     0
# 12347.0         0      0      0      0      0  ...   0    0  0     0     0
# 12348.0         0      0      0      0      0  ...   0    0  0     0     1
# 12349.0         0      0      0      0      0  ...   0    0  0     0     1
# 12350.0         0      0      0      0      0  ...   0    0  0     0     1
#           ...    ...    ...    ...    ...  ...  ..  ... ..   ...   ...
# 18280.0         0      0      0      0      0  ...   0    0  0     0     0
# 18281.0         0      0      0      0      0  ...   0    0  0     0     0
# 18282.0         0      0      0      0      0  ...   0    0  0     0     0
# 18283.0         0      0      0      0      0  ...   0    0  1     0     0
# 18287.0         0      0      0      0      0  ...   0    0  0     0     0

# [4339 rows x 3665 columns]

customer_item_matrix01.loc[12481:].head()
# StockCode   10002  10080  10120  10125  10133  ...  C2  DOT  M  PADS  POST
# CustomerID                                     ...                        
# 12481.0         0      0      0      0      0  ...   0    0  0     0     1
# 12483.0         0      0      0      0      0  ...   0    0  0     0     1
# 12484.0         0      0      0      0      0  ...   0    0  0     0     1
# 12488.0         0      0      0      0      0  ...   0    0  0     0     1
# 12489.0         0      0      0      0      0  ...   0    0  0     0     1

# [5 rows x 3665 columns]

# In[13] What does the following instructions mean?
#        下面的指令是什麼意思？
customer_item_matrix01.loc[12481].sum()
# 150

customer_item_matrix.loc[12481].sum()
# 3304.0

# In[]  Homework01  以上兩個指令代表什麼意思請回答？


# In[] Homework02  這樣今天老師講的所有程式碼到 405 行 在Colab 上面去做執行?

# In[14] Collaborative Filtering 協同過濾法
"""# 3. Collaborative Filtering 協同過濾法"""
# https://en.wikipedia.org/wiki/Collaborative_filtering
# Collaborative filtering is a method of making automatic predictions (filtering) about the interests of a user by collecting preferences or taste information from many users (collaborating).

# https://ithelp.ithome.com.tw/articles/10219511
# 協同過濾(Collaborative Filtering)，協同就是集合眾人的意見協同合作，進而篩選或推薦商品，作法與購物籃分析類似，一樣是以銷售記錄進行分析，不同的是，並不進行商品組合分析，而是將銷售記錄轉成『使用者/商品對應的矩陣』(User-Item Matrix)
# 1. USER-USER Collaborative Filtering: Convert to the most similar customer group (USER-USER Similarity Matrix), check the products they frequently buy, and recommend them to the currently locked customers.
# 1. USER-USER 協同過濾：轉換為最相似的顧客族群(USER-USER Similarity Matrix)，查看他們經常購買的商品，推薦給目前鎖定的顧客。

# 2. ITEM-ITEM Collaborative Filtering: Find out the product group (ITEM-ITEM Similarity Matrix) that is most similar to the currently viewed product and recommend it to customers. Which products are often bought together?
# 2. ITEM-ITEM 協同過濾：找出與目前瀏覽的商品最相似的商品族群(ITEM-ITEM Similarity Matrix)，推薦給顧客。哪些商品經常被一起購買?

from sklearn.metrics.pairwise import cosine_similarity

# In[15] User-based Collaborative Filtering  使用者導向的協同過濾法
### 3.1. User-based Collaborative Filtering
### 3.1. 使用者導向的協同過濾法

##### - User-to-User Cosine Similarity Matrix
##### - 使用者之間的餘弦相似度
# 1. USER-USER Collaborative Filtering: Convert to the most similar customer group (USER-USER Similarity Matrix), check the products they frequently buy, and recommend them to the currently locked customers.
# 1. USER-USER 協同過濾：轉換為最相似的顧客族群(USER-USER Similarity Matrix)，查看他們經常購買的商品，推薦給目前鎖定的顧客。

# Cosine Similarity – Understanding the math and how it works (with python codes)
# https://www.machinelearningplus.com/nlp/cosine-similarity/

# Cosine similarity is a metric used to measure how similar the documents are irrespective of their size. Mathematically, it measures the cosine of the angle between two vectors projected in a multi-dimensional space. The cosine similarity is advantageous because even if the two similar documents are far apart by the Euclidean distance (due to the size of the document), chances are they may still be oriented closer together. The smaller the angle, higher the cosine similarity.
# 餘弦相似度是一種度量標準，用於衡量文檔的相似程度，而不管其大小。 在數學上，它測量投影在多維空間中的兩個向量之間夾角的餘弦。 餘弦相似度是有利的，因為即使兩個相似的文檔相距很遠（由於文檔的大小），它們仍有可能靠得更近。 角度越小，餘弦相似度越高。

user_user_sim_matrix = pd.DataFrame(
    cosine_similarity(customer_item_matrix01)
)
user_user_sim_matrix.head()
#    0         1         2         3     ...  4335      4336      4337      4338
# 0   1.0  0.000000  0.000000  0.000000  ...   0.0  0.000000  0.000000  0.000000
# 1   0.0  1.000000  0.063022  0.046130  ...   0.0  0.113776  0.109364  0.012828
# 2   0.0  0.063022  1.000000  0.024953  ...   0.0  0.000000  0.170905  0.083269
# 3   0.0  0.046130  0.024953  1.000000  ...   0.0  0.067574  0.137124  0.030475
# 4   0.0  0.047795  0.051709  0.056773  ...   0.0  0.000000  0.044866  0.000000

# [5 rows x 4339 columns]
user_user_sim_matrix.tail()
#       0         1         2         3     ...      4335    4336      4337      4338
# 4334   0.0  0.062318  0.000000  0.000000  ...  0.119523  0.0000  0.000000  0.000000
# 4335   0.0  0.000000  0.000000  0.000000  ...  1.000000  0.0000  0.046613  0.000000
# 4336   0.0  0.113776  0.000000  0.067574  ...  0.000000  1.0000  0.017800  0.000000
# 4337   0.0  0.109364  0.170905  0.137124  ...  0.046613  0.0178  1.000000  0.096334
# 4338   0.0  0.012828  0.083269  0.030475  ...  0.000000  0.0000  0.096334  1.000000

# [5 rows x 4339 columns]

user_user_sim_matrix.shape
#  (4339, 4339)

# In[16] Change with CustomerID in user_user_sim_matrix
#        更改 user_user_sim_matrix 中的 CustomerID

user_user_sim_matrix.columns = customer_item_matrix.index

user_user_sim_matrix['CustomerID'] = customer_item_matrix.index
user_user_sim_matrix = user_user_sim_matrix.set_index('CustomerID')

user_user_sim_matrix.head()
# CustomerID  12346.0   12347.0   12348.0  ...   18282.0   18283.0   18287.0
# CustomerID                               ...                              
# 12346.0         1.0  0.000000  0.000000  ...  0.000000  0.000000  0.000000
# 12347.0         0.0  1.000000  0.063022  ...  0.113776  0.109364  0.012828
# 12348.0         0.0  0.063022* 1.000000  ...  0.000000  0.170905  0.083269
# 12349.0         0.0  0.046130* 0.024953  ...  0.067574  0.137124  0.030475
# 12350.0         0.0  0.047795  0.051709  ...  0.000000  0.044866  0.000000

# [5 rows x 4339 columns]

### Similarity for 12346.0 itself is 1.0
### Similarity (12347, 12348) is 0.063022 which is better than the Similarity (12347, 12349) is 0.046130.
### 相似度 (12347, 12348) 為 0.063022，這比相似度 (12347, 12349) 為 0.046130 更好。

user_user_sim_matrix.tail()
# CustomerID  12346.0   12347.0   12348.0  ...  18282.0   18283.0   18287.0
# CustomerID                               ...                             
# 18280.0         0.0  0.062318  0.000000  ...   0.0000  0.000000  0.000000
# 18281.0         0.0  0.000000  0.000000  ...   0.0000  0.046613  0.000000
# 18282.0         0.0  0.113776  0.000000  ...   1.0000  0.017800  0.000000
# 18283.0         0.0  0.109364  0.170905  ...   0.0178  1.000000  0.096334
# 18287.0         0.0  0.012828  0.083269  ...   0.0000  0.096334  1.000000

# [5 rows x 4339 columns]

# In[17] Making Recommendations for products 為產品做推薦
"""# 4.- Making Recommendations"""

# Take 12350 customers as an example to find and sort customer IDs with Similarity
# 以12350一個顧客做為範例找出並排序顧客ID 相似餘弦
user_user_sim_matrix.loc[12350.0]
# CustomerID
# 12346.0    0.000000
# 12347.0    0.047795
# 12348.0    0.051709
# 12349.0    0.056773
# 12350.0    1.000000

user_user_sim_matrix.loc[12350.0].sort_values(ascending=False)
# CustomerID
# 12350.0    1.000000
# 17935.0    0.183340
# 12414.0    0.181902
# 12652.0    0.175035
# 16692.0    0.171499
  
# 14885.0    0.000000
# 14886.0    0.000000
# 14887.0    0.000000
# 14888.0    0.000000
# 18287.0    0.000000
# Name: 12350.0, Length: 4339, dtype: float64


user_user_sim_matrix.loc[12350.0].sort_values(ascending=False).head(11)
# CustomerID
# 12350.0    1.000000
# 17935.0    0.183340
# 12414.0    0.181902
# 12652.0    0.175035
# 16692.0    0.171499
# 12791.0    0.171499
# 16754.0    0.171499
# 12814.0    0.171499
# 16426.0    0.166968
# 16333.0    0.161690
# 12475.0    0.161690
# Name: 12350.0, dtype: float64

# In[18]
# sort()用以對資料加以排序  
# ascending() --> 升/降序排序 True=升序 False=降序,默認值為True

# In[19]
import numpy as np 
series = pd.Series(customer_item_matrix01.loc[12350.0])
series
# StockCode
# 10002    0
# 10080    0
# 10120    0
# 10125    0
# 10133    0
#         ..
# C2       0
# DOT      0
# M        0
# PADS     0
# POST     1
# Name: 12350.0, Length: 3665, dtype: int64


result = series.to_numpy().nonzero()
result
# (array([  43,   49,  324,  749,  762,  764,  801,  807, 1153, 1207, 1337,
#        1342, 1403, 3047, 3060, 3092, 3664], dtype=int64),)

# In[20] iloc()以第n筆來選擇資料   
# iloc()以第n筆來選擇資料
items_bought_by_A = set(customer_item_matrix01.loc[12350.0].iloc[
    customer_item_matrix01.loc[12350.0].to_numpy().nonzero()
].index)
items_bought_by_A
# {20615,
#  20652,
#  21171,
#  21832,
#  21864,
#  21866,
#  21908,
#  21915,
#  22348,
#  22412,
#  22551,
#  22557,
#  22620,
#  '79066K',
#  '79191C',
#  '84086C',
#  'POST'}

items_bought_by_B = set(customer_item_matrix01.loc[17935.0].iloc[
    customer_item_matrix01.loc[17935.0].to_numpy().nonzero()
].index)
items_bought_by_B
# {20657,
#  20659,
#  20828,
#  20856,
#  21051,
#  21866,
#  21867,
#  22208,
#  22209,
#  22210,
#  22211,
#  22449,
#  22450,
#  22551,
#  22553,
#  22557,
#  22640,
#  22659,
#  22749,
#  22752,
#  22753,
#  22754,
#  22755,
#  23290,
#  23292,
#  23309,
#  '85099B',
#  'POST'}

# In[21]
#找出顧客12350.0曾買過，而顧客17935.0未曾買過的商品推薦給顧客17935.0
items_to_recommend_to_B = items_bought_by_A - items_bought_by_B

items_to_recommend_to_B
# {20615,
#  20652,
#  21171,
#  21832,
#  21864,
#  21908,
#  21915,
#  22348,
#  22412,
#  22620,
#  '79066K',
#  '79191C',
#  '84086C'}


df.loc[
    df['StockCode'].isin(items_to_recommend_to_B), 
    ['StockCode', 'Description']
].drop_duplicates().set_index('StockCode')
#                                Description
# StockCode                                 
# 21832                 CHOCOLATE CALCULATOR
# 21915               RED  HARMONICA IN BOX 
# 22620          4 TRADITIONAL SPINNING TOPS
# 79066K                      RETRO MOD TRAY
# 21864      UNION JACK FLAG PASSPORT COVER 
# 79191C         RETRO PLASTIC ELEPHANT TRAY
# 21908        CHOCOLATE THIS WAY METAL SIGN
# 20615         BLUE POLKADOT PASSPORT COVER
# 20652           BLUE POLKADOT LUGGAGE TAG 
# 22348          TEA BAG PLATE RED RETROSPOT
# 22412      METAL SIGN NEIGHBOURHOOD WITCH 
# 21171                 BATHROOM METAL SIGN 
# 84086C             PINK/PURPLE RETRO RADIO


#isin() --> 接受一個列表，判斷該列中元素是否在列表中。可同時對多列使用

"""https://codertw.com/%E7%A8%8B%E5%BC%8F%E8%AA%9E%E8%A8%80/555515/

drop_duplicates() --> 除去重複的值

set() --> 創建集合


# 3.2. Item-based Collaborative Filtering
 產品導向協同過濾

 Item-to-Item Similarity Matrix
 產品間的餘弦相似度
"""

# In[] Item-based Collaborative Filtering
item_item_sim_matrix = pd.DataFrame(cosine_similarity(customer_item_matrix01.T))

item_item_sim_matrix.columns = customer_item_matrix01.T.index

item_item_sim_matrix['StockCode'] = customer_item_matrix01.T.index
item_item_sim_matrix = item_item_sim_matrix.set_index('StockCode')

item_item_sim_matrix
# StockCode     10002     10080     10120  ...         M      PADS      POST
# StockCode                                ...                              
# 10002      1.000000  0.000000  0.094868  ...  0.066915  0.000000  0.078217
# 10080      0.000000  1.000000  0.000000  ...  0.016182  0.000000  0.000000
# 10120      0.094868  0.000000  1.000000  ...  0.070535  0.000000  0.010993
# 10125      0.090351  0.032774  0.057143  ...  0.070535  0.000000  0.070669
# 10133      0.062932  0.045655  0.059702  ...  0.070185  0.049752  0.021877
#             ...       ...       ...  ...       ...       ...       ...
# C2         0.029361  0.000000  0.000000  ...  0.026196  0.000000  0.020413
# DOT        0.000000  0.000000  0.000000  ...  0.000000  0.000000  0.000000
# M          0.066915  0.016182  0.070535  ...  1.000000  0.000000  0.077539
# PADS       0.000000  0.000000  0.000000  ...  0.000000  1.000000  0.000000
# POST       0.078217  0.000000  0.010993  ...  0.077539  0.000000  1.000000

# [3665 rows x 3665 columns]

# In[] Making Recommendations
"""# 4.- Making Recommendations
##### - 建立推薦清單
"""

#依照餘弦相似度排序而非商品代號
top_10_similar_items = list(
    item_item_sim_matrix\
        .loc[23166]\
        .sort_values(ascending=False)\
        .iloc[:10]\
    .index
)
# '\'  --> 續行符號

top_10_similar_items
# [23166, 23165, 23167, 22993, 23307, 22722, 22720, 22666, 23243, 22961]
 
df.loc[
    df['StockCode'].isin(top_10_similar_items), 
    ['StockCode', 'Description']
    ].drop_duplicates().set_index('StockCode').loc[top_10_similar_items]

#                                    Description
# StockCode                                     
# 23166           MEDIUM CERAMIC TOP STORAGE JAR
# 23165            LARGE CERAMIC TOP STORAGE JAR
# 23167           SMALL CERAMIC TOP STORAGE JAR 
# 22993             SET OF 4 PANTRY JELLY MOULDS
# 23307      SET OF 60 PANTRY DESIGN CAKE CASES 
# 22722        SET OF 6 SPICE TINS PANTRY DESIGN
# 22720        SET OF 3 CAKE TINS PANTRY DESIGN 
# 22666          RECIPE BOX PANTRY YELLOW DESIGN
# 23243      SET OF TEA COFFEE SUGAR TINS PANTRY
# 22961                   JAM MAKING SET PRINTED
