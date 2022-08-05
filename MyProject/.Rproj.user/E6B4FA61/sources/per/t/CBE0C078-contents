# R기초 2022.08.04(목)--------------------------------
3 + 4
print('HELLO, R!')
X = 3
x = 3

# (<- 단축키) : 'alt' + '-'
x <- 3
3 -> y
x <- 3
y <- 5  
z<-  z + y  

getwd()

plot(iris)

# 모를 때
?iris

View(iris)



# 패키지 설치. library() 는 없는 패키지 설치할 지 물어봄. 놓치면 install.packages("")
library(cowsay)
say('안녕,난 주니온이야!')
say("안녕", by = "chicken")
say("병준 바보" , by="facecat")

plot(mtcars)

str(cars)
?cars

plot(cars$speed,cars$dist, 
     col ="tomato",
     pch = 19)

# 연습문제 -----------------------------------------------------------#

#[연습문제 2.1]
plot(iris$Species,
     col = "tomato",
     main = "품종의 막대그래프프",
     xlab = "품종",
     ylab = "개수")

# [연습문제 2.2]
# 꽃잎의 너비(Petal.Width)에 대해서 다음 통계량을 구하시오.

# 평균
mean(iris$Petal.Width)
# 분산
var(iris$Petal.Width)
# 표준편차
sd(iris$Petal.Width)

# 꽃잎의 너비(Petal.Width)에 대해서 히스토그램을 그려보시오.
# - 히스토그램의 색을 변경해보시오.
# - 제목과 축의 라벨을 변경해보시오.
hist(iris$Petal.Width,
     col = "tomato",
     main ="꽃잎의 너비에 대한 히스토그램",
     xlab = "꽃잎의 너비",
     ylab = "빈도수")

# [연습문제 2.3]
# mtcars 데이터셋에서
# - 마력(hp)의 히스토그램을 그려보시오.
# - 히스토그램에서 축의 범위를 바꿔보시오. 𝑥축:c(0, 400), 𝑦축: c(0, 12)3
hist(mtcars$hp,
     xlim = c(0,400),
     ylim = c(0,12))

# mtcars 데이터셋에서
# - 마력(hp)과 연비(mpg)의 관계를 나타내는 산점도를 그려보시오.
# - 산점도에서 점의 색과 모양을 여러 가지로 바꿔보시오.
plot(mtcars$hp,mtcars$mpg,col='tomato',pch='+')

# [연습문제 2.4] cars
# - 변수와 관측값의 개수는 각각 얼마인가?
#   ● speed, dist 변수에 대해서 다음 통계량을 각각 구해보시오.
# - 평균, 중앙값, 최대값, 최소값, 1 사분위 값, 3 사분위 값
#   ● speed와 dist 변수의 관계를 나타내는 산점도를 그려보시오.
# - 산점도에서 점의 색과 모양을 바꿔보시오.
# - 산점도의 세로축과 가로축의 범위를 바꿔보시오.

str(cars)
summary(cars$speed)
summary(cars$dist)
plot(cars$speed,cars$dist,
     col = 'tomato',
     pch = '+',
     xlim = c(0,30),
     ylim = c(0,150))
# -------------------------------------------------------------------------------

v <- 1:100

class(v)
v

sum(1:100)


score <- 88

n = 2
if (n %% 15 == 0){
  print("피자나라치킨공주")
} else if (n %% 3 == 0){
  print("피자")
} else if (n %% 5 == 0){
  print("치킨")
} else {
print("다이어트")
}

# [ 벡터 ] --------------------------------------------------
v <- c(10, 20, 30, 40, 50, 60, 70)
v[1]

v[1:3]
v[3:6]

v[c(1,3,4,7)]
v[-7]
v[8]

v[6:8]
v[-1:3]
v[7] <- 700

v[1:3] <- c(100,200,300)
v[1:3] <- seq(100,300,100)


# 피자나라치킨공주 벡터의 생성
v <- c()
for (i in 1:15) {
  if (i %% 3 == 0 && i %% 5 == 0) {
    v <- c(v, 'PZ')
  } else if (i %% 3 == 0) {
    v <- c(v, 'P')
  } else if (i %% 5 == 0) {
    v <- c(v, 'C')
  } else {
    v <- c(v, 'D')
  }
}          
v
v <- c(10,20,30,40,50,60,70)
v[c(T,T,F,F,F,T,F)]

v + 1 # 원소갯수가 다르면 모두 같은 값으로 더해짐

c(10,20) + c(30, 40)

v > 30
v[v>30]

1:9 + 1:2

rep(1:3,times=3)
v[c(T,F)]

# 1에서 100까지 수 중에서 7의 배수의 합은?
sum(seq(7,100,7))

v <- 1:100
sum(v[v%% 7 ==0])

a <- c()
v <- c()
v <- c(v,1)
v <- c(v,2)

for (i in 1:10){
  v <- c(v,i)
  a[i] <- i
}
v
a

# 범주형으로 저장--------------------------
f <- factor(c(1,2,1,2),
            levels = 1:3,
            labels = c('Male','Female','TG'))
f
levels(f)

f[1]
f[f == 'Male']
f[f == 'female']

f[6] <- 'Male'
f[7] <- 'TG'
f

v.1<- c(1,2,3)
v.2 <- c("F","F","M")
c(v.1,v.2)


# 각각의 벡터안의 타입만 같으면 리스트 생성가능
lst <- list(id = v.1 , gender = v.2)

# lst 안에 id벡터와 gender벡터가 존재
lst$id

v <- c(10,20,30,40,50)
which (v > 30)

n <- 32
# n의 약수를 모두 출력
# 반복문 사용금지
d <- seq(1,32)
n
d

length(d[n%%d == 0])


# DF프레임 (행렬)애서 데이터 추출
str(iris)
View(iris)
iris[1,]
iris[1:5,]
iris[1:5,1]
iris[1:5,1:2]
iris[1:5,1:4]
iris[1:5,-5]

iris[, 1]
iris$Sepal.Length
nrow(iris[iris$Sepal.Length < 5,-5])


# 실습 : Petal.Length가 평균보다 큰 데이터의 
# Petal.Width 평균값은 얼마인가?
P_L = iris$Petal.Length
cond_row = P_L > mean(P_L)
mean(iris[cond_row,4])


# 함수 공부

fun <- function (x) {
  return ( x + y + 5)
}
y <- 3
fun(5)

my.fun <- function(x,y,z){
  cat(x, y, z, "\n")
  return(x + y*2 + z*3)
}
my.fun(z =1,2,3)

# 디폴트값 공부
head(iris[,-5], n=5)
head(iris[,-5])
hist(iris$Sepal.Length, main ='histogram',xlab='xlabel',ylab='ylabel')


# n의 약수 구하기 함수

divisor <- function(n) {
  # to do
  v <- 1:n
  x <-  v[n%%v==0]
  x_count <- length(x)
  return (x_count)
  
}

divisor(32)

# 한줄로 함수 정의하는 방법
div.cnt <- function(n) length((1:n)[n%%(1:n)==0])
div.cnt(32)

for (i in 1:15){
  cat(i, div.cnt(i), '\n')
}

# sapply 함수 사용방법 : for문 필요없어짐.개꿀...

f1 <- function (n) n ^ 2
f1(5)

sapply(1:9, FUN = f1)

# 1~100까지 소수 찾기
(1:100)[sapply(1:100, FUN =div.cnt) == 2]

# 소수개수
length((1:100)[sapply(1:100, FUN =div.cnt) == 2])



# R기초 2022.08.05(금)--------------------------------

# 데이터프레임 정보확인 
df <- iris # 원본데이터 보존을 위해
str(df)
class(df)
dim(df)

nrow(df)
ncol(df)
head(df)

rownames(df)
colnames(df)

v <- c(85,77,96)
v  
names(v)  
names(v) <- c('Kor','Eng','Math')

v["Kor"]
v[c("Eng","Math")]

df$Sepal.Length
df$Sepal.Width

df$Sepal.Sum <- df$Sepal.Width + df$Sepal.Length
df$Sepal.Sum
colnames(df)
head(df[,5:6])

# 평균기준 팩터생성
cond <- df$Sepal.Sum >mean(df$Sepal.Sum)
cond
df$Sepal.Sep <- ifelse(cond,"Big","Small")

# 팩터로 변환
f <- factor(df$Sepal.Sep)

# 테이블
t_f <- table(f)

# 그래프
barplot(t_f)



# [state.x77]-----------------------------------
?state.x77
class(state.x77)
is.data.frame(state.x77)
st <- as.data.frame(state.x77)
class(st)
str(st)
dim(st)
rownames(st)

# (실습)Murder가 가장 큰 지역이름 출력
rownames(st[st$Murder==max(st$Murder),])
st[st$Murder==max(st$Murder),]


# csv파일 저장하기
write.csv(df,'my_iris.csv', row.names=F) # 파일 열린 상태면 연결오류

# 엑셀 파일 불러오기
# 패키기 설치: install.packages('readxl')

library(readxl)
df <- read_excel("성적표.xlsx", sheet =1)
str(df)
class(df)

# 학생별 평균값 만들기
# 방법1
df$평균 <- (df$파이썬+df$R+df$머신러닝)/3
# 방법2
df$평균 <- round(apply(df[, 3:5], MARGIN =1, mean),2)
head(df)
# 저장
write.csv(df,"score.csv",row.names=F)


# 파일 불러오기
df <- read.csv("my_iris.csv",header=T)
df




