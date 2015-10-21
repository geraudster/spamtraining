library(curl)
library(ggplot2)

if (!dir.exists('data')) dir.create('data')
if (!file.exists('data/emails_train.csv')) curl_download('https://raw.githubusercontent.com/geraudster/spamdata/master/emails_train.csv', 'data/emails_train.csv')
if (!file.exists('data/emails_test.csv')) curl_download('https://raw.githubusercontent.com/geraudster/spamdata/master/emails_test.csv', 'data/emails_test.csv')

toSpamFactor <- function(x) {
  factor(x, c(0,1), c('ham', 'spam'))
}
trainSet <- read.csv('data/emails_train.csv')
testSet <- read.csv('data/emails_test.csv')
trainSet$spam <- toSpamFactor(trainSet$spam)
testSet$spam <- toSpamFactor(testSet$spam)


shinyServer(
  function(input, output) {
    # TODO
    output$variableChoice <-  renderUI(selectInput('variable', 'Choisir un terme', 
                                                   choices = colnames(trainSet[, -31]),
                                                   selected = 'Solar.R'))
    
    output$trainDataTable <- renderTable(head(trainSet, 20))
    output$contingencyTable <- renderTable(rbind(table(trainSet$spam), sprintf('%.02f %%', 100 * prop.table(table(trainSet$spam)))))
    output$contingencyTableTest <- renderTable(rbind(table(testSet$spam), sprintf('%.02f %%', 100 * prop.table(table(testSet$spam)))))
    output$modelResult <- renderPlot({
      input$goButton
      
      isolate({
        algo <- input$modelType
          if(algo == 'glm') {
            fit <- glm(spam ~ ., trainSet, family = 'binomial')
            preds <- predict(fit, newdata = testSet, type = 'response')
            confusionMatrix <- table('Obs' = testSet$spam,
                                     'Pred' = sapply(preds >= 0.5, function(x) { if(x) toSpamFactor(1) else toSpamFactor(0)}))
            confusionMatrixDf <- data.frame(confusionMatrix)
            confusionMatrixDf$Obs <- with(confusionMatrixDf, factor(Obs, levels = rev(levels(Obs))))
            # confusionMatrixDf$Pred <- with(confusionMatrixDf, factor(Pred, levels = rev(levels(Pred))))
            qplot(data = confusionMatrixDf, x = Pred, y = Obs,
                  fill = Freq,
                  geom = 'tile',
                  main = 'Matrice de confusion') +
              geom_text(aes(label = Freq)) +
              scale_fill_gradient(low = "white", high = "blue")
          }
      })
    })
  }
)

