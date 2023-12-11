### 1.0 簡單迴歸分析並繪製散佈圖 氣溫與冰品銷售金額-------
# lm 為 基本擴展行包的函數，無需另行安裝

# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

# 讀取測試資料IceSale_1.xlsx，氣溫與冰品銷售金額
# sheetIndex 指定工作表序號、as.data.frame 轉成數據框、header 指出是否有標題
# 若有中文資料，務必使用encoding參數指定編碼，例如UTF-8（必須大寫）
M01=read.xlsx("IceSale_1.xlsx",sheetIndex=1,as.data.frame=T,
              header=T,encoding="UTF-8")

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，因變數在前，自變數在後
# 第二個參數使用data關鍵字指定資料來源，本例為M01數據框
# 數據框後接中括號可指定所需的欄位序號，若為負數，則為排除之意
# RES_01=lm(冰品銷售額~氣溫,data=M01[,-1])
# 分析結果存入串列物件RES_01
RES_01 = lm(冰品銷售額 ~ 氣溫, data = M01)

# 顯示分析結果（截距及斜率）
RES_01
# Call:
# lm(formula = 冰品銷售額 ~ 氣溫, data = M01)
# 
# Coefficients:
# (Intercept)         氣溫  
#     -1.4336       0.1364  

# 顯示分析結果（迴歸統計量）
summary(RES_01)
# Call:
# lm(formula = 冰品銷售額 ~ 氣溫, data = M01)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -1.2452 -0.3947 -0.1093  0.3448  1.6782 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -1.433595   0.105790  -13.55   <2e-16 ***
# 氣溫         0.136407   0.003835   35.57   <2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5141 on 364 degrees of freedom
# Multiple R-squared:  0.7766,	Adjusted R-squared:  0.776 
# F-statistic:  1265 on 1 and 364 DF,  p-value: < 2.2e-16

# 使用 plot 函數製作散佈圖，第一個參數指定橫軸資料來源，第二個參數指定縱軸資料來源
# type 關鍵字可指定圖型，例如p為點（內定）、l為線，
# main 關鍵字可指定散佈圖的主標題，sub 關鍵字可指定散佈圖的次標題，
# xlab 關鍵字可指定橫軸標題，ylab 關鍵字可指定縱軸標題，
# col 關鍵字可指定圖點顏色，
# pch 關鍵字可指定圖點樣式,例如16為實心圓、8為心號、1為空心圓等
plot(M01$氣溫, M01$冰品銷售額, type="p", main="氣溫與冰品銷售額散佈圖",
     sub="2016年", xlab="氣溫", ylab="冰品銷售額", col="dark blue", pch=16)

# 使用abline函數在散佈圖上加上趨勢線
abline(lm(冰品銷售額~氣溫,data=M01),col="red")

#### 2.0 多元迴歸分析並繪製 3D 散佈圖 氣溫、相對溼度與冰品銷售金額 --------
# 處理資料為 IceSale_2A.xlsx 氣溫、相對溼度與冰品銷售金額

# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

# 讀取測試資料IceSale_2A.xlsx，氣溫、相對溼度與冰品銷售金額
# 參數stringsAsFactors設為TRUE或FALSE，若設為TRUE，則字串資料會被轉換成因子格式，也就是計量型態，以利統計處理
# 參數stringsAsFactors設為FALSE，則迴歸分析仍可進行，但不能繪圖
# startRow=3 代表自第三列開始讀取資料，endRow=NULL代表不設定結束列，第三列（含）以後的資料都讀取
M02 = read.xlsx("IceSale_2A.xlsx", sheetIndex=1, as.data.frame=T,
              header=T, encoding="UTF-8", stringsAsFactors=FALSE,
              rowIndex=NULL, colIndex=NULL,
              startRow=3, endRow=NULL)
str(M02)
# 'data.frame':	366 obs. of  4 variables:
# $ 日期      : Date, format: "2016-01-01" "2016-01-02" "2016-01-03" ...
# $ 氣溫      : num  19.9 19.9 19.6 23 23.7 18.9 19.1 18.1 18.8 22.9 ...
# $ 相對溼度  : num  79 84 93 85 87 90 78 80 71 78 ...
# $ 冰品銷售額: num  1.75 2.05 2 1.2 1.23 1.05 1.69 1.59 2 2.05 ...

names(M02)
# [1] "日期"       "氣溫"       "相對溼度"   "冰品銷售額"

summary(M02)
#      日期                 氣溫          相對溼度       冰品銷售額   
# Min.   :2016-01-01   Min.   : 6.40   Min.   :33.00   Min.   :0.000  
# 1st Qu.:2016-04-01   1st Qu.:20.93   1st Qu.:57.00   1st Qu.:1.590  
# Median :2016-07-01   Median :27.45   Median :65.00   Median :2.350  
# Mean   :2016-07-01   Mean   :26.68   Mean   :66.87   Mean   :2.206  
# 3rd Qu.:2016-09-30   3rd Qu.:32.88   3rd Qu.:77.00   3rd Qu.:2.917  
# Max.   :2016-12-31   Max.   :37.90   Max.   :95.00   Max.   :4.600

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，若自變數有多個，則以+號連接
# 第二個參數使用data關鍵字指定資料來源，本例為M02數據框
RES_02 = lm(冰品銷售額 ~ 氣溫+相對溼度, data = M02)

# 載入scatterplot3d擴展包，以便繪製3D（3 dimensions）散佈圖
if(!require(scatterplot3d)) {install.packages("scatterplot3d");library("scatterplot3d")}
# 附加來源資料
attach(M02)

# scatterplot3d繪製3D散佈圖（繪製規則存入My3D）
# color指定圖點顏色,type指定圖點型式,例如p為點、l為線條、h為垂直線,
# main主標題,pch指定圖點樣式,例如16為實心圓、8為心號、1為空心圓等,
# box是否要繪出立體方框
My3D = scatterplot3d(氣溫,相對溼度,冰品銷售額, main="冰品銷售3D散佈圖",
                       color="darkblue", type="p", pch=16, box=TRUE)

# 繪製迴歸面
# Add regression plane
My3D$plane3d(RES_02, col="red")

# 卸載scatterplot3d擴展包
detach("package:scatterplot3d", unload=TRUE)

# 顯示分析結果（截距及斜率）
RES_02
# Call:
# lm(formula = 冰品銷售額 ~ 氣溫 + 相對溼度, data = M02)
# 
# Coefficients:
# (Intercept)         氣溫     相對溼度  
#   -1.193294     0.133611    -0.002478  

# 顯示分析摘要
summary(RES_02)
# Call:
# lm(formula = 冰品銷售額 ~ 氣溫 + 相對溼度, data = M02)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -1.2434 -0.3965 -0.1208  0.3484  1.6871 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -1.193294   0.263595  -4.527 8.12e-06 ***
# 氣溫         0.133611   0.004754  28.107  < 2e-16 ***
# 相對溼度    -0.002478   0.002489  -0.995     0.32    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5141 on 363 degrees of freedom
# Multiple R-squared:  0.7772,	Adjusted R-squared:  0.776 
# F-statistic: 633.2 on 2 and 363 DF,  p-value: < 2.2e-16

### 3.0 多元迴歸分析並繪製 3D 散佈圖，氣溫、休假日與冰品銷售金額（非計量變數） -------
# 所處理資料為 IceSale_2B.xlsx 氣溫、休假日與冰品銷售金額（非計量變數）

# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

# 讀取測試資料IceSale_2B.xlsx，氣溫、休假日與冰品銷售金額
# 參數stringsAsFactors設為TRUE或FALSE，若設為TRUE，則字串資料會被轉換成因子格式，也就是計量型態，以利統計處理
# 參數stringsAsFactors設為FALSE，則迴歸分析仍可進行，但不能繪圖
# startRow=3 代表自第三列開始讀取資料，endRow=NULL代表不設定結束列，第三列（含）以後的資料都讀取
M03=read.xlsx("IceSale_2B.xlsx", sheetIndex=1, as.data.frame=T,
              header=T, encoding="UTF-8", stringsAsFactors=TRUE,
              rowIndex=NULL, colIndex=NULL,
              startRow=3, endRow=NULL)

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，若自變數有多個，則以+號連接
# 第二個參數使用data關鍵字指定資料來源，本例為M01數據框
RES_03 = lm(冰品銷售額 ~ 氣溫+週休或假日, data = M03)

# 載入scatterplot3d擴展包，以便繪製3D（3 dimensions）散佈圖
if(!require(scatterplot3d)) {install.packages("scatterplot3d");library("scatterplot3d")}

# 附加來源資料
# detach(M02)

attach(M03)

# scatterplot3d繪製3D散佈圖（繪製規則存入My3D）
# color指定圖點顏色,type指定圖點型式,例如p為點、l為線條、h為垂直線,
# main主標題,pch指定圖點樣式,例如16為實心圓、8為心號、1為空心圓等,
# box是否要繪出立體方框
My3D02 = scatterplot3d(氣溫,週休或假日,冰品銷售額, main="冰品銷售3D散佈圖",
                         color="darkblue",type="p", pch=16, box=TRUE,
                         xlab="氣溫",ylab="休假日",zlab="冰品銷售額",
                         angle=20)

# 繪製迴歸面
# Add regression plane
My3D02$plane3d(RES_03, col="red")

# 卸載scatterplot3d擴展包
detach("package:scatterplot3d", unload=TRUE)

# 顯示分析結果（截距及斜率）
RES_03
# Call:
# lm(formula = 冰品銷售額 ~ 氣溫 + 週休或假日, data = M03)
# 
# Coefficients:
#   (Intercept)           氣溫  週休或假日Yes  
#       -1.5925         0.1359         0.5134 

# 顯示分析結果摘要
summary(RES_03)
# Call:
#     lm(formula = 冰品銷售額 ~ 氣溫 + 週休或假日, data = M03)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -1.4837 -0.2971 -0.0260  0.3179  1.3325 
# 
# Coefficients:
#                Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   -1.592540   0.094682  -16.82   <2e-16 ***
# 氣溫           0.135950   0.003386   40.16   <2e-16 ***
# 週休或假日Yes  0.513420   0.050330   10.20   <2e-16 ***
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.4539 on 363 degrees of freedom
# Multiple R-squared:  0.8264,	Adjusted R-squared:  0.8254 
# F-statistic: 863.8 on 2 and 363 DF,  p-value: < 2.2e-16

### 4.0 # 多元迴歸分析_非計量變數 年資、性別、學歷與薪資 -------

# lm函數雖然會自動轉換非計量變數為虛擬變項，
# 但若其分類數大於2，如本例之學歷，分為高中、大學、研究所等三種，則最好自行轉換，
# 以免分析結果的自變項非所期望的項目，例如希望高中、大學，卻出現高中、研究所，或其他組合，
# 非計量變數之分類數等於2，例如性別，則可將stringsAsFactors設為TRUE,由系統自行轉換

# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

M04Orig = read.xlsx("SalaryAnalysis_Original.xlsx", sheetIndex=1, as.data.frame=T,
                header=T, encoding="UTF-8", stringsAsFactors= T,
                rowIndex=NULL, colIndex=NULL,
                startRow=4, endRow=NULL)
str(M04Orig)
# 'data.frame':	156 obs. of  5 variables:
# $ 員工編號: Factor w/ 156 levels "A001","A002",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ 年資    : num  37 37 37 35 34 33 32 32 31 30 ...
# $ 性別    : Factor w/ 2 levels "F","M": 1 2 2 2 1 2 2 2 2 1 ...
# $ 學歷    : Factor w/ 3 levels "大學","研究所",..: 3 1 3 3 1 3 1 1 1 1 ...
# $ 薪資    : num  4.1 5.4 4.2 4.2 5.5 4.1 5.3 5.2 5.5 5.1 ...

summary(M04Orig)
#    員工編號        年資       性別        學歷          薪資      
# A001   :  1   Min.   : 1.00   F: 43   大學  :114   Min.   :2.500  
# A002   :  1   1st Qu.:10.00   M:113   研究所: 13   1st Qu.:3.400  
# A003   :  1   Median :16.00           高中  : 29   Median :3.825  
# A004   :  1   Mean   :16.54                        Mean   :3.891  
# A005   :  1   3rd Qu.:22.25                        3rd Qu.:4.213  
# A006   :  1   Max.   :37.00                        Max.   :5.500  
# (Other):150     

table(M04Orig[ ,3])
#  F   M 
# 43 113 

table(M04Orig[ ,4])
# 大學 研究所   高中 
#  114     13     29 

table(M04Orig[ ,3:4])
#      學歷
# 性別 大學 研究所 高中
#    F   36      6    1
#    M   78      7   28

RES_04Orig = lm(薪資 ~ 年資+性別+學歷, data=M04Orig)
RES_04Orig
# Call:
# lm(formula = 薪資 ~ 年資 + 性別 + 學歷, data = M04Orig)
# 
# Coefficients:
# (Intercept)         年資        性別M   學歷研究所     學歷高中  
#      2.5503       0.0812       0.1422       0.6932      -0.8790  

summary(RES_04Orig)
# Call:
# lm(formula = 薪資 ~ 年資 + 性別 + 學歷, data = M04Orig)
# 
# Residuals:
#     Min       1Q   Median       3Q      Max 
# -0.64120 -0.11214  0.00837  0.13967  0.53101 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  2.550267   0.046899  54.378  < 2e-16 ***
# 年資         0.081197   0.002095  38.763  < 2e-16 ***
# 性別M        0.142214   0.036982   3.845 0.000177 ***
# 學歷研究所   0.693242   0.061433  11.285  < 2e-16 ***
# 學歷高中    -0.879044   0.044779 -19.631  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.1984 on 151 degrees of freedom
# Multiple R-squared:  0.912,	Adjusted R-squared:  0.9097 
# F-statistic: 391.4 on 4 and 151 DF,  p-value: < 2.2e-16


# 讀取測試資料 SalaryAnalysis_Dummy.xlsx，年資、性別、學歷與薪資
# 參數stringsAsFactors設為TRUE或FALSE，若設為TRUE，則字串資料會被轉換成因子格式，也就是計量型態，以利統計處理
# 參數stringsAsFactors設為FALSE
# startRow=3 代表自第三列開始讀取資料，endRow=NULL代表不設定結束列，第三列（含）以後的資料都讀取
M04 = read.xlsx("SalaryAnalysis_Dummy.xlsx", sheetIndex=1, as.data.frame=T,
                header=T, encoding="UTF-8", stringsAsFactors=F,
                rowIndex=NULL, colIndex=NULL,
                startRow=4, endRow=NULL)
str(M04)
# 'data.frame':	156 obs. of  6 variables:
# $ 員工編號: chr  "A001" "A002" "A003" "A004" ...
# $ 年資    : num  37 37 37 35 34 33 32 32 31 30 ...
# $ 性別    : num  0 1 1 1 0 1 1 1 1 0 ...
# $ 高中學歷: num  1 0 1 1 0 1 0 0 0 0 ...
# $ 大學學歷: num  0 1 0 0 1 0 1 1 1 1 ...
# $ 薪資    : num  4.1 5.4 4.2 4.2 5.5 4.1 5.3 5.2 5.5 5.1 ...

summary(M04)
# 員工編號              年資            性別           高中學歷         大學學歷           薪資      
# Length:156         Min.   : 1.00   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :2.500  
# Class :character   1st Qu.:10.00   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:3.400  
# Mode  :character   Median :16.00   Median :1.0000   Median :0.0000   Median :1.0000   Median :3.825  
#                    Mean   :16.54   Mean   :0.7244   Mean   :0.1859   Mean   :0.7308   Mean   :3.891  
#                    3rd Qu.:22.25   3rd Qu.:1.0000   3rd Qu.:0.0000   3rd Qu.:1.0000   3rd Qu.:4.213  
#                    Max.   :37.00   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :5.500

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，若自變數有多個，則以+號連接
# 第二個參數使用data關鍵字指定資料來源，本例為M01數據框
RES_04 = lm(薪資 ~ 年資+性別+高中學歷+大學學歷, data=M04)

# 載入scatterplot3d擴展包，以便繪製3D（3 dimensions）散佈圖
if(!require(scatterplot3d)) {install.packages("scatterplot3d");library("scatterplot3d")}

# 附加來源資料
# detach(M02)

attach(M04)
names(M04)
# [1] "員工編號" "年資"     "性別"     "高中學歷" "大學學歷" "薪資" 

# scatterplot3d繪製3D散佈圖（繪製規則存入My3D）
# color指定圖點顏色,type指定圖點型式,例如p為點、l為線條、h為垂直線,
# main主標題,pch指定圖點樣式,例如16為實心圓、8為心號、1為空心圓等,
# box是否要繪出立體方框
My3D04 = scatterplot3d(年資,性別,薪資, main="薪資3D散佈圖",
                         color="darkblue",type="p", pch=16, box=TRUE,
                         xlab="年資",ylab="性別",zlab="薪資",
                         angle=20)

# 繪製迴歸面
# Add regression plane
My3D04$plane3d(RES_04, col="red")
# Error in segments(x, z1, x + y.max * yx.f, z2 + yz.f * y.max, lty = ltya,  : 
# 無法將長度為零與非零的座標混合

# 卸載scatterplot3d擴展包
detach("package:scatterplot3d", unload=TRUE)

# 顯示分析結果（截距及斜率）
RES_04
# Call:
# lm(formula = 薪資 ~ 年資 + 性別 + 高中學歷 + 大學學歷, data = M04)
# 
# Coefficients:
# (Intercept)         年資         性別     高中學歷     大學學歷  
#      3.2435       0.0812       0.1422      -1.5723      -0.6932 

# 顯示分析結果摘要
summary(RES_04)
# Call:
# lm(formula = 薪資 ~ 年資 + 性別 + 高中學歷 + 大學學歷, data = M04)
# 
# Residuals:
#     Min       1Q   Median       3Q      Max 
# -0.64120 -0.11214  0.00837  0.13967  0.53101 
# 
# Coefficients:
#           Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  3.243509   0.060534  53.581  < 2e-16 ***
# 年資         0.081197   0.002095  38.763  < 2e-16 ***
# 性別         0.142214   0.036982   3.845 0.000177 ***
# 高中學歷    -1.572286   0.075764 -20.752  < 2e-16 ***
# 大學學歷    -0.693242   0.061433 -11.285  < 2e-16 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.1984 on 151 degrees of freedom
# Multiple R-squared:  0.912,	Adjusted R-squared:  0.9097 
# F-statistic: 391.4 on 4 and 151 DF,  p-value: < 2.2e-16

### 5.0 自行練習 ------
# 5.1 多元迴歸分析_非計量變數
# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

# 讀取測試資料 SalaryAnalysis_Original.xlsx，年資、性別、學歷與薪資
M01a=read.xlsx("SalaryAnalysis_Original.xlsx",sheetIndex=1,as.data.frame=T,
              header=T,encoding="UTF-8",stringsAsFactors=T,
              rowIndex=NULL,colIndex=NULL,
              startRow=4, endRow=NULL)

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，若自變數有多個，則以+號連接
# 第二個參數使用data關鍵字指定資料來源，本例為M01數據框
RES_01a = lm(薪資~年資+性別+學歷,data=M01a)


# 5.2 多元迴歸分析_非計量變數
# 執行本程式之前務必關閉目標檔案 D:/Test_DataMining/Result_Regression_5.xlsx

# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

# 讀取測試資料 SalaryAnalysis_Dummy_B.xlsx，年資、性別、學歷與薪資
# 參數stringsAsFactors設為TRUE或FALSE，若設為TRUE，則字串資料會被轉換成因子格式，也就是計量型態，以利統計處理
# 參數stringsAsFactors設為FALSE
# startRow=3 代表自第三列開始讀取資料，endRow=NULL代表不設定結束列，第三列（含）以後的資料都讀取
M01b = read.xlsx("SalaryAnalysis_Dummy_B.xlsx",sheetIndex=1,as.data.frame=T,
              header=T,encoding="UTF-8",stringsAsFactors=F,
              rowIndex=NULL,colIndex=NULL,
              startRow=4, endRow=NULL)

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，若自變數有多個，則以+號連接
# 第二個參數使用data關鍵字指定資料來源，本例為M01數據框
RES_01b =lm(薪資 ~ 年資+性別+研究所學歷+高中學歷, data=M01b)

### 5.3 # 多元迴歸分析_非計量變數

# 載入xlsx擴展包，以便存取Excel檔
if(!require(xlsx)) {install.packages("xlsx");library("xlsx")}

# 讀取測試資料 SalaryAnalysis_Dummy_C.xlsx，年資、性別、學歷與薪資
# 參數stringsAsFactors設為TRUE或FALSE，若設為TRUE，則字串資料會被轉換成因子格式，也就是計量型態，以利統計處理
# 參數stringsAsFactors設為FALSE
# startRow=3 代表自第三列開始讀取資料，endRow=NULL代表不設定結束列，第三列（含）以後的資料都讀取
M01c =read.xlsx("SalaryAnalysis_Dummy_C.xlsx",sheetIndex=1,as.data.frame=T,
              header=T,encoding="UTF-8",stringsAsFactors=F,
              rowIndex=NULL,colIndex=NULL,
              startRow=4, endRow=NULL)

# 使用 lm函數進行迴歸分析，括號內有兩個參數，
# 第一個參數指定因變數欄名及自變數欄名，中間以~符號分隔，若自變數有多個，則以+號連接
# 第二個參數使用data關鍵字指定資料來源，本例為M01數據框
RES_01c =lm(薪資 ~ 年資+性別+大學學歷+研究所學歷, data=M01c)



