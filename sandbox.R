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
