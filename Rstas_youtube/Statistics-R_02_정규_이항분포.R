
###############################
## R을 이용한 통계데이터분석 ##
## (곽기영, 도서출판 청람)   ## 
###############################

###############################
## 제2장 가설검정과 확률분포 ##
###############################

##################
## 2.2 확률분포 ##
##################

# [확률분포 관련 R함수 ]
# d: 확률밀도함수 -> 주어진 값이 범위에서 존재할 확률
# p: 확률누적함수 -> 주어진 값까지 누적된 확률
# q: 백분위수함수 -> 해당 백분위의 해당하는 값
# r: 랜덤생성함수 -> 범위의 랜덤값 추출
#-----------------
# binom: 이항분포 : 횟수, size, 확률 
# norm : 정규분포 : 값, 평균, 분산
# t    : t - 분포
# f    : f - 분포
# chisq: x^2 분포
# unif : 균일분포


# 사건발생 횟수, 시행횟수, 확률
dbinom(7, size=10, prob=0.5) # 동전 10번 던질 때 7번 앞면 나올 확률

# 7번 이하 나타날 확률
pbinom(7, size=10, prob=0.5)
sum(dbinom(0:7, size=10, prob=0.5))

# 8번 이상 나타날 확률(lower.tail=FALSE -> 반대 확률)
pbinom(7, size= 10, prob=0.5, lower.tail=FALSE) 

# 4번 이상 7번 이하 발생활 확률
pbinom(7, size= 10, prob=0.5) - pbinom(3, size=10, prob=0.5)
pbinom(c(3, 7), size=10, prob=0.5)
diff(pbinom(c(3, 7), size=10, prob=0.5))

set.seed(1)
# 랜덤 이항분포 함수 
# 생성할 난수 갯수, 횟수, 확률 
rbinom(1, size=10, prob=0.5)
rbinom(5, size=10, prob=0.5) # 10번 단위로 5회 던졌을 때 각 회마다 나온 랜덤횟수

# 110 이하일 정규분포(평균100,표준편차=15)
pnorm(110, mean=100, sd=15)
pnorm(110, mean=100, sd=15, lower.tail=FALSE)

pnorm(0)
pnorm(0, mean=0, sd=1)
dnorm(0, 100,10)
dnorm(110, mean=100, sd=10)

# 분포에서 90~110 사이 누적비율 구하기
pnorm(110, mean=100, sd=15) - pnorm(90, mean=100, sd=15)
diff(pnorm(c(90, 110), mean=100, sd=15))

# 전체 비율에서 0.05에 대응하는 값
qnorm(0.05, mean=100, sd=10)

qnorm(0.95, mean=100, sd=10)

qnorm(c(0.05, 0.95), mean=100, sd=10)

qnorm(0.025)
qnorm(0.975)

qnorm(c(0.025, 0.975))

set.seed(1)
rnorm(1, mean=100, sd=15)
rnorm(5, mean=100, sd=15)
rnorm(1)
rnorm(5)

# rnorm에서 평균에 벡터를 줄 수 있음.
rnorm(3, mean=c(-10, 0, 10), sd=1)

rnorm(6, mean=c(-10, 0, 10), sd=1)

?Binomial
?Normal
?TDist
?FDist
?Chisquare
?Uniform

# 정규분포 확인 방법(1): shapiro.test
# 0.05보다 커야 정규분포로 가정할 수 있음.
set.seed(123)
shapiro.test(rnorm(100, mean=100, sd=10))
shapiro.test(runif(100, min=2, max=4))

# 정규분포 확인 방법(2): qqnorm -> qqplot
# [그림 2-3]
windows(width=7.5, height=5.5)
par("mar")
old.par <- par(mfrow=c(1,2))
set.seed(123)
qqnorm(rnorm(100, mean=100, sd=10), col="blue", 
       main="Sample from Normal Distribution")
qqline(rnorm(100, mean=100, sd=10))


qqnorm(runif(100, min=2, max=4), col="red", 
       main="Sample from Uniform Distribution")
qqline(runif(100, min=2, max=4))
par(old.par)

