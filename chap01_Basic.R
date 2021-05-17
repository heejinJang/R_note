# chap01_Basic : 주석문

# R 패키지 보기 
dim(available.packages())

# R 패키지 목록 보기 
available.packages()

# R Session 보기
sessionInfo()

# stringr 패키지 설치
install.packages("stringr")

# 설치된 패키지 확인
installed.packages()

# 패키지 메모리 로드
library(stringr)

# 현재 로드된 패키지 확인
search()

# 패키지 로드 여부 확인 및 다운받은 패키지 로드
library(blm)
require(blm) 
#library는 패키지가 없을 때 에러메세지를 띄우지만
#require는 패키지가 없어도 경고창만을 띄우기 때문에 library를 보통 사용한다 

# 패키지 삭제
remove.packages("stringr")

# 기본 데이터 셋 보기
data()

# 기본 데이터 셋으로 히스토그램 그리기
# 단계1 : 빈도수를 기준으로
hist(Nile)

# 단계2 : 밀도를 기준으로
hist(Nile, freq = F)
# freq 값은 설정안하면 T가 기본. F면 density(밀도) 형태로 계산한다.
# 같은 메서드라도 매개변수를 달리 해서 값이 달라지는 것이 R과 R의 패키지 특성이다.

# 단계3 : 단계2의 결과에 분포 곡선을 추가
lines(density(Nile))

# 히스토그램을 파일로 저장하기
par(mfrow=c(1,1))
pdf("C:\\workspaces\\Rwork\\output\\batch.pdf")
hist(rnorm(20))
dev.off()

# 스칼라(scalar) 변수(하나의 변수에 하나의 값만 저장된 경우) 사용 예제
var1 <- 0 # 변수에 값 저장
var1  # 변수 출력 
var1 <- 1
var1
var2 <- '안녕하세요'
var2

# '변수.멤버' 형식의 변수 선언
goods.code <- 'a001'
goods.name <- '냉장고' # 객체 지향에서 참조변수를 정의 후 .으로 필드에 접근한 것과 유사
goods.price <- 850000
goods.des <- '최고 사양, 동급 최고 품질'

# 벡터 변수 사용 예
names <- c('장희진', '김다은', '김윤정')
names[3]

# 함수
sum(10, 20, 30)
sum(1000000, 30, NA) # NA
sum(1000000, 30, NA, na.rm = T) 
# na.rm = T(데이터가 빠져있거나 범위를 크게 벗어나는 데이터 셋은 제외하고 연산한다)
# sum()은 매개변수로 key&value 형태로 값을 넣을 수 있다

# 자료형 확인(문자열)
string <- '장희진'
is.character(string)
is.integer(string)

# 자료형 확인(숫자)
int <- 589
int

# 자료형 확인 결과값을 변수에 저장할 수도 있다
x <- is.numeric(int)
x

# is.logical() : 값이 true or false 값을 가지는 변수인지 확인
is.logical(x)

# 작업한 변수 확인
ls()

# 문자 원소를 숫자 원소로 형 변환하기
x <- c(1, 2, '3')
x
result <- x * 3 # error(문자열과 숫자는 연산을 수행할 수 없다)
# 문자와 숫자를 벡터로 함께 저장하면 숫자 원소를 문자 원소로 형변환한다
# 자바스크립트는 문자형 숫자값이 있으면 숫자로 형변환해서 연산을 수행한다
result <- as.numeric(x) * 3
# 벡터의 모든 원소를 숫자형으로 바꾼다
result # 3 6 9

# 복소수 자료 생성과 형변환
z <- 5.3 - 3i
Re(z)
Im(z)
is.complex(z)
as.complex(333) # 강제 복소수 형변환 : +0i

# 스칼라 변수의 자료형과 자료 구조 확인
mode(int) # "numeric"
mode(string) # "character"
mode(x) # "logical"
class(int) # "numeric"
class(string) # "character"
class(x) # "logical"
# 자료형이나 자료 구조는 동일한 타입을 반환한다

# 문자 벡터와 그래프 생성
gender <- c("woman", "man", "non-binary", "woman", "woman")
gender
plot(gender) # error
# plot은 빈도수를 체크해서 시각화된 결과(분포도, 꺾은선 등)를 보여준다

# as.factor() 함수를 이용해서 
# 요인형(factor, 문자형 변수 중 특정 수준 값만 가지는 데이터)으로 변환
Ngender <- as.factor(gender)
Ngender # Ngender는 factor형
table(Ngender) # Ngender를 table에 넣으면 개수로 반환한다
#non-binary man  woman 
#     1       1     3

#factor형 변수로 차트 그리기
plot(Ngender)
mode(Ngender) # mode() : 자료형 반환
class(Ngender) # class() : 자료구조 반환 
# 스칼라 변수는 하나의 변수에 동일한 자료형과 자료 구조로 반환하는데
# 벡터 이상의 자료형이나 자료 구조는 
# mode는 하나하나의 자료형(개수의 형태)으로 요인형을 반환한다 

# Factor Nominal(default) 변수 내용 보기
Ngender # 순서에 무의미 값(알파벳 순 정렬)

# factor() 함수를 이용해서 factor형 변환
# 자바에선 메서드의 값으로 전달받는걸 매개변수라고, 그 안의 값을 인자(argument)라 부른다
args(factor) # factor를 args의 인자로 전달하면 factor()의 매개변수 정보를 보여준다
# R은 매개변수의 개수나 자료형에 대해 융통성이 있고 엄격하지 않다.

Ogender <- factor(gender, levels = c('woman','non-binary','man'), ordered = T)
Ogender
 # 순서가 없는 요인과 순서가 있는 요인형 변수로 차트그리기
par(mfrow=c(1,2))
plot(Ngender)
plot(Ogender)

# as.Date() 함수를 이용한 날짜형 변환
as.Date('21/05/10', '%y/%m/%d')
mode(as.Date('21/05/10', '%y/%m/%d')) # "numeric"
class(as.Date('21/05/10', '%y/%m/%d')) # "Date"

dates <- c('02/28/20', '02/30/20', '03/01/20')
dates
as.Date(dates, '%m/%d/%y') # 2월달은 30일이 존재하지 않기 때문에 NA

# 현재 날짜와 시간 확인
Sys.time()

# strptime() 함수를 이용한 날짜형 변환
sdate <- '2020-05-15 12:30:05'
class(sdate) # "character"
today <- strptime(sdate, format = '%Y-%m-%d %H:%M:%S')
# strptime()을 그냥 출력하면 안됨. 변수에 담아서 class()해야됨
class(today) # "POSIXlt" "POSIXt" : 표준화된 시간의 정보를 피드백

#4자리 연도와 2자리 연도 표기의 예
strptime('30-11-2019', format = ('%d-%m-%Y'))
strptime('30-11-19', format = ('%d-%m-%y'))
# 결과는 동일하다

# 함수 파라미터 보기
args(max) # max() 함수의 파라미터 확인 
# args() : 함수의 파라미터에 대한 정보를 반환(...은 자바스크립트와 마찬가지로 입력 매개변수를 가변적으로 처리받는다는 뜻(무한정)) 
# na.rm은 na로 세팅된 값을 rm(remove)하라는 것이고, 그것이 FALSE인건 제거하지 않는다는 것)
max(10, 20, 30, 40, 50, NA, NA)
# R은 빈 값을 NA로 채워넣으면 하나라도 NA가 들어있을 때 NA가 반환된다
max(10, 20, 30, 40, 50, NA, NA, na.rm = T)
# 그 중 na.rm 값을 True로 설정하면 NA를 제외하고 연산을 수행한다

# seq 함수 사용 예를 보여주는 example() 함수
example(seq)

?seq
help(seq)
