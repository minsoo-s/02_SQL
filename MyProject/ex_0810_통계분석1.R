# summary에서 Median과 Mean이 가까울수록 정규분포에 근사
# 반대로 멀면 왜도가 크다고 할 수 있다.

windows(width = 7, height = 5)

# 0,5확률를 100개 10번 던져보기
v <- rbinom(n=10, size=100, prob=0.4)
hist(v,col = 'orange', breaks=20)

set.seed(2022)
v <- runif(n = 100000, min = 0, max = 100)
hist(v,col='tomato', breaks=20)

mean(v)
sd(v)

v <- rnorm(n=10000, mean = 50, sd=20)
hist(v, col='violet', breaks=20)

x <- seq(0,100,length = 100)
y <- dnorm(x,mean=50,sd=20)
plot(x,y,type='l',
     col='tomato', lwd =3 )

x <- seq(0,100,length = 100)
y <- dunif(x,min=0,max=100)
plot(x,y,type='l',
     col='tomato', lwd =3 )

x <- seq(140,200,length = 100)
y <- dnorm(x,mean=170,sd=10)
plot(x,y,type='l',
     col='tomato', lwd =3 )

#연습문제 

x <- seq(10000,50000,length=200)
y <- dnorm(x,mean =30000, sd=10000)
plot(x,y, type='l',
     col='tomato',lwd=3)

#누적값
pnorm(35000,30000,10000)
pnorm(25000,30000,10000)
pnorm(35000,30000,10000)-pnorm(25000,30000,10000)

# 평균에서 분산 +-1범위에 68% 존재
pnorm(1)-pnorm(-1)
pnorm(1,0,1)-pnorm(-1,0,1)
# 평균에서 분산 +-2범위에 95% 존재
pnorm(2,0,1)-pnorm(-2,0,1)
# 평균에서 분산 +-2.56범위에 99% 존재
pnorm(2.56)-pnorm(-2.56)

#학생 100명일 때 내 등수 계산(평균 68점, 분산 10)
pnorm(87, mean = 68,sd = 10)
(1-pnorm(87, mean = 68,sd = 10))*100

# lower.tail 순서 뒤집기
pnorm(87, mean = 68,sd = 10,lower.tail = F)

pnorm(70,60,10, lower.tail = F)
pnorm(80,70,20, lower.tail = F)


x <- rbinom(10000, size=100, prob=0.5)
hist(x,col='steelblue',breaks=20)
curve(dnorm(x,50,5), 30,37, col='tomato',
      add= T, lwd=3,lty=2)


# 분포종류 -> 유의수준 설정 -> 95% 밖에 있으면 유의미

# 실습-------------------------------------
library(MASS)
height <- na.omit(survey$Height)
length(height)
hist(height,col='skyblue',breaks=20)

mean(height)
sd(height)

# 샘플링
X.bar <- c()
for (i in 1:10000){
  samp <- height[sample(1:209,size=30)]
  X.bar[i] <- mean(samp)
  X.sd[i] <- sd(samp) 
}
hist(X.bar, col='skyblue',
     breaks = 20, prob = T)
x <- seq(160,180,length = 200)
curve(dnorm(x,mean(height),sd(X.bar)), 
      160, 180, col='tomato',
      add= T, lwd=3, lty=2)

X.bar
X.sd



x.1 <- rnorm(n=5000, mean = 70, sd = 5)
x.2 <- rnorm(n=5000, mean = 50, sd = 5)
x <- c(x.1, x.2)
hist(x, col='skyblue',breaks=20)


X.bar <- c()
for (i in 1:10000){
  samp <- x[sample(x,size=30)]
  X.bar[i] <- mean(samp) 
  X.sd[i] <- sd(samp) 
}
hist(X.bar, col='skyblue',
     breaks = 20, prob = T)
x.samp <- seq(30,90,length = 200)
curve(dnorm(x.samp,mean(x),sd(X.bar)), 
      30, 90, col='tomato',
      add= T, lwd=3, lty=2)


cor(iris[,-5])

cor.test(iris$Petal.Width,iris$Petal.Length)

binom.test(x= 60, n = 100, p = 0.5)
qnorm(p = 0.5, mean = 50, sd = 10)
qnorm(p = 0.68, mean = 50, sd = 10)

qnorm(p = 0.975, mean = 50, sd = 10)
qnorm(p = 0.025, mean = 50, sd = 10)

qnorm(p = 0.005, mean = 50, sd = 10)
qnorm(p = 0.995, mean = 50, sd = 10)

# pnorm, qnorm 서로 구하는 관계
pnorm(75.75829, mean = 50, sd = 10)
pnorm(24.24171, mean = 50, sd = 10)
pnorm(69.59964, mean = 50, sd = 10)
pnorm(30.40036, mean = 50, sd = 10)

binom.test(x =65, n=100, p=0.5)

binom.test(x =60, n=100, p=0.5, conf.level=0.99)

# 정규성 테스트 (shapiro.test)
shapiro.test(survey$Height)
hist(survey$Height)

shapiro.test(survey$Age)
hist(survey$Age)

shapiro.test(iris$Petal.Length)
shapiro.test(mtcars$mpg)


qqnorm(survey$Height,col='skyblue')
qqline(survey$Height,col='tomato',lwd=3)

qqnorm(survey$Age,col='skyblue')
qqline(survey$Age,col='tomato',lwd=3)


df <- read.csv('../FirstMiniProject/HousePrices.csv')
shapiro.test(df$GarageArea)
shapiro.test(df$GarageCars)
shapiro.test(df$MSSubClass)
shapiro.test(df$OverallQual)

# df(degree of freedom) : 자유도
v <- rt(n =10000, df = 29) 
hist(v,col='steelblue', prob=T)

x <- seq(-4,4,length=200)
#자유도선그리기
curve(dt(x, df=29),min= -4,max = 4,
      add=T,
      col='tomato',lwd=3, lty=2)
#정규분포그리기
curve(dnorm(x),-4,4,
      add =T,
      col ='violet',lwd=5,lty=4)

# pt:누적분포함수(q확률변수, df자유도)
pt(q =2.04523, df=19)
pt(q =0.975, df=29)
# qt는 누적분포함수의 역함수
qt(p = 0.975, df=29)
qt(p = 0.995, df=29)


# t-test실습(종속:수치, 독립:범주) 
str(cats)

library(MASS)
table(cats$Sex)

mean(cats$Bwt)
tapply(cats$Bwt, 
       INDEX = list(Sex=cats$Sex), 
       mean)

# conf.level: 신뢰구간
t.test(Bwt~ Sex, data=cats,conf.level=0.99)


str(sleep)
t.test(extra~group, data =sleep, paired = T)



