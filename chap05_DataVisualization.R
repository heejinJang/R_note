# chap05_DataVisualization

##############################
# chapter05. 데이터 시각화 
##############################

# discrete <-> Continuous 
# discrete : 이산변수. 범주를 갖는 값
# Continuous : 연속변수. 시간에 따라 연속적으로 갖는 값 

# 이산변수와 연속변수 시각화 

# 1. 이산변수(discrete quantitative data) 시각화
#   - 정수 단위로 나누어 측정할 수 있는 변수.
# 정수 '단위'일 뿐, 정수 값X. 정수라고 해서(ex.나이) 무조건 discrete는 아니다 
# 요인(factor)으로 분류할 수 있는게 discrete다 

#  1) 막대차트 시각화 - barplot() 함수
#    (1) 세로 막대차트

# 막대 차트 데이터 생성
chart_data <- c(305, 450, 320, 460, 330, 480, 380, 520)
names(chart_data) <- c("2019 1분기", "2020 1분기", "2019 2분기", "2020 2분기", "2019 3분기", "2020 3분기", "2019 4분기", "2020 4분기")

str(chart_data)
chart_data

# 세로 막대 차트
help("barplot")
barplot(chart_data, ylim = c(0, 600), col = rainbow(8), 
        main = "2019년도 vs 2020년도 분기별 매출현황 비교")

barplot(chart_data, ylim = c(0, 600), col = rainbow(8), 
        xlab = "년도별 분기현황", ylab = "매출액(단위:만원)",
        main = "2019년도 vs 2020년도 분기별 매출현황 비교")

#    (2) 가로 막대 차트 
# 세로 막대와 동일한 설정에 horiz값만 T로 변경하면 된다 
barplot(chart_data, xlim = c(0, 600), col = rainbow(8),
        ylab = "년도별 분기현황", xlab = "매출액(단위:만원)", 
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T)

barplot(chart_data, xlim = c(0, 600), col = rainbow(8),
        ylab = "년도별 분기현황", xlab = "매출액(단위:만원)", 
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5, cex.names=0.8)
# cex.names의 cex는 character의 expansion이다. 
# 문자열의 크기를 설정할 수 있다 (default는 1.0)

# red와 blue 색상 4회 반복
barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:만원)",
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5, cex.names=0.8,
        col=rep(c(2, 4), 4))
# col=rep(c(2, 4), 4)) : 검은색(1), 빨간색(2), 초록색(3), 파란색(4), 하늘색(5), 자주색(6), 노란색(7)
# rep(c(2,4),4) : 2 4 2 4 2 4 2 4 (rep()는 반복)

barplot(chart_data, xlim = c(0, 600),
        ylab = "년도별 분기현황", xlab = "매출액(단위:만원)",
        main = "2019년도 vs 2020년도 분기별 매출현황 비교",
        horiz = T, space=1.5, cex.names=0.8,
        col=rep(c("green", "yellow"), 4))
# 색깔은 문자열 키워드로도 가능 
?col

# 누적 막대 차트
data("VADeaths")
VADeaths

str(VADeaths)
mode(VADeaths)  # "numeric"
class(VADeaths) # "matrix" "array"
# R 4버전부터는 matrix도 array도 함께 출력한다 


# 개별 차트와 누적 차트 그리기

# 누적 차트
par(mfrow=c(1,2)) # 1행 2열 그래프 보기 #default는 (1,1) 
# par() : 여러 그래프를 한 화면에 그리기. 

barplot(VADeaths, col=rainbow(5), 
        main = "미국 버지니아주 하위계층 사망 비율")
# 각 비율을 폭으로 지정해서 나타내주고 있다 
# barplot의 data가 vector일 땐 하나하나 막대그래프로 보여줬는데
# matrix일 땐 막대 하나마다 폭을 다르게 해서 보여준다 

legend(3.8, 200, 
       c("50-54", "55-59", "60-64", "65-69", "70-74"), 
       cex = 0.8, fill = rainbow(5))
# legend : 범례. cex는 80%로 축소 

# 개별 차트
barplot(VADeaths, col=rainbow(5), 
        main = "미국 버지니아주 하위계층 사망 비율",
        beside=T)
# 전달되는 구조가 matrix여도 개별 차트로 보고싶은 경우는
# beside값을 T로 설정하면 된다 

legend(19, 71, 
       c("50-54", "55-59", "60-64", "65-69", "70-74"), 
       cex = 0.8, fill = rainbow(5))


#  2) 점 차트 시각화 - dotchart()
help("dotchart")

par(mfrow=c(1,1)) # 1행1열 그래프 보기
chart_data # vector 
dotchart(chart_data, color = c("black", "red"),
         xlab = "매출액(단위:만원)", 
         cex=1.2,
         main="분기별 판매현황 점 차트 시각화",
         labels=names(chart_data))

dotchart(chart_data, color = c("black", "red"),
         xlab = "매출액(단위:만원)", 
         cex=1.2,
         main="분기별 판매현황 점 차트 시각화",
         labels=names(chart_data),
         lcolor="blue", pch=2:3)
# pch(plotting character): 원(1), 삼각형(2), +(3) (default는 1)
# cex(character expansion): 레이블과 점의 크기 확대 역할.

#  3) 원형 차트 시각화 - pie() 함수 
help(pie)
par(mfrow=c(1,1))
pie(chart_data, labels = names(chart_data),
    border = 'blue', col=rainbow(8), cex=1.2)
title("2019~2020년도 분기별 매출현황")
?title

# 2. 연속변수(Continuous quantitative data) 시각화 
#   - 시간, 길이 등과 같은 연속성을 가진 변수.

#  1) 상자 그래프 시각화 : 요약정보를 시각화하는데 효과적. 
# 특히 데이터의 분포 정도와 이상치 발견을 목적으로 하는 경우 유용.
?boxplot
par(mfrow=c(1,2))
boxplot(VADeaths, range=1.5) #  default 
boxplot(VADeaths, range=0) # 상자그래프 시각화.
# 박스의 맨 밑은 1/4분위, 맨 위는 3/4분위다.
# 분위당 값은 summary로 보여주는데 boxplot은 그걸 시각화한 것
# 그래프 당 박스 폭도 다르고 위치도 다 다르다.
# range=0:최소값과 최대값을 점선으로 연결하는 역할.

abline(h = 37, lty=3, col="red") # 기준선 추가(lty=3 : 점선, h : 높이)

summary(VADeaths) # 요약 통계량 제공(값과 그래프를 비교해서 보면 가독성↑)
# 3분위와 max 차이가 너무 많이 나면 이상적인 데이터구나! 하는 분석도 가능

#  2) 히스토그램 시각화 
#    - 측정값의 범위(구간)를 그래프의 x축으로 놓고, 범위에 속하는 측정값의 빈도수를 y축으로 나타낸 그래프 형태.

data("iris") # iris 데이터 셋 가져오기
head(iris)
table(iris$Species) # 입력값의 빈도수를 count해서 반환 
#setosa versicolor  virginica 
#    50         50         50

names(iris)
# "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" "Species"

par(mfrow=c(1,2))
summary(iris$Sepal.Width)

hist(iris$Sepal.Width, xlab = "꽃받침의 너비",
     col="mediumaquamarine", xlim=c(2.0, 4.5), 
     main="iris 꽃받침 너비 histogram")
# xlim은 summary의 값에 비례해서 설정하는 것이 가장 좋음 

summary(iris$Sepal.Length)

hist(iris$Sepal.Length, xlab = "꽃받침의 길이",
     col="mistyrose", xlim=c(4.0, 8.0), 
     main="iris 꽃받침 길이 histogram")

par(mfrow=c(1,1))
?hist
# 확률 밀도로 히스토그램 그리기 - 연속형변수의 확률.
hist(iris$Sepal.Width, xlab = "꽃받침 너비",
     col="mistyrose", xlim=c(2.0, 4.5),
     main="iris 꽃받침 너비 histogram", freq=F)
# freq = T (Frequency), freq = F (Density) 

# 밀도를 기준으로 line을 그려준다.
lines(density(iris$Sepal.Width), col="red")
# freq가 F인 경우(Density)만 적용된다 

# 정규분포곡선 추가(curve()) 
# : 이상치 데이터에 가깝다. lines가 실값에 가까움
# - 분포곡선:빈도수의 값을 선으로 연결하여 얻어진 곡선.
x <- seq(2.0, 4.5, 0.1)
x

curve(dnorm(x, mean=mean(iris$Sepal.Width),
            sd=sd(iris$Sepal.Width)), 
      col="blue", add=T)
# curve() : 분포도 곡선 
# dnorm : 확률 밀도 함수 데이터를 발생, sd : 표준편차 
?curve

#  3) 산점도 시각화 
#    - 두 개 이상의 변수들 사이의 분포를 점으로 표시한 차트를 의미.
par(mfrow=c(1,1))

# 정규분포를 따르는 이상치의 분포에서 난수를 생성할 땐 rnorm() 사용
# 균등분포를 따르는 이상치의 분포에서 난수를 생성할 땐 runif() 사용
# 이항분포를 따르는 이상치의 분포에서 난수를 생성할 땐 rbinom() 사용

# 기본 산점도 시각화
price <- runif(10, min = 1, max = 100) # 1~100 사이의 10개 난수 발생.
plot(price)

# 대각선 추가
par(new=T) # 차트 추가
?par
line_chart <- c(1:100)
line_chart
plot(line_chart, type = "l", col="red", axes = F, ann = F)

# 텍스트 추가 
text(70, 80, "대각선 추가", col="blue")

# type 속성으로 그리기 
par(mfrow=c(2,2)) # 2행 2열 차트 그리기
plot(price, type = "l") # 유형:실선
plot(price, type = "o") # 유형:원형과 실선(원형통과)
plot(price, type = "h") # 유형:직선
plot(price, type = "s") # 유형:꺽은선 

# pch 속성으로 그리기
plot(price, type="o", pch=5) # 빈 사각형
# pch : 모양에 대한 세팅.(원, 사각형이나 두께 등)
plot(price, type="o", pch=15) # 채워진 사각형
plot(price, type="o", pch=20) # 채워진 원형
plot(price, type="o", pch=20, col="blue")
plot(price, type="o", pch=20, col="orange", cex=3.0) 
# cex : 글씨의 크기 설정인데 별도의 텍스트가 없어서 pch 원이 커짐 
plot(price, type="o", pch=20, col="orange", cex=3.0, lwd=3) 
# lwd : line width

#  4) 중첩 자료 시각화 

# 중복된 자료의 수 만큼 점의 크기 확대하기

par(mfrow=c(1, 1)) # 1행 1열

# 두 개의 벡터 객체
x <- c(1, 2, 3, 4, 2, 4)
y <- rep(2, 6)
x; y

# 교차테이블 작성
table(x); table(y) # 1,2,3,4의 빈도 수, # 2,6의 빈도 수
table(x, y)
#   y
#x   2  X가 1, y가 2인 개수는 1개, x가 2, y가 2인 개수는 2개... 
#  1 1
#  2 2
#  3 1
#  4 2

# 산점도 시각화
plot(x, y)
# x 축이 1, 2, 3, 4인 것의 수치가 똑같아 보인다. 

# 데이터프레임 생성
xy.df <- as.data.frame(table(x, y))
xy.df # data.frame으로 형변환하면 index가 default로 생성되면서
# freq(빈도수, count한 개수 값)라는 열이 추가로 생성된다. 
#x y Freq
#1 1 2    1
#2 2 2    2
#3 3 2    1
#4 4 2    2
?plot
# 좌표에 중복된 수 만큼 점 확대
plot(x, y, pch=15, col="blue", 
     xlab = "x 벡터 원소",
     ylab = "y 벡터 원소",
     cex = 0.8 * xy.df$Freq)
# 빈도수에 따라서 그래프를 달리 나타내고 싶다
# 빈도수에 해당하는 Freq에(xy.df$Freq) 0.8을 곱해서 표현되도록 하고 있다

# galton 데이터 셋(부모 키와 자식 키의 연관성) 대상 중복 자료 시각화

# galton 데이터 셋 가져오기
library(UsingR)
data("galton")
head(galton)
str(galton) # 'data.frame':	928 obs. of  2 variables: (928행 2열)
class(galton) # "data.frame"

# 데이터프레임으로 변환
galtonData <- as.data.frame(table(galton$child, galton$parent))
# table로 반환된 빈도수를 data.frame으로 변환하면 Freq가 자동 추가된다
head(galtonData)
str(galtonData) # 'data.frame':	154 obs. of  3 variables:
galtonData

# 컬럼 단위 추출
names(galtonData) <- c("child", "parent", "freq") # 컬럼에 이름 지정.
head(galtonData)

# 수치형으로 변환(산점도로 시각화하기 위해)
parent <- as.numeric(galtonData$parent)
child <- as.numeric(galtonData$child)

# 점의 크기 확대
plot(parent, child, pch=21, col="blue", bg="mediumaquamarine",
     xlab = "parent", ylab = "child",
     cex = 0.2 * galtonData$freq) # freq는 값이 크지 않으니까 


#  5) 변수 간의 비교 시각화
# iris 4개 변수의 상호 비교
attributes(iris) # $names(컬럼명) $class(자료 구조) $row.names(행의 default값)
data(iris)
help(pairs)

# matrix 또는 데이터프레임의 numeric 컬럼을 대상으로 
# 변수들 사이의 비교 결과를 행렬구조의 분산된 그래프로 제공.
pairs(iris[,1:4]) # "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"
# 입력된 변수별로 데이터의 특징을 분포도로 보여준다. (150개)
# 대각선을 기준으로 왼쪽으로 90도를 꺾으면 동일한 그래프다 

# 꽃의 종류가 "virginica"와 "setosa", "versicolor"를 종별 대상으로 4개 변수 상호 비교.
pairs(iris[iris$Species=="virginica", 1:4]) # 50개
pairs(iris[iris$Species=="setosa", 1:4]) # 50개
pairs(iris[iris$Species=="versicolor", 1:4]) # 50개 

# 3차원 산점도 시각화 
# 패키지 설치 및 로딩 
install.packages("scatterplot3d")
library(scatterplot3d)
?scatterplot3d

# Factor의 levels 보기
levels(iris$Species) # "setosa" "versicolor" "virginica"

# 붓꽃의 종류별 분류 
iris_setosa <- iris[iris$Species == 'setosa', ]
iris_versicolor <- iris[iris$Species == 'versicolor', ]
iris_virginica <- iris[iris$Species == 'virginica', ]

# 3차원 틀 생성
# scatterplot3d(밑변, 
#               오른쪽변 컬럼명, 
#               왼쪽변 컬럼명, type)

d3 <- scatterplot3d(iris$Petal.Length, 
                    iris$Sepal.Length, 
                    iris$Sepal.Width, type = 'n') 
# type : h->수직선, p->점, l->선 

# 3차원 산점도 시각화 
d3$points3d(iris_setosa$Petal.Length,
            iris_setosa$Sepal.Length,
            iris_setosa$Sepal.Width,
            bg='orange', pch=21) # 타원 산점도 

d3$points3d(iris_versicolor$Petal.Length,
            iris_versicolor$Sepal.Length,
            iris_versicolor$Sepal.Width,
            bg='blue', pch=23) # 마름모꼴 산점도 

d3$points3d(iris_virginica$Petal.Length,
            iris_virginica$Sepal.Length,
            iris_virginica$Sepal.Width,
            bg='green', pch=25) # 역삼각형 산점도 
# 머신러닝에 이 3개 데이터를 학습시켜서 모델을 구성한다고 해도 
# sepal.width와 petal.length+sepal.length은 연관성이 크지 않기 때문에
# 좋은 알고리즘이라도 모델은 좋은 결과를 피드백하기엔 제한적이다. 
# 초록색과 파란색을 정말 정확하게 분류할 목적으로 알고리즘을 구성하면 과적합이 올 수 있다
# 데이터 셋이 겹치는 영역이 많다면 모델을 통해 정확한 분류는 기대하기 어렵다
# 이렇게 중복 데이터가 많은 데이터 셋은 전처리 작업이 알고리즘 구성보다 더 중요하다
