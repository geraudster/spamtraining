library(curl)
library(ggplot2)
library(rpart)
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
    output$variableChoice <-  renderUI(selectInput('variable', 'Choisir un terme', 
                                                   choices = colnames(trainSet[, -31])))
    output$termBoxplot <- renderPlot({boxplot(get(input$variable) ~ spam, data = trainSet)})
    
    output$trainDataTable <- renderTable(head(trainSet, 20))
    output$contingencyTable <- renderTable(rbind(table(trainSet$spam), sprintf('%.02f %%', 100 * prop.table(table(trainSet$spam)))))
    output$contingencyTableTest <- renderTable(rbind(table(testSet$spam), sprintf('%.02f %%', 100 * prop.table(table(testSet$spam)))))

    computeMatrix <- reactive({
      algo <- input$modelType
      seuil <- input$seuil
      if(algo == 'glm') {
        fit <- glm(spam ~ ., trainSet, family = 'binomial')
        preds <- predict(fit, newdata = testSet, type = 'response')
        doConfusionMatrix(preds, seuil)
      } else if(algo == 'rpart') {
        fit <- rpart(spam ~ ., trainSet)
        preds <- predict(fit, newdata = testSet)
        doConfusionMatrix(preds[,'spam'], seuil)
      }
    })
    
    output$modelResult <- renderPlot({
      input$goButton
      confusionMatrix <- computeMatrix()
      plotConfusionMatrix(confusionMatrix)
    })

    output$modelMetrics <- renderTable({
      input$goButton
      
      confusionMatrix <- computeMatrix()
      metricsConfusionMatrix(confusionMatrix)
    })
  }
)

doConfusionMatrix <- function(preds, seuil) {
  confusionMatrix <- table('Obs' = testSet$spam,
                           'Pred' = sapply(preds >= seuil, function(x) { if(x) toSpamFactor(1) else toSpamFactor(0)}))
  confusionMatrixDf <- data.frame(confusionMatrix)
  confusionMatrixDf$Obs <- with(confusionMatrixDf, factor(Obs, levels = rev(levels(Obs))))
  # confusionMatrixDf$Pred <- with(confusionMatrixDf, factor(Pred, levels = rev(levels(Pred))))
  confusionMatrixDf$color <- NA
  confusionMatrixDf[confusionMatrixDf$Obs != confusionMatrixDf$Pred,]$color <- c('red')
  confusionMatrixDf[confusionMatrixDf$Obs == confusionMatrixDf$Pred,]$color <- c('green')
  confusionMatrixDf
}

plotConfusionMatrix <- function(mat) {
  qplot(data = mat, x = Pred, y = Obs,
        fill = color,
        geom = 'tile',
        main = 'Matrice de confusion') +
    xlab('Prédiction') +
    ylab('Observé') +
    geom_text(aes(label = Freq)) +
    scale_fill_manual(name = 'Prédiction',
                      values = c('red' = '#ffdddd', 'green' = '#ccffcc'),
                      labels = c('green' = 'correcte', 'red' = 'erreur'))
}

metricsConfusionMatrix <- function(mat) {
  TP <- mat[mat$Obs == 'spam' & mat$Pred == 'spam',]$Freq
  P <- sum(mat[mat$Obs == 'spam',]$Freq)
  TN <- mat[mat$Obs == 'ham' & mat$Pred == 'ham',]$Freq
  N <- sum(mat[mat$Obs == 'ham',]$Freq)
  data.frame(sensitivity = TP / P, specificity = TN / N, accuracy = (TP + TN) / (P + N))
}
