# install.packages('ElemStatLearn')
# library(ElemStatLearn)
# data(spam)
# 
# colnames(spam)
# 
# spam$spam
# spam[58]
# spam[[58]]
# 
# summary(spam)
# sapply(spam, class)
# 

loadDataFile <- function(url, dest, unzip=TRUE) {
  ## Check data directory 
  if(!file.exists("data")) {
    dir.create("data")
  }
  
  ## Download file if needed
  if(!file.exists(dest)) {
    download.file(url,
                  dest,
                  method='curl')
    
  }
  
  if(unzip) {
    ## Unzip it in data dir
    unzip(dest, exdir="data")
  }
}

loadDataFile('https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.zip',
             'spambase')

spambase <- read.csv('data/spambase.data')
spambase.names <- readLines('data/spambase.names')
spambase.names <- sub(':.*$', '', spambase.names[34:length(spambase.names)])
spambase.names [length(spambase.names) + 1] <- 'spam'

colnames(spambase) <- spambase.names
spambase$spam <- factor(spambase$spam, c(0,1), labels = c('nospam', 'spam'))

hist(spambase$word_freq_order[spambase$spam == 'nospam'], col = 'blue', breaks = 20)
hist(spambase$word_freq_order[spambase$spam == 'spam'], col = 'red', add = T, breaks = 20)

boxplot(word_freq_order ~ spam, data = spambase, col = c('blue', 'red'))

spambase.cor <- cor(spambase[-58])

set.seed(123)
spambase.train.idx <- sample.int(nrow(spambase), nrow(spambase) * 0.8)
spambase.train <- spambase[spambase.train.idx,]
spambase.test <- spambase[-spambase.train.idx,]

model1 <- glm(spam ~ ., data = spambase.train, family = "binomial")
summary(model1)
# predictions1 <- predict(model1, newdata = spambase.test, type = 'term')
predictions1 <- predict(model1, newdata = spambase.test, type = "response")
predictions1 <- sapply(predictions1, function (x) { if (x>0.7) 'spam' else 'nospam'})

table(predict = predictions1, actual = spambase.test$spam)

mean(predictions1 == spambase.test$spam)

# install.packages('ggplot2')
library(ggplot2)
qplot(log(spambase.test$word_freq_order + 1), predictions1, col = spambase.test$spam)
plot(log(spambase.test$word_freq_order + 1), predictions1, col = spambase$spam)


library(rpart)
model2 <- rpart(spam ~ ., data = spambase.train)
summary(model2)
plot(model2)
text(model2)

predictions2 <- predict(model2, newdata = spambase.test, type = "class")
# predictions1 <- sapply(predictions1, function (x) { if (x>0.7) 'spam' else 'nospam'})

table(predict = predictions2, actual = spambase.test$spam)

mean(predictions2 == spambase.test$spam)

# install.packages('caret')


# tips:
# matrice de confusion
table(spambase.test$spam, predictions2[,'spam'] >= 0.5)

# calcul accuracy
sum(diag(table(spambase.test$spam, predictions2[,'spam'] >= 0.5))) / nrow(spambase.test)

# rpart
library(rpart.plot)
model2 <- rpart(spam ~ ., data = spambase.train)
prp(model2)

# Test dataset Enron
pairs(emailsTopTerms[c(1:5,31)])
pairs(emailsTopTerms[c(6:10,31)])
pairs(emailsTopTerms[c(11:15,31)])
pairs(emailsTopTerms[c(16:20,31)])
pairs(emailsTopTerms[c(21:25,31)])
pairs(emailsTopTerms[c(26:30,31)])

# Test de ml
# library(caTools)
# split <- sample.split(emailsTopTerms$spam, 0.7)
trainSet$spam <- factor(trainSet$spam, levels = c(0,1), labels = c('ham', 'spam'))
testSet$spam <- factor(testSet$spam, levels = c(0,1), labels = c('ham', 'spam'))

model.logit <- glm(spam ~ ., trainSet, family = 'binomial')
train.predictions <- predict(model.logit, newdata = trainSet, type = 'response')
train.confusionMat <- table(trainSet$spam, train.predictions >= 0.5)
sum(diag(train.confusionMat) / nrow(trainSet))

test.predictions <- predict(model.logit, newdata = testSet, type = 'response')
test.confusionMat <- table(testSet$spam, test.predictions >= 0.5)
sum(diag(test.confusionMat) / nrow(testSet))

library(rpart)
model.rpart <- rpart(spam ~ ., trainSet)
train.predictions2 <- predict(model.rpart, newdata = trainSet)
train.confusionMat2 <- table(trainSet$spam, train.predictions2['spam'] >= 0.5)
sum(diag(train.confusionMat2) / nrow(trainSet))

test.predictions2 <- predict(model.rpart, newdata = testSet)
test.confusionMat2 <- table(testSet$spam, test.predictions2[,'spam'] >= 0.5)
sum(diag(test.confusionMat2) / nrow(testSet))

#install.packages('rpart.plot')
library(rpart.plot)
prp(model.rpart)
