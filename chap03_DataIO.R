# chap03_DataIO

######################################
# chapter03. 데이터 입출력
######################################

# 1. 데이터 불러오기

## 1-1. 키보드 입력 

# 키보드로 숫자 입력하기
num <- scan()
# scan() 실행하면 사용자가 입력하기를 기다리는 상태로 바뀐다 
num # 변수에 사용자가 입력한 값이 저장된다 

# 합계 구하기
sum(num)

# 키보드로 문자 입력하기
name <- scan(what = character()) # 숫자와 똑같은 패러다임 
name

# 편집기 이용 데이터프레임 만들기 
df <- data.frame() # 빈 데이터프레임 생성(입력 대기 상태)
df <- edit(df)
df

## 1-2. 로컬 파일 가져오기 

# 1) read.table() 함수 이용
#   - 컬럼명이 없는 파일 불러오기
getwd()
setwd("c:/workspaces/Rwork/data") # 존재하지 않는 r/data/가 아니라 workspaces로 변경 
# tools 탭-global options-general에서 언제든 설정 가능 
#wd를 설정하지 않으면 read.table이나 read.csv할 때 
#절대 경로로 전부 작성해줘도 되지만 wd를 설정하면 
#절대 경로에 파일이 없어도 wd에 가서 찾기 때문에 더 편하다 

student <- read.table(file="student.txt") # header 값이 false 
student
mode(student); class(student)

names(student) <- c('번호', '이름', '키', '몸무게')
student

#   - 컬럼명이 있는 파일 불러오기
student1 <- read.table(file="student1.txt", header = T)
student1

#   - 탐색기를 통해서 파일 선택하기
student1 <- read.table(file.choose(), header = T)
student1

#   - 구분자가 있는 경우(세미콜론, 탭)
student2 <- read.table(file="student2.txt", sep = ";", header = T)
student2

#   - 결측치를 처리하여 파일 불러오기
student3 <- read.table(file="student3.txt", header = T, na.strings = "-") # - 문자열 -> NA처리 
student3

#   - csv 파일 형식 불러오기 
student4 <- read.csv(file="student4.txt", na.strings = "-")
student4

# read.xlsx() 함수 이용 - 엑셀데이터 읽어오기 
# 패키지 설치와 java 실행 환경 설정
install.packages("rJava") # rJava 패키지 설치(기능이 자바 언어로 구현되어있다)
install.packages("xlsx")  # xlsx 패키지 설치
Sys.setenv(JAVA_HOME='C:/Program Files/Java/jre1.8.0_271')
# 엑셀 데이터 읽어올 때 read할 jre 버전 작성 

# 관련 패키지 메모리 로드
library(rJava)
library(xlsx)

# 엑셀 파일 가져오기
studentex <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")
# sheetIndex는 시트 번호를 말한다. 
studentex


## 1-3. 인터넷에서 파일 가져오기

# 단계1 : 세계 GDP 순위 데이터 가져오기
GDP_ranking <- read.csv("https://databank.worldbank.org/data/download/GDP.csv", encoding = "UTF-8")
# read.csv는 파일만 불러올 수 있을 뿐만 아니라 네트웍만 연결되어 있으면
# 인터넷 상에서 파일을 읽어온다. 
GDP_ranking
head(GDP_ranking, 20) # head 함수로 출력하면 상위 n개 데이터를 보여준다. 설정안하면 6이 default 
dim(GDP_ranking)
class(GDP_ranking) # data.frame # read.table이나 read.csv는 데이터를 불러와 data.frame으로 저장한다

# 데이터를 가공하기 위해 불필요한 행과 열을 제거한다.
GDP_ranking2 <- GDP_ranking[-c(1:4), c(1,2,4,5)]
head(GDP_ranking2)

# 상위 16개 국가 선별한다.
GDP_ranking16 <- head(GDP_ranking2, 16) # 상위 16개 국가
GDP_ranking16

# 데이터프레임을 구성하는 4개의 열에 대한 이름을 지정한다.
names(GDP_ranking16) <- c('Code', 'Ranking', 'Nation', 'GDP')
GDP_ranking16
dim(GDP_ranking16)

# 단계2 : 세계 GDP 상위 16위 국가 막대 차트 시각화
gdp <- GDP_ranking16$GDP
nation <- GDP_ranking16$Nation
gdp; nation

num_gdp <- as.numeric(str_replace_all(gdp, ',', ''))
# gdp 데이터는 3자리마다 반점이 찍혀있기 때문에 반점은 빈 문자열로 대체하고
# as.numeric()를 이용해 숫자로 형변환하겠다는 뜻! str_replace_all 
# 전처리를 얼마나 잘했냐에 따라 분석/응용 단계에서 빠르게 피드백받을 수 있다. 
num_gdp; 
GDP_ranking16$GDP <- num_gdp # 전처리되기 전인 gdp 데이터를 전처리된 num_gdp로 대체한다. 

# 막대차트 시각화
?barplot
barplot(GDP_ranking16$GDP, col = rainbow(16), 
        xlab = '국가(nation)', ylab='단위(달러)', names.arg=nation)
# names.arg은 x축 값이다 (나라 이름). 
# names.arg은 barplot()의 인자이며, 그래프 바의 vector 이름이다.
# 별도로 지정하지 않으면 height 값을 가져오고,
# 만약 vector라면 matrix의 컬럼값을 가져온다(?) 
# 보통 시각화 그래프를 도출한 후가 완료된 것이 아니라
# 도출한 결과에서 가독성이 좋지 않은 부분은 처리/탐색 과정으로 돌아가서
# 유의미한 데이터가 도출되도록 데이터를 가공하는 과정이 반복된다

# ▼ 데이터 재가공 
# 1,000단위 축소
num_gdp2 <- num_gdp / 1000 # 기존의 num_gdp는 2.0+10의 7승이다 
GDP_ranking16$GDP2 <- num_gdp2 # R에선 $만으로 컬럼을 손쉽게 추가할 수 있다 
# names.arg과 main 있는 버전 
barplot(GDP_ranking16$GDP2, col = rainbow(16), 
        main = "2019년도 GDP 세계 16위 국가",
        xlab = '국가(nation)', ylab='단위(천달러)', names.arg=nation)
# names.arg 없는 버전
barplot(GDP_ranking16$GDP2, col = rainbow(16), 
        main = "2019년도 GDP 세계 16위 국가",
        xlab = '국가(nation)', ylab='단위(천달러)')

## 1-4. 웹문서 가져오기 

# 2010년 ~ 2015년도 미국의 주별 1인당 소득 자료 가져오기.
# "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

# 단계1 : XML / httr 패키지 설치 
install.packages("XML")
install.packages("httr")

library(XML) # R studio를 재시작하면 메모리에 다시 로드해야 한다
library(httr)

# 단계2 : 미국의 주별 1인당 소득 자료 가져오기.
url <- "https://ssti.org/blog/useful-stats-capita-personal-income-state-2010-2015"

get_url <- GET(url) # httr 제공(페이지의 소스를 전부 볼 수 있음)
# 통계학자와 프로그래머가 협업하고, 개발자들도 함께 기능을 먼저 구현해냄 
# -> 개발자는 다양한 패키지를 익숙하게 만드는게 가장 빠르게 분석을 할 수 있는 방법이다 
get_url 
get_url$content # 16진수(vector) 
rawToChar(get_url$content) # html 태그로 변환 
# rawToChar() : Conversion and manipulation of objects of type "raw".
# jsp 페이지 코드를 parsing하는 개념 

html_cont <- readHTMLTable(rawToChar(get_url$content), stringsAsFactors=F)
# readHTMLTable() 은 XML 패키지에서 제공하는 기능이며,
# 브라우저상의 table 데이터를 읽어와 반환한다. 
# factor(요인)는 같은 레벨의 유사한 데이터에서 가질 수 있는 범주의 값을 vector 형태로 관리하는 객체다. 
# stringsAsFactors는 데이터를 factor로 변경하는지에 대한 여부다
# default(true)는 문자열을 factor로 변경한다. 
# factor는 norminal과 ordinal 값을 지정할 수 있다. 
str(html_cont) # list 
html_cont # 
# table에서 셀값을 읽어와 변수에 넣어서 값을 넣어주고 있는 것 
# 대부분의 기능은 패키지안에 구현되어 있으니 함수부터 살펴본 후
# 패키지를 분석하는 것이 좋다. 권고한다~! 

html_cont <- as.data.frame(html_cont) # data.frame형 변환
str(html_cont) # 52 obs. of 7 variables(52개주의 7개의 데이터)
head(html_cont) # 상위 6개 데이터를 반환 

# 단계4 : 컬럼명을 수정한 후 뒷부분 6개 관측치 보기
names(html_cont) <- c("State", "y2010", "y2011", "y2012", "y2013", "y2014", "y2015")
tail(html_cont) # head() 함수랑 매핑시켜서 생각하면 되는데
# head()는 상위 6개, tail()은 하위 6개 데이터를 default로 읽어온다

# 2. 데이터 저장하기
# 2-1. 화면(콘솔) 출력
#  1) cat() 함수
x <- 10
y <- 20
z <- x * y
cat("x * y의 결과는 ", z, "입니다.\n") # \n : 줄바꿈.

#  2) print() 함수 
print(z) # 변수 또는 수식만 가능
print(z * 10)
print("x * y = ", z) # error(변수+수식 불가능) 

# 2-2. 파일에 데이터 저장
#  1) sink() 함수를 이용한 파일 저장
getwd()
setwd("C:/workspaces/Rwork/output")

?data
library(RSADBE)
data("Severity_Counts") # Severity_Counts 데이터 셋 가져오기 
# Severity_Counts : 품관에서 관리하는 오류 데이터를 vector로 관리
# data는 R에서 제공하는 패키지의 데이터 셋을 볼 수 있는데 
# 그 중 RSADBE라는 패키지에서 제공하는 데이터 셋을 읽어오려면
# RSADBE 패키지를 메모리에 로드한 후 data("Severity_Counts") 하면 된다
Severity_Counts

sink("severity.txt") # 저장할 파일 open
# 자바에선 파일을 저장하기 위해선 
# 파일 사이에 read&write하기 위해 stream(단방향)부터 설정했던 것처럼
# R은 sink로 파일 사이에 입력과 출력을 수행한다. 
# sink("severity.txt")는 기존에 파일이 있으면 열고 없으면 생성한다
Severity_Counts
severity <- Severity_Counts # 데이터 셋을 변수에 저장.
# (해도 되지만 data가 저장된 파일을 바로 출력시켜도 결과는 똑같다)
severity  # 콘솔에 출력되지 않고, 파일에 저장
# sink를 실행하는 과정에서 출력하기 때문에 콘솔에 나오지 않고 파일에 저장된다
sink() # 오픈된 파일 close(파일 완성)

#  2) write.table() 함수 이용 파일 저장
# 탐색기를 이용하여 데이터 가져오기
# R studio 재시작하면 library(RJava), library(xlsx) 필요 
studenttx <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")
studenttx

# 기본 속성으로 저장 - 문자열 데이터(행이름과 데이터)에 큰 따옴표가 붙는다.
# 저장할 때 행 이름을 지가 만들어서 큰 따옴표도 붙여서 저장한다
write.table(studenttx, "stdt.txt")

# 'row.names=F' 속성을 이용하여 행이름 제거하여 저장한다.
write.table(studenttx, "stdt2.txt", row.names=F)
# row.names=F 라서 별도의 행을 붙이지 않고 순수 데이터만 저장한다

# 'quote=F' 속성을 이용하여 따옴표를 제거하여 저장한다.
write.table(studenttx, "stdt3.txt", quote=F)

# 행이름 제거 + 따옴표 제거
write.table(studenttx, "stdt4.txt", row.names=F, quote=F)


html_cont # 데이터프레임 확인(GDP 테이블을 읽어와 data.frame으로 변환한 데이터)
write.table(html_cont, "GNP_United States.txt", row.names = F)
# 행 이름 X

GNP_US <- read.table("GNP_United States.txt", sep = "", header = T)
# write.table은 저장하는 시점에 문자열 데이터면 큰 따옴표를 붙이지만
# read.table은 큰 따옴표를 제외하고 출력시킨다(원래 파일에 큰 따옴표가 없어진건 아님)
GNP_US
str(GNP_US) # structure()로 찍어보면 자료형도 character고 큰 따옴표도 잘 붙어있다

#  3) write.xlsx() 함수 이용 파일 저장 - 엑셀 파일로 저장
library(rJava)
library(xlsx) # excel data 입출력 함수 제공

st.df <- read.xlsx(file.choose(), sheetIndex = 1, encoding = "UTF-8")
st.df

write.xlsx(st.df, "studenttx.xlsx") # excel 형식으로 저장.
# 행 이름이 자동으로 추가됨 

#  4) write.csv() 함수 이용 파일 저장
#     - data.frame 형식의 데이터를 csv 형식으로 저장.

write.csv(st.df, "stdf.csv", row.names = F, quote = F)
# 행 이름X 큰 따옴표X 








