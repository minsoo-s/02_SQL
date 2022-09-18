
###############################
## R을 이용한 통계데이터분석 ##
## (곽기영, 도서출판 청람)   ## 
###############################

####################
## 제4장 분산분석 ##
####################

###############
## 4.2 F검정 ##
###############

# 집단 간 분산
mstr <- ((101.6-108.1)^2*5+(114.6-108.1)^2*5)/(2-1)

# 집단 내 분산
mse <- (4.98^2*4+7.96^2*4)/(4+4)
mse <- ((95-101.6)^2+(105-101.6)^2+(98-101.6)^2+(103-101.6)^2+(107-101.6)^2+(110-114.6)^2+(125-114.6)^2+(105-114.6)^2+(113-114.6)^2+(120-114.6)^2)/(4+4)

# F = 집단간 분산/집단 내 분산
F <- mstr/mse
F

pf(F, df1=1, df=8, lower.tail=FALSE)

# 9.59는 5.31을 더 벗어난 값이므로 대립가설을 채택
pf(9.59, df1=1, df=8, lower.tail=FALSE)
qf(0.05, df1=1, df=8, lower.tail=FALSE)

adhd <- data.frame(score=c(95,105,98,103,107,110,125,105,113,120),
                therapy=c(rep("A", 5), rep("B", 5)))
adhd
str(adhd)
adhd.aov <- aov(score ~ therapy, data=adhd)
summary(adhd.aov)

tapply(adhd$score, adhd$therapy, mean)
tapply(adhd$score, adhd$therapy, sd)
mean(adhd$score)
sd(adhd$score)



######################
## 4.3 일원분산분석 ##
######################

str(InsectSprays)
InsectSprays
tapply(InsectSprays$count, InsectSprays$spray, mean)
tapply(InsectSprays$count, InsectSprays$spray, sd)
tapply(InsectSprays$count, InsectSprays$spray, length)

# [그림 4-8]
windows(width=7.0, height=5.5)
library(gplots)

# 살충제 간의 평균 차이가 있어보임.
plotmeans(count ~ spray, data=InsectSprays,
          barcol="tomato", barwidth=3, col="cornflowerblue", lwd=2,
          xlab="Type of Sprays", ylab="Insect Count", 
          main="Performance of Insect Sprays\nwith 95% CI of Mean")

# [그림 4-9]
windows(width=7.0, height=5.5)
boxplot(count ~ spray, data=InsectSprays, col="tomato",
        xlab="Type of Sprays", ylab="Insect Count",
        main="Performance of Insect Sprays")

# 일원분산분석 (one-way ANOVA)
sprays.aov <- aov(count ~ spray, data=InsectSprays)
sprays.aov
summary(sprays.aov)

# 개별 집단과 평균의 차이 확인
model.tables(sprays.aov, type="means")
model.tables(sprays.aov, type="effects") # 전체평균 - 개별 평균
model.tables(sprays.aov) # effects가 default

# 사후 분석(각 범주별 관계 확인)
# 살충제 C와 D는 효과가 별 차이가 없다.
# 가격 차이가 난다면 1위가 아니라도 더 저렴한 것을 사는 것이 좋음
sprays.compare <- TukeyHSD(sprays.aov)		
sprays.compare

sprays.compare$spray['D-C',]

# [그림 4-10]
# 신뢰구간이 0을 포함하면 무의미하다
windows(width=7.0, height=5.5)
plot(TukeyHSD(sprays.aov), col="blue", las=1)

str(InsectSprays)
# [그림 4-11]
windows(width=7.0, height=5.5)
#install.packages("multcomp")
library(multcomp)
tuk.hsd <- glht(model=sprays.aov, linfct=mcp(spray="Tukey"))
cld(tuk.hsd, level=0.05)
plot(cld(tuk.hsd, level=0.05), col="orange")

# [그림 4-12]
# 시각적 정규성 검정(qqplot)
library(car)
windows(width=7.0, height=5.5)
#id = 극단적인 두 값을 그래프에 지정
qqPlot(InsectSprays$count, pch=17, col="deepskyblue", id=FALSE,
        main="Q-Q Plot", xlab="Theoretical Quantiles", ylab="Sample Quantiles")

# 샤피로 테스트 -> 0.05보다 작으므로 정규성을 따르지 않음.
shapiro.test(InsectSprays$count)

# 크게 벗어난 이상값은 주의
# Bonferroni p 가 0.05보다 크면 이상점이 존재하지 않는다고 결론내림
outlierTest(sprays.aov)

# 분산 확인 -> 0.05보다 작으므로 집단 간 분산이 동일하지 못함.
leveneTest(count ~ spray, data=InsectSprays)
bartlett.test(count ~ spray, data=InsectSprays)

# 등분산을 가정하지 않는 onewat.test()
# p-value가 0.05이하이므로 대립가설채택
oneway.test(count ~ spray, data=InsectSprays)

# 등분산 가정 -> var.equal = True
oneway.test(count ~ spray, data=InsectSprays, var.equal=TRUE)




#-------------------------------------------------------------------
######################
## 4.4 이원분산분석 ##
######################

# len: 치아 길이, supp: 투입성분, dose: 투입량
str(ToothGrowth)
levels(ToothGrowth$dose)

# dose 범주명 변환
ToothGrowth$dose <- factor(ToothGrowth$dose, 
                           levels=c(0.5, 1.0, 2.0), labels=c("low", "med", "high"))
str(ToothGrowth)
ToothGrowth[seq(1, 60, 5),]

# 데이터 갯수, 평균, 분산 확인 : 표본집단 분석
with(ToothGrowth, tapply(len, list(supp, dose), length))
with(ToothGrowth, tapply(len, list(supp, dose), mean))
with(ToothGrowth, tapply(len, list(supp, dose), sd))

# *을 사용하면 상호작용까지 포함되어 출력
ToothGrowth.aov <- aov(len ~ supp * dose, data=ToothGrowth)

# *을 쓰지 않을 경우, : 사용
ToothGrowth.aov <- aov(len ~ supp + dose + supp:dose, data=ToothGrowth)

summary(ToothGrowth.aov)

model.tables(ToothGrowth.aov, type="means")

# 시각화를 통해 확인
# [그림 4-13]
windows(width=7.0, height=5.5)
boxplot(len ~ supp * dose, data=ToothGrowth,
        col=c("deeppink", "yellowgreen"), las=1,
        xlab="Vitamin C Type", ylab="Tooth Growth",
        main="Effects of Vitamin C on Tooth Growth of Guinea Pigs")

# 관계확인 그래프
# [그림 4-14]
windows(width=7.0, height=5.5)
interaction.plot(x.factor=ToothGrowth$dose, trace.factor=ToothGrowth$supp, 
                 response=ToothGrowth$len, las=1, type="b", 
                 pch=c(1, 19), col=c("blue", "red"), trace.label="Supplement",
                 xlab="Dose Level", ylab="Tooth Length",
                 main="Interaction Plot for Tooth Growth of Guinea Pigs")

# [그림 4-15]
windows(width=7.0, height=5.5)
#install.packages("gplots")
library(gplots)
plot
means(len ~ interaction(supp, dose, sep=" "), data=ToothGrowth,
          connect=list(c(1,3,5), c(2,4,6)),
          col=c("red", "green3"),
          xlab="Supplement and Dose Combination", ylab="Tooth Length",
          main="Means Plot for Tooth Growth of Guinea Pigs\nwith 95% CI of Mean")

# [그림 4-16]
windows(width=7.0, height=5.5)
# coplot 조건부 그래프
# supp 별로 len~ dose 관계 그래프
coplot(len ~ dose | supp, data=ToothGrowth, 
       col="steelblue", pch=19, 
       panel=panel.smooth, lwd=2, col.smooth="darkorange",
       xlab="Dose Level", ylab="Tooth Length")

# [그림 4-17]
# install.packages("HH")
library(HH)
windows(width=7.0, height=5.5)
interaction2wt(len ~ supp * dose,  data=ToothGrowth)

TukeyHSD(ToothGrowth.aov)

TukeyHSD(ToothGrowth.aov, which=c("dose"), conf.level=0.99)

####################
## 4.5 공분산분석 ##
####################

install.packages("faraway")
library(faraway)
str(sexab)

tapply(sexab$ptsd, sexab$csa, mean)
tapply(sexab$ptsd, sexab$csa, sd)
tapply(sexab$ptsd, sexab$csa, length)

sexab.aov <- aov(ptsd ~ cpa + csa, data=sexab)
summary(sexab.aov)

install.packages("effects")
library(effects)
effect("csa", sexab.aov)

# [그림 4-18]
library(HH)
windows(width=7.0, height=5.5)
ancova(ptsd ~ cpa + csa, data=sexab)

###########################
## 4.6 반복측정 분산분석 ##
###########################

head(CO2, 3); tail(CO2, 3)
CO2sub <- subset(CO2, Treatment=="chilled")
CO2sub$conc <- factor(CO2sub$conc)

CO2sub.aov <- aov(uptake ~ Type * conc + Error(Plant/conc), data=CO2sub)
summary(CO2sub.aov)

# [그림 4-19]
windows(width=7.0, height=5.5)
par(mar=c(6,4,4,2))
boxplot(uptake ~ Type * conc, data=CO2sub,
        col=c("deepskyblue", "violet"), las=2, cex.axis=0.75,
        ylab="Carbon dioxide uptake rate", xlab="",
        main="Effects of Plant Type and CO2 on Carbon Dioxide Uptake")
legend("topleft", inset=0.02, 
       legend=c("Quebec", "Mississippi"), fill=c("deepskyblue", "violet"))

# [그림 4-20]
library(HH)
windows(width=7.0, height=5.5)
interaction2wt(uptake ~ conc * Type, data=CO2sub)

#########################
## 4.7 다변량 분산분석 ##
#########################

install.packages("heplots")
library(heplots)
str(Skulls)
library(dplyr)
sample_n(Skulls, 10)

attach(Skulls)
y <- cbind(mb, bh, bl, nh)
aggregate(y, by=list(epoch), FUN=mean)

Skulls.manova <- manova(y ~ epoch)
summary(Skulls.manova)

summary.aov(Skulls.manova)
detach(Skulls)
