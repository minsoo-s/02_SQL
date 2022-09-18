
###############################
## R을 이용한 통계데이터분석 ##
## (곽기영, 도서출판 청람)   ## 
###############################

##########################################
## 제1장 데이터 요약 (1.범주형 2.연속형) ##
##########################################

##########################
## 1.1 빈도표를 이용한 범주형 변수 요약 ##
##########################

# table(), which.max(), prop.table(), mean(), xtabs(), margin.table(), addmargins(), CrossTable()

library(MASS)
str(survey)
levels(survey$Smoke)

# 빈도표 생성
frqtab <- table(survey$Smoke)
frqtab
class(frqtab)
frqtab[2]

# 최빈값 구하기
frqtab==max(frqtab)
frqtab[frqtab==max(frqtab)]
names(frqtab[frqtab==max(frqtab)])

which.max(frqtab)
frqtab[which.max(frqtab)]
names(frqtab[which.max(frqtab)])

# 비율 테이블 생성
frqtab.prop <- prop.table(frqtab)
frqtab.prop
frqtab.prop["Never"]
frqtab.prop * 100

# 평균값 구하기
survey$Smoke =='Never'
mean(survey$Smoke=="Never", na.rm = TRUE)

# 식욕부진환자의 치료 전, 후 비교
head(anorexia)
mean(anorexia$Postwt > anorexia$Prewt)

# 동물 두뇌무게 - 평균 > 2*표준편차 인 데이터 평균
mean(abs(mammals$brain-mean(mammals$brain)) > 2*sd(mammals$brain))

# SP500 전일보다 증가한 비율 구하기 diff: 연속된 두 수의 차이를 계산해서 반환
head(SP500)
diff(SP500)
mean(diff(SP500) > 0)


# 교차표 만들기 (VCD)
# install.packages("vcd")
library(vcd)
str(Arthritis)
levels(Arthritis$Treatment)
levels(Arthritis$Improved)

# table(행변수. 열변수)
crosstab <- table(Arthritis$Improved, Arthritis$Treatment)
crosstab
crosstab["Marked", "Treated"]

# dnn 행열 이름 지정
table(Arthritis$Improved, Arthritis$Treatment, dnn=c("Impreoved", "Treatment"))

# ctabs로 테이블 교차표 생성
crosstab <- xtabs(~ Improved + Treatment, data=Arthritis)
crosstab

# margin.tavble : 행 or 열의 합 계산
# prop.tabel: 행 or 열별 비율의 합 계산

margin.table(crosstab, margin=1) # 행별 합 1
prop.table(crosstab, 1) # 행별 비율 합

margin.table(crosstab, margin=2) # 열별 합 2
prop.table(crosstab, 2) # 열별 비율 합 2

prop.table(crosstab) # 전체 각 셀의 비율

# addmargins : 기존의 셀 값 + 행/열별 합계 모두 표시
addmargins(crosstab, margin=1)
addmargins(crosstab, margin=2)
addmargins(crosstab)

addmargins(prop.table(crosstab, 2), 1)
addmargins(prop.table(crosstab, 1), 2)


# install.packages("gmodels")
library(gmodels)

# CrossTable : 입체적 테이블 형태
CrossTable(Arthritis$Improved, Arthritis$Treatment, prop.chisq=FALSE, 
            dnn=c("Improved", "Treatment"))

# 다차원 테이블 방식(1,2,3)
multab <- table(Arthritis$Improved,Arthritis$Sex,Arthritis$Treatment)
multab
multtab <- with(Arthritis, table(Improved, Sex, Treatment))
multtab
multtab <- xtabs(~ Improved + Sex + Treatment, data=Arthritis)
multtab

# ftable : 행.열 지정한 다차원 테이블
ftable(multtab)
ftable(multtab, row.vars=c(2, 3))

# ftable로 바로 다차원테이블 만들기, row.vars = 행요소 선택
ftable(Arthritis[c("Improved", "Sex", "Treatment")], row.vars=c(2, 3))

# 다차원 테이블 각 차원에 대한 빈도합 계산
margin.table(multtab, 1)
margin.table(multtab, 2)
margin.table(multtab, 3)

margin.table(table(Arthritis$Improved, Arthritis$Sex, Arthritis$Treatment), 1)

margin.table(multtab, c(1, 3))

ftable(prop.table(multtab, c(2, 3)))

ftable(addmargins(prop.table(multtab, c(2, 3)), 1))


#-------------------------------------------------------------------------

##########################
## 1.1 연속형 변수 요약 ##
##########################

# median(), quantile(), mean(), summary(), range(), var(), sd(), stat.desc(), describe(), tapply(), aggregate(), by(), describeBy().

# 중심 경향지표
# - 중위수(중간수), 백분위수, 사분위수, 평균

# 변동성지표
# - 범위(max-min), 사분위 범위(3분위-1분위). 분산(관측값~평균 떨어진 정도) ,표준편차(분산의 제곱근)

library(MASS)
str(survey)
str(survey$Pulse)
# NA가 하나라도 있으면 NA를 반환
median(survey$Pulse)
median(survey$Pulse, na.rm=TRUE)

# 벡분위수 구하기 quantile()(probs 5%에 속하는 백분위수 )
quantile(survey$Pulse, probs=0.05, na.rm = TRUE)

quantile(survey$Pulse, 0.5, na.rm=TRUE) # median과 같은

quantile(survey$Pulse, c(0.05, 0.95), na.rm=TRUE)

?quantile
# probs = seq(0,1,0.25) 가 디폴트인 것을 확인 가능
# 아무 설정하지 않을 시, 해당하는 5개 인수 출력됨. 아래에서 확인
quantile(survey$Pulse, na.rm=TRUE)

# 맥박수가 80 이하인 응답자 비율
mean(survey$Pulse <= 80, na.rm=TRUE)

# 전체 응답자 맥박 수 평균
mean(survey$Pulse, na.rm=TRUE)
median(survey$Pulse, na.rm=TRUE)


#
str(iris)

summary(iris$Sepal.Width)

summary(iris$Species)

# 범주형 변수를 문자형 변환 후 확인
summary(as.character(iris$Species))

summary(iris)

# 리스트 summary: 길이, 형태만 출력
iris.lst <- as.list(iris)
summary(iris.lst)

# lapply : 리스트를 summary 확인
lapply(iris.lst, summary)

# range: 최대값, 최소값 확인
range(survey$Pulse, na.rm=TRUE)

# var: 분산, sd:표준편차
var(survey$Pulse, na.rm=TRUE)
sd(survey$Pulse, na.rm=TRUE)



str(mtcars)

#install.packages("pastecs")
library(pastecs)

# stat.dese : 구체적인 summary(pastecs 패키지)
stat.desc(mtcars[c("mpg", "hp", "wt")])

#install.packages("psych")
library(psych)

# describe: 구체적인 summary  왜도, 첨도 확인가능(psych패키지)
describe(mtcars[c("mpg", "hp", "wt")])



str(survey)
# 범쥐 종류 확인
levels(survey$Exer)

# 테이블 형태 (2가지 열,인덱스 지정, 함수 지정)
tapply(survey$Pulse, INDEX=survey$Exer, FUN=mean, na.rm=TRUE)

tapply(survey$Pulse, survey$Sex, mean, na.rm=TRUE)

# 두개의 집단 변수가 인덱스로 올 시 리스트 사용
tapply(survey$Pulse, list(survey$Exer, survey$Sex), mean, na.rm=TRUE)

# aggregate(tapply와 같은 결과출력)
aggregate(survey$Pulse, by=list(Exercise=survey$Exer), FUN=mean, na.rm=TRUE)


# 두개의 집단 변수 사용하기
aggregate(survey$Pulse, list(Exercise=survey$Exer, Sex=survey$Sex), 
          mean, na.rm=TRUE)

# 계산할 연속형 변수를 2개 사용하기
aggregate(survey[c("Pulse", "Age")], 
          list(Exercise=survey$Exer), mean, na.rm=TRUE)

# aggregate는 사용자 정의함수 사용가능
myStats <- function(x, na.rm=FALSE) {
  if (na.rm) x <- x[!is.na(x)]
  n <- length(x)
  mean <- mean(x)
  sd <- sd(x)
  skew <- sum((x-mean)^3/sd^3)/n
  kurt <- sum((x-mean)^4/sd^4)/n - 3
  return(c(n=n, mean=mean, sd=sd, skewness=skew, kurtosis=kurt))
}
aggregate(survey[c("Pulse", "Age")], 
          list(Exercise=survey$Exer), myStats, na.rm=TRUE)

# by도 수치,범주형 변수, 함수 시용가능
by(survey[c("Pulse", "Age")], INDICES=list(Exercise=survey$Exer), FUN=summary)

aggregate(survey[c("Pulse", "Age")], list(Exercise=survey$Exer), summary)

# by함수도 사용자정의함수 사용가능
by(survey[c("Pulse", "Age")], list(Exercise=survey$Exer), 
    function(x) sapply(x, myStats, na.rm=TRUE))

# describeBY도 수치,범주,함수 가능
library(psych)
describeBy(survey[c("Pulse", "Age")], group=list(Exercise=survey$Exer))

# describeBY는 사용자정의함수 불가능
describeBy(survey[c("Pulse", "Age")], group=list(Exercise=survey$Exer), summary) #error

