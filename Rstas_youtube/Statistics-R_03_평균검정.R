
###############################
## R을 이용한 통계데이터분석 ##
## (곽기영, 도서출판 청람)   ## 
###############################

####################
## 제3장 평균검정 ##
####################

###############
## 3.1 t검정 ##
###############

# t-value 계산법 (표본 평균- 모집단 평균)/표준오차
# 표준오차 = 표준분포 / n의 제곱근

t <- (135-115)/(25/sqrt(20))
t

# pt: t분포 누적확률
pt(3.58, df=20-1, lower.tail=FALSE)*2 # 양측검정을 해야하므로 *2
(1 - pt(3.58, df=19))*2 

qt(0.025, df=19, lower.tail=FALSE)
qt(0.975, df=19)

# 모집구간의 신뢰구간 (95%)
135-2.09*(25/sqrt(20))
135+2.09*(25/sqrt(20))

qt(0.005, df=19, lower.tail=FALSE)

#########################
## 3.2 일표본 평균검정 ##
#########################

library(MASS)
str(cats) # 고양이 성별에 따른 몸무게, 심장무게

# 귀무가설: 고양이 평균 몸무게는 2.6kg이다
# 대립가설: 고양이 평균 몸무게는 2.6kg가 아니다.

# 평균 2.6kg가 아니다 -> O -> 대립가설 채택(2.6kg가 아니다)
t.test(x=cats$Bwt, mu=2.6)

# 평균 2.7kg가 아니다 -> X -> 귀무가설 채택(2.7kg이다)
t.test(cats$Bwt, mu=2.7)

?t.test
t.test(cats$Bwt, mu=2.6, alternative="greater")

cats.t <- t.test(cats$Bwt, mu=2.6)
str(cats.t)

cats.t$p.value
cats.t$conf.int

t.test(cats$Bwt, mu=2.6, conf.level=0.99, alternative='two.sided')

# [ 비율에 대한 검정 ]
# 조건: 시행결과가 성공 or 실패 두가지만 존재할 때
# 상황: 야구팀 승률 분석
# 30경기 중 18승일 때 승률이 50%가 넘는다.
prop.test(x=18, n=30, p=0.5, alternative="greater")




###########################
## 3.3 독립표본 평균검정 ##
###########################

t.test(formula=Bwt ~ Sex, data=cats)

# [그림 3-6]
bars <- tapply(cats$Bwt, cats$Sex, mean)
lower <- tapply(cats$Bwt, cats$Sex, function(x) t.test(x)$conf.int[1])
upper <- tapply(cats$Bwt, cats$Sex, function(x) t.test(x)$conf.int[2])

windows(width=4.0, height=5.5)
#install.packages("gplots")
library(gplots)
barplot2(bars, space=0.4, ylim=c(0, 3.0),
         plot.ci=TRUE, ci.l=lower, ci.u=upper, ci.color="maroon", ci.lwd=4, 
         names.arg=c("Female", "Male"), col=c("coral", "darkkhaki"),
         xlab="Cats", ylab="Body Weight (kg)", 
         main="Body Weight by Sex\nwith Confidence Interval")

Bwt.f <- cats$Bwt[cats$Sex=="F"]
Bwt.m <- cats$Bwt[cats$Sex=="M"]
t.test(Bwt.f, Bwt.m)

# 폐질환자중 흡연자 수
smokers  <- c(83, 90, 129, 70)
patients <- c(86, 93, 136, 82)

prop.test(x=smokers, n=patients)

###########################
## 3.4 대응표본 평균검정 ##
###########################

str(sleep)
# extra: 변화
# group: 약 종류
# ID : 사람 구별용
# --> 한 사람이 1,2 약 모두 복용하므로 서로 짝을 이루는 대응표본이 됨.
sleep[seq(1, 20, 2), ]

t.test(extra ~ group, data=sleep, paired=TRUE)

# 롱포맷, 와이드 포맷
# t.test에서는 롱포맷이어야 함

# 와이드 포맷으로 바꾸는 법 spread(), dcasts

# install.packages("tidyr")
library(tidyr)
sleep.wide <- spread(sleep, key=group, value=extra)
sleep.wide

#install.packages("reshape2")
library(reshape2)
sleep.wide <- dcast(sleep, ID ~ group, value.var="extra")
sleep.wide

t.test(sleep.wide$'1', sleep.wide$'2', paired=TRUE)
