# chap02_DataStructure

######################################
# chapter02. 데이터의 유형과 구조
######################################

# 1. Vector 자료 구조
##  - C() 함수 이용 벡터 객체 생성
x <- c(1, 2, 3, 4, 5) # combine 함수
x

x <- c(1:20) # 콜론 : 범위 
x

y <- 10:20 # 10부터 20까지의 벡터 객체 생성 
y

##  - seq() 함수 이용 벡터 객체 생성
x <- seq(1, 10, 2) # sequence : 인자(시작, 종료, 증감)
x

##  - rep() 함수 이용 벡터 객체 생성
help(rep) # help() : 함수 정보 
example(rep)
rep(1:3, 3) # replicate : 인자(대상, 반복수)
# 1 2 3 1 2 3 1 2 3
rep(1:3, each=3)
# 1 1 1 2 2 2 3 3 3

# union(), setdiff(), intersect() 함수 이용
x <- c(1, 3, 5, 7)
y <- c(3, 5)
x; y # 두 변수를 출력할 때 한 라인이 간단할 때는 세미콜론으로 한 줄에 쓸 수 있다

union(x, y)     # 합집합(x+y)
setdiff(x, y)   # 차집합(x-y)
intersect(x, y) # 교집합(x^y)

# 숫자형, 문자형, 논리형 벡터 생성
v1 <- c(33, -5, 20:23, 12, -2:3) # 연속적으로 벡터가 생성됨 
v1
v2 <- c(33, -5, 20:23, 12, "4") # 데이터를 모두 문자형으로 변환.
v2


# 한 줄에 명령문 중복 사용
v1; mode(v1)

# 벡터에 컬럼명 지정 : names() 
age <- c(20, 25, 30)
age
names(age) <- c("홍길동", "이순신", "강감찬")
age
age <- NULL # age 변수 데이터 삭제(age는 참조변수기 때문에 null로 초기화)

# 벡터 자료 참조하기
a <- c(1:50)
a[10] # index : 1부터 시작.
a[c(10:45)] # index 10에서 45사이의 벡터 원소 출력
a[10:(length(a)-5)] # 10~45

# 잘못된 벡터 첨자 사용 예
a[1,2] # Error in a[1, 2] : incorrect number of dimensions
a[1:2] # a[c(1:2)] 혹은 a[c(1,2)]와 동일

# c() 함수에서 콤마 사용 예
v1 <- c(33, -5, 20:23, 12, -2:3)
v1
v1[1]
v1[c(2,4)]
v1[c(3:5)]; v1[3:5] # combine은 써도 안써도 똑같은 결과가 나온다 
v1[c(4, 5:8, 9)]

# 음수 값으로 첨자 지정 예
v1[-1] # 해당 위치의 원소를 제외한 값 출력 
v1[-c(2,4)]
v1[-c(2:5)]
v1[-c(2,5:10,1)]

# 패키지 설치(RSADBE)와 메모리 로딩
install.packages("RSADBE") # 패키지(데이터) 설치 
library(RSADBE)            # 패키지를 메모리에 로드

data("Severity_Counts")    # RSADBE 패키지에서 제공되는 데이터 셋 가져오기.
# Severity_Counts : 선형 형태의 1차원 배열 
str(Severity_Counts) 

# 패키지에서 제공되는 벡터데이터 셋 보기
Severity_Counts # 1차원 선형 벡터 자료형


# 2. Matrix 자료 구조

# 벡터 이용 행렬 객체 생성 
m <- matrix(c(1:5))
m  # 5행 1열 (행은 5행, 열은 기본값인 1열로 자동 세팅) 

# 벡터의 열 우선으로 행렬 객체 생성
?matrix # R 프로그래밍은 별도로 설정하지 않으면 초기값으로 세팅된다(usage 참고)
m <- matrix(c(1:10), nrow = 2) # 2행 5열
m 

# 행과 열의 수가 일치하지 않는 경우 예
m <- matrix(c(1:11), nrow = 2) 
# 경고 메세지(오류는 아니지만 1이라는 의도하지 않은 값이 추가될 수 있다)
m

# 벡터의 행 우선으로 행렬 객체 생성
m <- matrix(c(1:10), nrow = 2, byrow = T) # 행 우선
# byrow를 true로 설정하면 숫자가 채워진 순서가 행 우선이다. 
m

# 벡터의 열 우선으로 행렬 객체를 생성하고 싶다!
m <- matrix(c(1:10), byrow = T) # 주의 - 여전히 10행 1열 (1행 10열 X)
# arguments로 가보면 byrow는 자료 구조가 logical(T or F)이다.
# f이면 열 우선, t면 행 우선이다.
# nrow나 ncol값이 하나라도 설정하지 않으면 데이터의 길이가 1열이 기본값이다
m <- matrix(c(1:10), nrow = 1, byrow = T) # 내가 원하는 값이 나왔다!
m
m <- matrix(c(1:10), ncol = 10) # 1행 10열 # (nrow = 1, byrow = T)와 동일
m

?matrix

# 행 묶음으로 행렬 객체 생성
x1 <- c(5, 40, 50:52)
x2 <- c(30, 5, 6:8)
x1; x2
mr <- rbind(x1, x2) # x1은 1행, x2는 2행으로 bind(행 단위로 결합)
mr <- rbind(x2, x1) # x2이 1행, x1은 1행 
mr

# 열 묶음으로 행렬 객체 생성
mc <- cbind(x1, x2) # x1은 1열, x2는 2열로 bind(열 단위로 결합) 
mc <- cbind(x2, x1) # x2이 1열, x1은 2열 
mc

args(matrix) # = ?matrix의 usage 
examples(matrix) # = ?matrix의 Examples 

# 2행으로 행렬 객체 생성
m3 <- matrix(10:19, 2) # 10개 데이터를 2행으로 생성
m3

# 자료와 객체 type 보기
mode(m3); class(m3) # numeric, matrix
# 2차원 배열인 matrix도 array로 통칭하고 있다.
# 원래는 3차원 배열이상만 array로 불렀는데 이젠 2차원 배열 이상이라면 다 해당된다

# 행렬 객체에 첨자로 접근
m3[1,]   # 1행 전체
m3[,5]   # 5열 전체
m3[2,3]  # 2행 3열의 데이터 1개 -> 15
m3[1,c(2:5)] # 1행에서 2~5열 데이터 4개
m3[1,c(2,5)] # 1행에서 2열, 5열 데이터 2개

# 3행 3열로 행렬 객체 생성
x <- matrix(c(1:9), nrow = 3, ncol = 3) # 3행3열의 열 우선 matrix 객체
x

# 자료의 개수 보기
length(x) # 데이터 개수
ncol(x); nrow(x) # 열 / 행 수

?apply 
# apply(인자1, 인자2, 인자3) 
# 인자1 : data, 인자2 : 1이면 행 2면 열, 인자3 : Function 

# apply() 함수 적용(특히 데이터 전처리할 때) 
apply(x, 1, max) # 행 단위 최대값
apply(x, 1, min) # 행 단위 최소값
apply(x, 2, mean) # 열 단위 평균값

# 사용자 정의 적용
f <- function(x){ # x 매개변수
  x * c(1, 2, 3) # combine으로 생성한 vector를 x data와 각각 곱한다 
}

# 행 우선 순서로 사용자 정의 함수 적용
result <- apply(x, 1, f) # x data를 행 기준으로 f함수를 실행하라(익명함수 호출은 변수에 담아서)
x; result # 행 기준으로 실행되도 matrix를 기준으로 '열' 우선 배치되고 있다. 

# 열 우선 순서로 사용자 정의 함수 적용
result <- apply(x, 2, f)
x; result

# 행렬 객체에 컬럼명 지정하기
colnames(x) <- c('one', 'two', 'three') # 열에 컬럼명매기기
rownames(x) <- c('first', 'second', 'third') # 행에 로우명매기기 
x


## 3. Array 자료 구조

# 3차원 배열 객체 생성하기
vec <- c(1:12) # 12개 벡터 객체 생성 # 1 2 3 4 5 6 7 8 9 10 11 12 
vec
# 자바는 int[2][3][4]라면 2면3행4열이지만 R프로그래밍은 2행3열4면이다

# vector를 array로 변환하려면?
arr <- array(vec, c(3,2,2)) # 3행2열2면 -> 3차원 배열 객체 생성 
arr 
?array

# 3차원 배열 객체 자료 조회
arr[,,1] # 1면 # 열 우선 배치 
arr[,,2] # 2면
arr[2, ,1] # 2행 1면 
arr[1,2,2] # 1행 2열 2면

# 배열 자료형과 자료 구조
mode(arr); class(arr) # "numeric", "array"


# 데이터 셋 가져오기
library(RSADBE)
data(Bug_Metrics_Software)
str(Bug_Metrics_Software) # str은 structure 

# 데이터 셋 자료보기
Bug_Metrics_Software
# BA_Ind값이 Before인 것은 출시 전 버그 데이터, After은 출시 후 데이터인데
# 이 데이터 셋은 3차원 배열로 작성되었다. 


## 4. List 자료 구조

# key를 이용하여 value에 접근하기 
member <- list(name=c("홍길동", "유관순"), age=c(35, 25),
               address=c("서울", "경기도"), gender=c("남자", "여자"),
               htype=c("아파트", "오피스텔"))
member

# key를 이용하여 value에 접근하기 
member$name
member$name[1]
member$name[2]

member$age <- 45  # 데이터 수정(value값을 1개로 초기화시켜버린다) 
# 그래서 수정할 때는 index를 명시해야 정확히 수정된다!! 
member$age

member$id <- c("hong", "you") # 데이터 추가
member$age <- NULL   # 데이터 제거 
member

# 1개 값을 갖는 리스트 객체 생성
list <- list("lee", "이순신", 35)
?list
#[[1]]     ---------> key(생략) [[n]]
#[1] "lee" ---------> value[n]

#[[2]]
#[1] "이순신"

#[[3]]
#[1] 35


# 1개 이상의 값을 갖는 리스트 객체 생성
num <- list(c(1:5), c(6:10)) # 인자1이 key1, 인자2가 key2에 자리한다. 
num

# 리스트(3차원) 자료구조 -> 벡터(1차원) 구조로 변경하기 
unlist <- unlist(num)
unlist # 1차원은 index로 접근할 수 있기 때문에 list보다 구조가 단순하다.

# 리스트 객체에 함수 적용하기 
# list data 처리 함수
a <- list(c(1:5))  # 리스트 객체 생성 # [[1]] 1 2 3 4 5
b <- list(c(6:10)) # 리스트 객체 생성 # [[1]] 6 7 8 9 10
a; b
?lapply
c <- lapply(c(a,b), max) # list로 결과 반환
c
mode(c); class(c)  # "list" "list"

# 리스트 형식을 벡터 형식으로 반환하기 
c <- sapply(c(a,b), max)
c
mode(c); class(c) # "numeric" "integer"

# 다차원 리스트 객체 생성 
multi_list <- list(list(1, 2, 3), list(10, 20, 30), list(100,200,300))
multi_list
#[[1]]        [[2]]       [3]
#[[1]][[1]]   [[2]][[1]]  [[3]][[1]]
#[1] 1        [1] 10      [1] 100

#[[1]][[2]]   [[2]][[2]]  [[3]][[2]]
#[1] 2        [1] 20      [1] 200

#[[1]][[3]]   [[2]][[3]]  [[3]][[3]]
#[1] 3        [1] 30      [1] 300 

multi_list <- list(c1=list(1, 2, 3), c2=list(10, 20, 30), c3=list(100,200,300))
multi_list

multi_list$c1
multi_list$c2
multi_list$c3

?do.call
# 다차원 리스트를 열 단위로 바인딩 
d <- do.call(cbind, multi_list)
# do.call(cbind, 다차원 배열)은 다차원 list를 matrix 형태로 반환한다. 
# do.call(what, args 등) : what은 func이나 func의 이름. args는 인자의 특성 이름
d # matrix(2차원 배열)로 반환 
class(d) # "matrix"



## 5. Data Frame 자료 구조 

# 벡터 이용 객체 생성 
no  <- c(1, 2, 3) # numeric 혹은 Integer
name <- c("홍길동","이순신","강감찬") # character
pay <- c(150,250,300) # numeric
vemp <- data.frame(No=no,Name=name,Pay=pay) # No, Name, Pay가 컬럼명이다 
# matrix가 열 중심으로 배치하는 이유도 동일한 데이터 셋을 묶어주기 위함이다!! 
vemp
class(vemp) # "data.frame"
mode(vemp) # "list" 

# matrix 이용 객체 생성 
args(matrix)
m <- matrix(c(1, "홍길동", 150,2,"이순신",250,3,"강감찬",300), 3, by=T)
m # 2차원 배열은 데이터의 자료형이 동일해야 하는데 그렇지 않으니 문자열로 통일시켜버림
class(m) # "matrix"

memp <- data.frame(m) 
# matrix를 data.frame에 넣었을 때 별도의 컬럼명을 지정하지 않으면 X1 X2 X3라는 default 컬럼명으로 지정한다
memp
class(memp) # "data.frame"

# txt 파일 이용 객체 생성
getwd()
setwd("c:/workspaces/Rwork/data") 
# working directory는 R studio가 종료되기 전까지만 유효하다 

txtemp <- read.table('emp.txt', header = T, sep = "")
# read.table의 인자1값은 wd 경로에 파일이 존재해야 한다. 
# header는 컬럼명이 있는지에 대한 여부다. 
# sep는 seperator로 구분자를 의미하는데 ""로 설정하면 빈 여백이자 default 값이다.
txtemp # wd의 파일을 read.table을 이용해 R로 읽어온다 
class(txtemp) # "data.frame"


# csv 파일 이용 객체 생성(header=T)
csvtemp <- read.csv('emp.csv', header = T)
csvtemp; class(csvtemp)#[1] "data.frame"


# csv 파일 이용 객체 생성(header=F)
name <- c("사번", "이름", "급여")
csvtemp2 <- read.csv('emp2.csv', header = F, col.names = name)
csvtemp2 <- read.csv('emp2.csv', header = F)
# read.csv 함수는 csv 확장자를 읽어오는 함수다. col.names는 컬럼명을 지정한 것
csvtemp2


# 데이터프레임 만들기
df <- data.frame(x=c(1:5),y=seq(2,10,2),z=c('a','b','c','d','e'))
df # x, y, z는 컬럼 이름이며, 데이터는 '열 중심'으로 배치된다. 

# 데이터프레임 컬럼명 참조
df$x

# 자료구조, 열수, 행수, 컬럼명 보기
# 테이블의 행은 object 
str(df) # df 변수에 대한 정보 
ncol(df) # numeric은 정수, 실수를 포함한다. 여기서 세분화해서 정수면 Integer, 실수면 float(?)로 보여준다 
nrow(df) # y 행 데이터 셋은 seq 함수로 생성되었고 그의 자료형은 numeric이다. 
df[c(2:3)] # 일정 범위의 index를 지정할 수 있는데, 이 때는 column이 선택된다 

# 요약 통계량 보기
summary(df)
# Min.은 0/4분위, 1st Qu.는 1/4분위, Median은 2/4분위, Mean은 평균값, 
# 3rd Qu.는 3/4분위, Max.는 4/4분위
# 각 분위의 값은 전체 값을 4등분해서 각각 %에 해당하는 값을 나타낸다. 
# summary 함수는 알아서 요약 통계량을 보여준다.
# 통계량은 수치일 때 적용되는 개념이기 때문에 자료형이 문자열인 z 컬럼은 정보만 보여준다

# 데이터프레임 자료에 함수 적용
apply(df[,c(1,2)], 2, sum) # apply(data, 1이면 행 2면 열, function)
# df[,1,2]는 x와 y 컬럼이다. 

# 데이터프레임의 부분 객체 만들기
# subset은 부분집합. subset(data, 조건식(선별해서 출력)) 
?subset
df
x1 <- subset(df, x >= 3) # x가 3이상인 레코드(행) 대상 (3,4,5)
x1
y1 <- subset(df, y <= 8) # y가 8이하인 레코드(행) 대상 
y1

# 두 개의 조건으로 부분 객체 만들기
xyand <- subset(df, x>=2 & y<=6)
xyand

xyor <- subset(df, x>=2 | y<=6)
xyor

# student 데이터프레임 만들기(전형적인 key&value 형식의 데이터)
sid <- c('A','B','C','D')
score <- c(90, 80, 70, 60)
subject <- c('컴퓨터', '국어국문', '소프트웨어', '유아교육')
sid; score; subject
student <- data.frame(sid, score, subject)
student

# 자료형과 자료구조 보기
mode(student); class(student) # list, data.frame
# student의 자료형이 list인 이유는 자료형이 다르더라도 통칭해서 list로 부른다
str(sid); str(score); str(subject)
str(student)

# 두 개 이상의 데이터프레임 병합하기
height <- data.frame(id=c(1,2), h=c(180, 175))
weight <- data.frame(id=c(1,2), w=c(80,75))
height; weight

# 객체처럼 병합(merge)해서 관리. merge는 R studio 설치할 때 기본 설치되는 base 패키지의 함수
?merge
person <- merge(height, weight, by.x="id", by.y="id")
# by.x와 by.y는 병합할 기준이다. id에 있는 공통 값인 1과 2를 병합해서 return한다
# by.x by.y : specifications of the columns used for merging. 
# merge는 데이터 조작 전처리(가독성↑, 분석 알고리즘 전달 이전에 전처리)
# 전처리는 병합 및 연관성이 적을 때 분리하는 조작도 빈번히 일어난다
person


# galton 데이터 셋 가져오기
#install.packages("psych") # 패키지 설치 
#library(psych) # 패키지 메모리에 로드
install.packages("UsingR") # 패키지 설치 
library(UsingR) # 패키지 메모리에 로드
data("galton") # galton 데이터 셋 가져오기

# galton 데이터 셋 구조 보기
str(galton)
dim(galton)
head(galton, 20)  # head 함수 : 상위 n개의 데이터만 발췌 
head(galton) # head 함수에 매개변수가 없는 경우 : default 갯수:6
# 머신러닝의 핵심 개념인 '회귀분석'의 결과가 galton 데이터에 적용시키면
# 부모의 키가 자식의 키에 영향을 미치지 않는다는 결과가 나옴. 


## 6. 문자열 처리

# 문자열 추출하기 
install.packages("stringr") # 패키지 설치 
library(stringr) # 메모리 로딩

# 형식) str_extract('문자열', '정규표현식')
str_extract("홍길동35이순신45강감찬50","[0-9]{2}")
# [0-9]{2}는 0부터 9사이의 문자열이 연속적으로 2개 나오는 것을 발췌하겠다는 뜻이다
# str_extract는 조건에 부합하는 정규표현식을 찾으면 거기서 끝낸다

str_extract_all("홍길동35이순신45강감찬50","[0-9]{2}")
# 만약 조건에 부합하는 모든 데이터를 찾고 싶으면 _all만 붙이면 됨 

# 반복수를 지정하여 영문자 추출(문자열을 변수에 담아서 메서드 매개변수로 넣는 것이 일반적이다)
string <- 'hongkildong105lee1002you25강감찬2005'
str_extract_all(string, '[a-z]{3}')  
str_extract_all(string, '[a-z]{3,}') # [1] "hongkildong" "lee" "you"
str_extract_all(string, '[a-z]{3,5}') # [1] "hongk" "ildon" "lee" "you"

# 특정 단어 추출 
str_extract_all(string, '유관순') #[[1]] character(0) 
str_extract_all(string, '강감찬')


# 한글, 영문자, 숫자 추출하기
str_extract_all(string, 'hong') 
str_extract_all(string, '25') 
str_extract_all(string, '[가-힣]{3}') # 한글 검색
str_extract_all(string, '[a-z]{3}') # 소문자 검색
str_extract_all(string, '[A-Z]{3}') # 대문자 검색 # [[1]] character(0)
str_extract_all(string, '[0-9]{4}') # 숫자 검색


# 한글, 영문자, 숫자를 제외한 나머지 추출하기
str_extract_all(string, '[^a-z]')
str_extract_all(string, '[^a-z]{4}')
str_extract_all(string, '[^가-힣]{5}')
str_extract_all(string, '[^0-9]{3}')


# 주민등록번호 검사하기 
jumin <- '123456-3234567'
str_extract_all(jumin, '[0-9]{6}-[1234][0-9]{6}') # 뒷번호 앞자리는 1~4로 필터링
str_extract_all(jumin, '\\d{6}-[1234]\\d{6}')
# 결과는 동일하다. \d를 그대로 인식하기 위해 \\d. \d는 숫자(decimal)

# 지정된 길이의 단어 추출하기
name <- '홍길동1234,이순신5678,강감찬1012'
str_extract_all(name, '\\w{7,}') 
str_extract_all(name, '\\W')
# '\\w'(소문자) : 한글/영문자/숫자 포함. 즉, 특수문자 제외. (쉼표 제외)
# '\\W'(대문자) : 특수문자 선택.

# 문자열 위치(index) 구하기 
string <- 'hongkd105leess1002you25강감찬2005'
str_locate(string, '강감찬') 
# str_locate 함수 : 내가 찾는 문자열의 위치 index값을 return한다. 

# 문자열 길이 구하기 
string <- 'hongkild105lee1002you25강감찬2005'
len <- str_length(string) # 30
len

# 부분 문자열
string_sub <- str_sub(string, 1, len-7)
string_sub

string_sub <- str_sub(string, 1, 23)
string_sub

# 대문자, 소문자 변경하기 
str_to_upper(string_sub)
str_to_lower(string_sub)

# 문자열 교체하기 
string_rep <- str_replace(string_sub, 'hongkild105', '홍길동35,')
string_rep <- str_replace(string_rep, 'lee1002', '이순신45,')
string_rep <- str_replace(string_rep, 'you25', '유관순25,')
string_rep


# 문자열 결합하기 
string_c <- str_c(string_rep, '강감찬55')
string_c


# 문자열 분리하기
string_sp <- str_split(string_c, ',')
string_sp

# 문자열 합치기 
string_vec <- c('홍길동35', '이순신45', '유관순25', '강감찬55')
string_vec

string_join <- paste(string_vec, collapse = ',')
# paste는 base 패키지에서 제공. 문자열을 조작할 때 기본 함수도 쓰임
string_join

