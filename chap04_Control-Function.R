# chap04_Control-Function

####################################################
# chapter04-1. 연산자 / 제어문(조건문과 반복문)
####################################################

###################
##  1. 연산자
###################

# 산술연산자
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2

result <- num1 + num2  # 덧셈
result
result <- num1 - num2  # 뺄셈
result
result <- num1 * num2  # 곱셈
result
result <- num1 / num2  # 나눗셈
result

result <- num1 %% num2  # 나머지 연산자(자바는 %, R은 %%)
result

result <- num1^2   # 제곱연산자(num1 ** 2와 동일)
result

result <- num1^num2   # 100의 20승(10의 40승과 동일한 결과)
result   # [1] 1e+40 -> 1 * 10^40


# 비교(관계) 연산자
# 결과는 항상 TRUE 혹은 FALSE가 나올텐데 이것은 항상 대문자! 
# (1) 동등비교
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교 
boolean
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교 
boolean

# (2) 크기비교
boolean <- num1 > num2 
boolean
boolean <- num1 >= num2 
boolean
boolean <- num1 < num2 
boolean
boolean <- num1 <= num2 
boolean

# 논리 연산자
logical <- num1 >= 50 & num2 <= 10
logical

logical <- num1 >= 50 | num2 <= 10
logical

x <- TRUE; y <- FALSE
xor(x, y)
x <- TRUE; y <- TRUE
xor(x, y)

logical <- num1 >= 50
logical

logical <- !(num1 >= 50)
logical


###############################
## 2. 조건문
###############################

# 1) if()
# 자바와 모양도 방법도 동일하다 
x <- 10
y <- 5
z <- x * y
z

#if(조건식){ 산술/비교/논리 연산자 
#    실행문1 <- 참
#}else{
#    실행문1 <- 거짓
#}

if(x*y > 40){ # 산술 > 비교 > 논리
  cat("x*y의 결과는 40이상입니다.\n")  # \n :줄바꿈
  cat("x*y = ", z, '\n')
  print(z)
}else{
  cat("x*y의 결과는 40미만입니다. x*y=", z, "\n")
}


# 학점 구하기
score <- scan()
score

if(score >= 90){ # 조건식1
  result = "A학점"
}else if(score >= 80){ # 조건식1
  result = "B학점"
}else if(score >= 70){ # 조건식2
  result = "C학점"
}else if(score >= 60){ # 조건식3
  result = "D학점"
}else{
  result = "F학점"
}

cat("당신의 학점은 ", result) # 당신의 학점은?
print(result)


# 2) ifelse(조건, 참, 거짓) - 3항 연산자 기능

score <- c(78, 95, 85, 65)
score
ifelse(score >= 80, "우수", "노력")
# "노력" "우수" "우수" "노력"

# ifelse() 응용
getwd()
setwd("C:/workspaces/Rwork/data")

excel <- read.csv("excel.csv", header = T)
excel

q1 <- excel$q1 # q1 변수값 추출 
ifelse(q1 >= 3, sqrt(q1), q1) # 3보다 큰 경우 sqrt() 함수 적용.
ifelse(q1 >= 2 & q1 <= 4, q1^2, q1) # 조건식에 논리식도 쓸 수 있다

# 3) switch문
#   형식) switch(비교구문, 실행구문1, 실행구문2, 실행구문3, ...)
# 자바와 이름은 똑같지만 모양은 다르다. 차이점을 위주로 관찰! 
switch("name", id="hong", pwd="1234", age=25, name="홍길동")
# 인자1 자리엔 실질적으로 아래 코드처럼 특정 값보단 변수가 오는 경우가 많다
# switch()의 인자는 마치 case문이라고 생각하면 된다.

empname <- scan(what = "")
empname # "kang"

switch(empname, hong=250, lee=350, kim=200, kang=400) # 400

# 4) which문
#   - which()의 괄호내의 조건에 해당하는 위치(인덱스)를 출력한다.
#   - 벡터에서 사용 -> index값 리턴.

name <- c("kim", "lee", "choi", "park")
which(name == "choi") # 3(index) # R은 0이 아니라 1부터 count 

# 데이터프레임에서 사용
no <- c(1:5)
name <- c("홍길동", "이순신", "강감찬", "유관순", "김유신")
score <- c(85, 78, 89, 90, 74)

exam <- data.frame(학번=no, 이름=name, 성적=score)
exam

which(exam$이름=="유관순") # 4

exam[4,]
# 학번   이름 성적
# 4    4 유관순   90
mode(exam[4,]) # list 


#################
## 3. 반복문
#################

# 1) 반복문 - for(변수 in 값){ 표현식 } # js의 forEach문과 동일하다

i <- c(1:10)
i

d <- numeric() # 빈 vector(숫자) # d의 자료형은 numeric으로 설정
# 변수를 선언할 때 자료형이 결정되는게 아니라(R에선 다 담을 수 있다)
# 값을 담을 때 결정되기 때문에 numeric()으로 저장하는 경우는 
# 숫자값을 담을 수 있는 변수로 초기화하는 개념이라고 보면 된다!! 

# js의 enhanced for문(=/=자바)과 동일하다 
for(n in i){ # 10회 반복 # i 변수 값을 n에 담아서 반복한다 
  print(n*10)
  print(n)
  d[n] <- n*2
}

d

for(n in i){
  if(n %% 2 != 0){
    print(n) # %% : 나머지 값 - 홀수만 출력.
  }
}

for(n in i){
  if(n %% 2 == 0){
    next # 다음 문장 skip -> 반복문 계속(자바의 continue 키워드와 동일.)
    # next는 다음 문장이 있어도 if와 else문을 빠져나와서 for문을 다시 돈다
  }else{
    print(n) # %% : 나머지 값 - 홀수만 출력.
  }
}

# 벡터 데이터 사용 예
score <- c(85, 95, 98)
name <- c("홍길동", "이순신", "강감찬")

i <- 1 # 첨자로 사용되는 변수
for(s in score){
  cat(name[i], " -> ", s, "\n")
  i <- i+1
}

# 2) 반복문 - while(조건){표현식} # 자바와 동일 
i = 0

while(i < 10){
  i <- i + 1
  print(i)
}


####################################################
# chapter04-2. 사용자 정의 함수와 내장 함수 
####################################################

## 1. 사용자 정의 함수

# 함수 정의 형식 # js의 익명함수와 동일하다 
# 변수 <- function([매개변수]){
#            함수의 실행문             
#         }

# 함수 호출
#  - 변수([매개변수])


# 매개변수가 없는 함수 예
f1 <- function(){
          cat("매개변수가 없는 함수")
      }

f1() # 함수 호출 방법 


# 매개변수가 있는 함수 예
f2 <- function(x){
         cat("x의 값 = ", x, "\n")
         print(x)
      }
# 입력 대기 칸에 값을 입력하는 경우는 그 값만 출력되지만
# ↓ 아래처럼 함수를 실행하는 경우는 함수 전체가 실행된다 
f2(10) # 실인수
f2(c(1:10)) # 벡터 # 매개변수는 2개 이상 입력할 수 있다. 
# js나 R은 매개변수에 다양한 자료형을 입력하기 때문에
# 매개변수에 여러 값을 넣을 수 있다.

# 리턴값이 있는 함수 예
f3 <- function(x, y){
          add <- x + y # 덧셈
          return (add)   # 결과 반환
          # return 1) 곧장 함수를 벗어나서 호출한 곳으로 복귀
          # 2) 값을 가지고/가지지 않고 호출한 곳으로 복귀
      }
# 매개변수가 1개인 함수에는 vector, array, list가 전달될 수 있지만
# 그건 하나의 변수가 자료형이 여러 값을 담는 자료형일 뿐인 거지
# 매개변수가 2개 혹은 10개가 되는게 아니다. 
# R은 모든 변수에 자료형을 별도로 표기하지 않기 때문에 값만 넣으면 된다 

add <- f3(10, 30)
add

# 기술 통계량을 계산하는 함수 정의 
# 파일 불러오기
getwd()
setwd("C:/workspaces/Rwork/data")

test <- read.csv("test.csv", header = T)
head(test); test

# A 컬럼 요약통계량, 빈도수 구하기.
summary(test) # 요약통계량.
table(test$A) # A 변수 대상 빈도 수.
# 1   2   3   4   5  => factor(text$A의 category. category를 vector로 표현한게 factor다) 
# 30 133 156  80   3
# table() : 빈도수를 반환하는 함수 
?table
max(test$A)   # 최대값
min(test$A)   # 최소값

length(test)  # 5

# 각 컬럼 단위 요약통계량과 빈도 수 구하기.
data_pro <- function(x){
  
  for(idx in 1:length(x)){
    cat(idx, '번째 컬럼의 빈도분석 결과')
    print(table(x[idx])) # index의 범주 빈도수를 return 
    cat('\n')
  }
  
  for(idx in 1:length(x)){
    f <- table(x[idx])
    cat(idx, '번째 컬럼의 최대값/최소값 \n')
    cat("max=", max(f), "min=", min(f), '\n')
  }
}

data_pro(test) # 함수 호출(test는 test.csv를 불러온 데이터)


# 분산과 표준편차를 구하는 함수 정의
z <- c(7, 5, 12, 9, 15, 6) # x 변량 생성
var_sd <- function(x){
  var <- sum((x-mean(x))^2) / (length(x)-1) # 표본분산
  # x-mean(x) : x에서 x의 평균을 뺀다 
  # 분산은 평균의 취약점을 보완해서 정의하는 개념
  # 분산은 데이터가 어떤 분포를 이루는지 표현한 그래프
  # 평균은 데이터의 분포를 명확하게 나타내지 못하기 때문이다 
  # 통계학과가 아니라면 분모에 length를 작성하면 된다(?) 
  sd <- sqrt(var)
  cat('표본분산:', var, '\n') # 분포도 
  cat('표본 표준편차:', sd, '\n')
}

var_sd(z)

# 결측치(NA) 데이터 처리
data <- c(10, 20, 5, 4, 40, 7, NA, 6, 3, NA, 2, NA)
data

mean(data) # NA # 중간에 NA가 끼어있기 때문에 평균도 NA 
# 샘플 데이터가 많지 않은 경우는 NA조차도 제외해서 입력하면
# 그마저도 데이터 양이 줄어들기 때문에 머신러닝같은 프로그램에선
# 샘플 데이터의 양이 절대적으로 중요하다
# 때문에 NA를 제거하는 방식보단 na.rm을 F로 설정해서 NA를 체크한 다음
# 유의미한 데이터로 채워서 다시 구동시키는 방식이 일반적이다. 
mean(data, na.rm = T) # 10.77778

# 구구단 출력 함수
gugudan <- function(i, j){
  for(x in i){
    cat("== ", x, "단 ==\n")
    
    for(y in j){
      cat(x, "*", y, "=", x*y, "\n")
    }
    
    cat("\n")
  }
}

i <- c(2:9) # 단 수 지정
j <- c(1:9) # 단 수와 곱해지는 수 지정

gugudan(i, j)

# 결측치 데이터 처리 함수
na <- function(x){
  # 1차 : NA 제거 
  # (NA가 전체 데이터의 0.1~0.3%면 제거해도 상관없지만
  # 그렇지 않으면 제거하는 것은 권고하지 않는다. 때문에 0이나 평균으로 대체) 
  print(x)
  print(mean(x, na.rm = T))
  
  # 2차 : NA를 0으로 대체
  data <- ifelse(!is.na(x), x, 0) # NA이면 0으로 대체.
  print(data)
  print(mean(data))
  
  # 3차 : NA를 평균으로 대체
  data2 <- ifelse(!is.na(x), x, round(mean(x, na.rm = T), 2)) # 평균으로 대체
  # round(mean(x, na.rm = T),2) : 데이터에서 na를 제거한 후
  # 평균을 mean()으로 구하고 round()로 소수점 2째자리까지 출력된다
  print(data2)
  print(mean(data2))
}

na(data) # 함수 호출
# data는 랜덤한 숫자 사이에 NA 값이 있는 vector다. 
# 결측치를 무조건 제거하면 정확한 통계량을 얻을 수 없으며, 
# 데이터가 손실될 수 있다.
# 때문에 NA를 그대로 둘지, 0으로 대체할지, 평균으로 대체할지는
# 분석에 사용할 데이터의 특성에 따라 달라진다. 

## 2. 주요 내장 함수

# 행 단위, 컬럼 단위 합계와 평균 구하기.

# 단계1 : 데이터 셋 불러오기
library(RSADBE) # 제품 출시 전후의 버그 레포팅 개수 
# 이 중 vector로 제공되는 데이터 셋이 "Severity_Counts" 
data(Bug_Metrics_Software) 
mode(Bug_Metrics_Software) # numeric 
class(Bug_Metrics_Software) # "xtabs" "table" (array((?))

Bug_Metrics_Software[,,1] # R은 행열면, 타 언어는 면행열. 
Bug_Metrics_Software[,,2]

# 단계2 : 소프트웨어 발표 전 행 단위 합계와 평균 구하기.
rowSums(Bug_Metrics_Software[,,1])
rowMeans(Bug_Metrics_Software[,,1])

# 단계3 : 소프트웨어 발표 전의 열 단위 합계와 평균 구하기.
colSums(Bug_Metrics_Software[,,1])
colMeans(Bug_Metrics_Software[,,1])

# 기술 통계량 관련 내장 함수 사용 예
seq(-2, 2, by = .2) # 0.2씩 증가
vec <- 1:10
vec

min(vec)
max(vec)
range(vec) # 1 10
mean(vec) # 55 / 10 = 5.5  
median(vec)
sum(vec)
sd(rnorm(10)) # sd() : 표준편차 구하기. rnorm() : 랜덤한 값(난수 발생) 
table(vec)    # table() : 입력한 값의 빈도수를 return 

# 난수(불규칙적인 값)와 확률 분포 관계 
# 단계1 : 정규분포(연속형)의 난수 생성
# 정규분포 : 주어진 데이터의 평균을 0으로 분산값을 1로 대응시켜 분포도를 만든 것
n <- 1000
r <- rnorm(n, mean = 0, sd = 1) 
r
?rnorm
# rnorm()의 인자를 이용해 1000개의 난수를 정규분포식으로 발생시킨다
hist(r) # 대칭성 
# 발생시킨 컴퓨터마다 그래프는 다를 수 있지만
# 0을 기준으로 하는 분포도는 유사하다. 

# 단계2 : 균등분포(연속형)의 난수 생성
n <- 1000
r2 <- runif(n, min = 0, max = 1) # 0 < r2 < 1
# runif() : 균등분포의 난수를 생성한다 
hist(r2)


# 단계3 : 이항분포(이산형) 난수 생성
# rbinom() : 이항분포의 난수를 생성(r binary nom)
n <- 20
rbinom(n, 1, prob = 1/2)
rbinom(n, 2, 0.5)
rbinom(n, 10, 0.5)
n <- 1000
rbinom(n, 5, prob = 1/6)

# 단계4 : 종자값(seed)으로 동일한 난수 생성.
# R의 seed() = Java의 random() 
# 랜덤한 수라면 숫자가 중복되면 안된다. 그래서 아주 미세한 값을
# 기준으로 잡는데, 일반적인 프로그래밍 언어는 
# 현재 시간을 1000m/s(0.0001초)로 읽어온 값으로 설정한다
# 현재 시간으로 잡는 이유는 현재 진행형이고 돌리지 않는 이상 다시 그 값을 가질 수 없다
# 때문에 랜덤한 값을 추출할 때 중복 값이 나올 경우의 수가 아주 줄어든다
# 현재 시간 값이 seed()다. seed()를 고정시키면 모든 컴퓨터가 똑같은 값을 발생시킨다 
rnorm(5, mean=0, sd=1)
?rnorm
set.seed(123) # seed 값을 고정시키면 난수라 하더라도 값이 똑같아진다
# 정해진 알고리즘에 의해 발생되는 난수가 seed는 고정된다면 컴퓨터마다 똑같아진다
# 하지만 seed가 현 시간처럼 계속 바뀌는 값이라면 모든 사람이 다른 값을 가진다. 
rnorm(5, mean=0, sd=1)

set.seed(345)
rnorm(5, mean=0, sd=1)

# seed와 rnorm의 연관성 
# https://www.workingus.com/forums/topic/r-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%A8-set-seedn%EC%97%90-%EA%B4%80%ED%95%B4%EC%84%9C-%EC%A7%88%EB%AC%B8%ED%95%A9%EB%8B%88%EB%8B%A4/

# 수학 관련 내장함수 사용 예
vec <- 1:10 # combine이 생략된 형태(워낙 많이 쓰이기 때문에)
prod(vec) # 벡터 원소들의 곱 # prod() : 입력값들을 곱한다 
factorial(3) # factorial() : 입력값을 하나씩 감소하면서 곱한다(3x2x1)
abs(-5) # abs() : -붙여서 출력
sqrt(16) # sqrt() : 루트

log(10) # 10의 자연로그(밑수가 e) # 2.302585
log10(10) # 10의 일반로그(밑수가 10) # 1

# 집합연산 관련 내장 함수 사용 예
x <- c(1, 3, 5, 7, 9)
y <- c(3, 7, 8)

union(x, y) # 합집합
setequal(x, y) # 동일성 체크
intersect (x, y) # 집합 x와 y의 교집합
setdiff(x, y)# x의 모든 원소 중 y에는 없는 x와 y의 차집합






