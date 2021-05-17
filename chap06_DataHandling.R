# chap06_DataHandling

##############################
# chapter06. 데이터 조작  
##############################

## 1. plyr 패키지 활용 
# - 두 개 이상의 데이터프레임을 대상으로 key값을 이용하여 
# 하나의 패키지로 병합(merge)하거나, 집단변수를 기준으로 
# 데이터프레임의 변수에 함수를 적용하여 요약집계 결과를 제공하는 패키지.
# 데이터 조작 후 다시 읽을 때 윗 내용이 이해되어야 함! 

# 1.1 데이터 병합
install.packages('plyr') # 패키지 설치
library(plyr)

# 병합(merge)할 데이터프레임 셋 만들기 
x <- data.frame(id=c(1, 2, 3, 4, 5), height=c(160, 171, 173, 162, 165))
y <- data.frame(id=c(5, 4, 1, 3, 2), weight=c(55, 73, 60, 57, 80))

?join # plyr 패키지 함수 
z <- join(x, y, by='id') # id 컬럼으로 조인 
# 유사한 데이터가 다른 파일에 따로따로 저장되어 있는 일은 비일비재하게 발생할 수 있기 때문에
# 그럴 때 join을 사용하면 간편하게 병합할 수 있다. 
# join이나 merge를 꼭 어느 상황에 국한해서 사용해야 한다는 법은 없다
z

# 왼쪽(left) 조인하기
x <- data.frame(id=c(1, 2, 3, 4, 6), height=c(160, 171, 173, 162, 165))
y <- data.frame(id=c(5, 4, 1, 3, 2), weight=c(55, 73, 60, 57, 80))

left <- join(x, y, by='id') 
# id 컬럼으로 조인(왼쪽변수기준:NA(결측치:누락된 값, 비어있는 값))
left
# id가 6인 경우의 weight 값은 없기 때문에 NA로 채워주고 있다
# 오라클 DB의 ansi join, full join같은 개념 

# 내부(inner) 조인하기 
x <- data.frame(id=c(1, 2, 3, 4, 6), height=c(160, 171, 173, 162, 165))
y <- data.frame(id=c(5, 4, 1, 3, 2), weight=c(55, 73, 60, 57, 80))

inner <- join(x, y, by='id', type='inner') 
# type='inner':값이 있는 것만 조인.
# weight 값이 NA인 id 6은 제외한 후 join 되었다 
inner

# 전체(full) 조인하기 
x <- data.frame(id=c(1, 2, 3, 4, 6), height=c(160, 171, 173, 162, 165))
y <- data.frame(id=c(5, 4, 1, 3, 2), weight=c(55, 73, 60, 57, 80))

full <- join(x, y, by='id', type='full') 
# type='full':모든 항목 조인.
# 데이터에 NA이 있어도 모든 데이터를 join한다 
full

# key값으로 병합하기
x <- data.frame(key1=c(1,1,2,2,3), key2=c('a','b','c','d','e'),val1=c(10,20,30,40,50))
y <- data.frame(key1=c(3,2,2,1,1), key2=c('e','d','c','b','a'),val1=c(500,400,300,200,100))
xy <- join(x,y,by=c('key1','key2'))
xy

# 1.2 그룹별 기술 통계량 구하기

#  (1) tapply() 함수 이용

# iris 데이터 셋을 대상으로 tapply() 함수 적용하기
head(iris)
names(iris) # 컬럼명 반환 
unique(iris$Species) # 꽃의 종류 보기 - 3가지
?unique
tapply(iris$Sepal.Width, iris$Sepal.Species, mean) # 평균
# setosa versicolor  virginica 
#  5.006      5.936      6.588 
# 첫번째 인자에 대한 평균 3그룹으로 묶어서 구함 

tapply(iris$Sepal.Length, iris$Species, sd) # 표준편차 
#    setosa versicolor  virginica 
# 0.3524897  0.5161711  0.6358796 


#  (2) ddply() 함수 이용
# 꽃의 종류별(Species)로 꽃받침 길이의 평균 구하기 
avg_df <- ddply(iris, .(Species), summarise, avg=mean(Sepal.Length))
avg_df

str(avg_df) # 'data.frame':	3 obs. of  2 variables:

# 꽃의 종(Species)으로 여러 개의 함수 적용하기 
a <- ddply(iris, .(Species), summarise, 
                avg=mean(Sepal.Length),
                std=sd(Sepal.Length),
                max=max(Sepal.Length),
                min=min(Sepal.Length))
# ddply()는 처리할 함수를 계속 콤마로 이어서 작성할 수 있는 장점이 있다
# summarise : 기술통계량(평균, 최소값, 최대값 등)
a

# round() 함수를 적용하여 반올림 처리하기.
b <- ddply(iris, .(Species), summarise, 
           avg=round(mean(Sepal.Length),2),
           std=round(sd(Sepal.Length),2),
           max=max(Sepal.Length),
           min=min(Sepal.Length))
# a랑 다른 점은 소숫점 2자리가 넘어가는걸 2자리로 줄임 
b

## 2. dplyr 패키지 활용
#  - 기존 plyr 패키지는 R 언어로 개발되었으나, (퍼포먼스 이슈)
# dplyr 패키지는 C++언어로 개발되어 처리 속도를 개선.
# 내부 로직은 C++ 언어로 개발됐지만 접근은 R로 가능하다

install.packages(c("dplyr", "hflights"))
library(dplyr)
library(hflights)

head(hflights)
str(hflights) # 'data.frame':	227496 obs. of  21 variables:
# hflights : 2011년도 미국 휴스턴에서 출발하는 
# 모든 비행기의 이/착륙 정보를 기록한 데이터다. 

# 2.1 콘솔 창의 크기에 맞게 데이터 추출
#   : 콘솔 창 안에서 한 눈으로 파악하기
hflights_df <- tbl_df(hflights)
# tbl_df() : 콘솔창을 넘어가는 데이터는 주석문처럼 보여주고 화면을 넘기지 않는다
hflights_df

# 2.2 조건에 맞는 데이터 필터링

# feature가 21개 있다고 해서 21개를 전부 쓰는게 아니라
# 어떤 데이터를 이용해야 유의미한 데이터가 출력될지
# 통찰력을 발휘하는게 분석가의 역량이다. 

# hflights_df를 대상으로 1월2일 데이터 추출하기.
filter(hflights_df, Month==1 & DayofMonth==2) # AND
# 678 x 21
# filter() : 기존의 데이터를 빠르게 처리하기 위해 사용
# filter는 select문의 where절과 유사한 의미다. 

# 1월 혹은 2월 데이터 추출
filter(hflights_df, Month==1 | Month==2) # OR
# 36,038 x 21

# 2.3 컬럼으로 데이터 정렬
# 년, 월, 출발시간, 도착시간 순으로 오름차순 정렬
arrange(hflights_df, Year, Month, DepTime, ArrTime)

# 년, 월, 출발시간, 도착시간 순으로 내림차순 정렬
arrange(hflights_df, Year, Month, desc(DepTime), ArrTime)
# DepTime이 동일하면 ArrTime 기준으로 오름차순 정렬된다.

# 2.4 컬럼으로 데이터 검색
# hflights_df에서 년, 월, 출발시간, 도착시간 컬럼 검색하기.
select(hflights_df, Year, Month, DepTime, ArrTime) # 4개의 컬럼 선택.

# 컬럼의 범위 지정하기.
select(hflights_df, Year:ArrTime)

# 컬럼의 범위 제외 : Year부터 DayOfWeek 제외
select(hflights_df, -(Year:DayOfWeek))


# 2.5 데이터 셋에 컬럼 추가

# 출발 지연 시간과 도착 지연 시간과의 차이를 계산하는 컬럼 추가하기.
mutate(hflights_df, gain = ArrDelay - DepDelay, 
       gain_per_hour = gain/(AirTime/60))
# 새로운 데이터 셋을 저장할 때 쓸 뿐만 아니라
# 기존 데이터의 가공/처리된 데이터 셋에 새로운 컬럼명을
# 추가할 때도 유용하게 쓰이는 함수다. 
# gain처럼 기존 데이터를 가공하거나 
# gain_per_hour처럼 가공한 분 단위 데이터를 다시 
# 시간단위 데이터로 (단위 낮추기) 처리할 때도 mutate()를 쓴다

# mutate() 함수에 의해서 추가된 컬럼 보기
select(mutate(hflights_df, gain = ArrDelay - DepDelay, 
              gain_per_hour = gain/(AirTime/60)), 
       Year, Month, ArrDelay, DepDelay, gain, gain_per_hour)

# 2.6 요약 통계치 계산

# 비행시간 평균 계산하기.
summarise(hflights_df, avgAirTime=mean(AirTime, na.rm = T))

# 데이터 셋의 관측치 길이, 출발 지연 시간 평균 구하기
summarise(hflights_df, cnt=n(), delay=mean(DepDelay, na.rm = T))

# 도착시간(ArrTime)의 표준편차와 분산 계산하기
summarise(hflights_df, arrTimeSd=sd(ArrTime, na.rm = T),
          arrTimeVar=var(ArrTime, na.rm = T))

# 2.7 집단변수 대상 그룹화

# 집단변수를 이용하여 그룹화하기 
species <- group_by(iris, Species)
# setosa versicolor virginica를 50개씩 나눴다 
str(species)

planes <- group_by(hflights_df, TailNum) # TailNum(항공기 일련번호)
delay <- summarise(planes, count=n(), dist=mean(Distance, na.rm = T), 
                   delay=mean(ArrDelay, na.rm = T))

delay <- filter(delay, count > 20, dist < 2000)

library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size=count), alpha=1/2) +
  geom_smooth() +
  scale_size_area()
# 개별함수를 합친다 
?aes

# 파이프(pipe)연산자 이용하기
getwd()
setwd("C:/workspaces/Rwork/data")

exam <- read.csv("csv_exam.csv")
exam

# filter()
# %>% : 파이프(pipe) 연산자 -> 단축키(ctl+shift+m)
# 파이프연산자 : 함수들을 조합하거나 적용할 때 쓰거나
# 파이프 말그대로 함수와 함수들을 타고 다니면서 데이터를 전달할 때 사용
# dplyr 패키지의 핵심 기능 
exam %>% filter(class==1)

# select()
exam %>% select(class, math, english)

# class가 1인 행만 추출한 다음 english 추출 
exam %>% filter(class==1) %>% select(english) # method-chaining과 유사 
# 혹은 가독성 좋게 작성 
exam %>% 
  filter(class==1) %>% 
  select(english)

# exam
# %>% filter(class==1) 이렇게 다음 줄로 편집하면 제대로 실행이 안된다

# 과목별 총점과 총점 기준 내림차순 정렬해서 상위 6개 데이터만을  출력.
exam %>% 
  mutate(total=math+english+science) %>% 
  arrange(desc(total)) %>% 
  head

# join 실습용 데이터프레임 생성
df1 <- data.frame(x = 1:5, y = rnorm(5))
df2 <- data.frame(x = 2:6, z = rnorm(5))
df1; df2

# join과 관련된 다양한 함수 사용해서 병합 
# 기존의 plyr 패키지는 join이라는 하나의 메서드안에 type 속성으로 
# 병합의 기준을 정할 수 있었는데 dplyr은 함수로 다 정의해주고 있다
inner_join(df1, df2, by='x') # inner_join은 중복 값만 병합
left_join(df1, df2, by = 'x') # left_join은 첫 입력값(df1)을 기준으로 결합
right_join(df1, df2, by = 'x')
full_join(df1, df2)

# 두 개의 데이터프레임을 행 단위로 합치기 
bind_rows(df1, df2) 
# 두 개의 데이터프레임을 열 단위로 합치기 
bind_cols(df1, df2) # x 는 x...1로, x는 x...3로 변경된 이유는
# 열 단위로 합치다 보니 강제로 이름이 변경된 것이다.

## 3. reshape2 패키지 활용

# 3.1 긴 형식을 넓은 형식으로 변경 

# 패키지 설치
install.packages('reshape2')
library(reshape2)

# 데이터 가져오기 
data <- read.csv("data.csv")
data
View(data) # View() : 엑셀처럼 테이블 형태로 보여주는 함수
# View는 데이터가, 특히 날짜가 중복되는 경우가 종종 생긴다.
# 그래서 나온 기능이 행이 많은게 아니라 열이 많도록 설정하는 것
# ↓
# 긴 형식 -> 넓은 형식으로 변경
wide <- dcast(data, Customer_ID ~ Date, sum)
View(wide) # View()에서 중복되는 날짜를 모듈화한다. 
# View(data) : hive의 external 영역 데이터
# View(wide) : managed or mart 영역에 전처리한 값을 담는 것 

# 파일 저장 및 읽기
setwd("C:/workspaces/Rwork/output")
write.csv(wide, 'wide.csv', row.names = F)

wide_read <- read.csv('wide.csv')
colnames(wide_read) <- c('id','day1','day2','day3','day4','day5','day6','day7')
# read.csv()는 data.frame형으로 저장하기 때문에 colnames()에 
# c함수로 열 이름을 지정할 수 있다. 
wide_read

# 3.2 넓은 형식을 긴 형식으로 변경 

# melt() 함수 이용
long <- melt(wide_read, id='id')
long # id 기준으로 날짜와 구매량을 재정렬 

# 컬럼명 수정
colnames(long) <- c("id", "Data", "Buy")
head(long)

# reshape2 패키지의 smiths 데이터 셋 구조 변경하기 
data("smiths") # 넓은 형식의 데이터 
smiths

# wide -> long
long <- melt(smiths, id=1:2)
long

# long -> wide
dcast(long, subject + time ~ ...) # subject와 time이 기준 


# 3.3 3차원 배열 형식으로 변경

# airquality 데이터 셋 구조 변경
data("airquality") # New York의 대기에 대한 질
View(airquality)
str(airquality) # 'data.frame':	153 obs. of  6 variables:

# 컬럼명 대문자 일괄 변경
names(airquality) <- toupper(names(airquality)) # 컬럼명 대문자 변경.
head(airquality)
# 컬럼명이 대소문자가 섞여있으면 접근하는데 어려워질 수 있기 때문에

# 월과 일 컬럼으로 나머지 4개 컬럼을 묶어서 긴 형식 변경 
air_melt <- melt(airquality, id=c("MONTH", "DAY"), na.rm = T)
head(air_melt) # MONTH DAY variable value
# 5개월치 데이터가 OZONE, SOLAR.R, WIND, TEMP 순대로 4번 반복된다
View(air_melt)
?View
# 일과 월 컬럼으로 variable 컬럼을 3차원 형식으로 분류
names(air_melt) <- tolower(names(air_melt)) # 컬럼명 소문자 변경 
acast <- acast(air_melt, day~month~variable) # 3차원 구조 변경
acast(air_melt, day~month~variable)
# ~(틸트) : dcast()의 두번째 인자에 변수 양옆에 작성해서 넣는 기호
# 2개의 틸트로 3개의 컬럼 항목을 기준으로 선택하고 있다 
# acast(데이터 세트, 기준열~변환열~분리 기준열) 
# 3차원 배열 형식으로 변환한다. 항목별로 한 눈에 비교하기 쉽다
View(acast)
class(acast) # "array"

# 월 단위 variable(대기관련 컬럼) 컬럼 합계
acast(air_melt, month~variable, sum)
# month를 기준으로 variable을 처리할 때 sum 함수를 이용한다 
# 5월부터 9월까지 OZONE, SOLAR.R WIND TEMP 값을 더해서 반환 
# 인간이 데이터를 전처리해서 학습시키는게 머신러닝  
# 그냥 알아서 학습하라는게 딥러닝