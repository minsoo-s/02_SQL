install.packages('palmerpenguins')
library(palmerpenguins)
pg<- penguins
str(pg)
dim(pg)

# 아델리 펭귄 여부---------------------------------------------------
pg$is.adelie <- factor(
    ifelse(pg$species == 'Adelie',"YES","NO")
)
barplot(table(pg$is.adelie))

str(pg)
pg <- pg[,-1] # species 컬럼 삭제
str(pg)

model <- glm(is.adelie ~ ., data = pg,
            family = binomial(link = 'logit'))            
summary(model)

predict(model)

model$fitted.values
pg$pred <- factor(
    ifelse(model$fitted.values > 0.5, "YES","NO"))
table(pg$is.adelie, pg$pred)

# virginica 펭귄 여부------------------------------------------------
df <- iris
df$Species <- factor(ifelse(df$Species == 'virginica', 'YES','NO'))
model <- glm(Species ~., data = df,
                family = binomial(link = "logit"))
summary(model)
df$pred<- factor(ifelse(model$fitted.values >0.5,"YES","NO"))
tab <- table(df$Species, df$pred)
tab
TP <- tab[2,2]
TN <- tab[1,1]
FP <- tab[2,1]
FN <- tab[1,2]

accuracy <- (TP + TN) / (TP + TN + FP + FN)
accuracy

install.packages('pROC')
library(pROC)
roc(Species ~ model$fitted.values, data = df,
    plot = TRUE, main = "ROC CURVE", col = 'tomato')

