## Préparation des datasets

### Chargement du fichier


```r
emails <- read.csv('spams_and_hams/emails.csv', stringsAsFactors = FALSE)
nrow(emails)
```

```
## [1] 5728
```

```r
table(emails$spam)
```

```
## 
##    0    1 
## 4360 1368
```

### Création du corpus


```r
#install.packages('tm')
#install.packages('SnowballC')
library(tm)
```

```
## Loading required package: NLP
```

```r
library(SnowballC)
```

Création du corpus:

```r
emailCorpus <- Corpus(VectorSource(emails$text), readerControl = list(language = 'en'))
```

On applique ensuite une série de transformations pour nettoyer le corpus (passage en minuscule, 
suppression de la ponctuation...):

```r
emailCorpus <- tm_map(emailCorpus, tolower)
emailCorpus <- tm_map(emailCorpus, stripWhitespace)
emailCorpus <- tm_map(emailCorpus, PlainTextDocument)
emailCorpus <- tm_map(emailCorpus, removePunctuation)
emailCorpus <- tm_map(emailCorpus, removeWords, stopwords("english"))
emailCorpus <- tm_map(emailCorpus, stemDocument)
```


```r
dtm <- DocumentTermMatrix(emailCorpus)
dtm
```

```
## <<DocumentTermMatrix (documents: 5728, terms: 28687)>>
## Non-/sparse entries: 481719/163837417
## Sparsity           : 100%
## Maximal term length: 24
## Weighting          : term frequency (tf)
```

On retire ensuite les termes utilisés dans moins de 5% des documents:

```r
dtmWithoutSparseTerms <- removeSparseTerms(dtm, 0.95)
dtmWithoutSparseTerms
```

```
## <<DocumentTermMatrix (documents: 5728, terms: 330)>>
## Non-/sparse entries: 213551/1676689
## Sparsity           : 89%
## Maximal term length: 10
## Weighting          : term frequency (tf)
```

### Création du data.frame

Transformation en objet data.frame et renommage des colonnes:

```r
emailsDf <- as.data.frame(as.matrix(dtmWithoutSparseTerms))
colnames(emailsDf) <- make.names(colnames(emailsDf))
```

Récupération des termes les plus fréquents:

```r
v <- sort(colSums(emailsDf), decreasing=TRUE)
head(names(v), 30)
```

```
##  [1] "enron"    "ect"      "subject"  "vinc"     "will"     "hou"     
##  [7] "com"      "pleas"    "X2000"    "kaminski" "can"      "thank"   
## [13] "forward"  "time"     "X2001"    "research" "market"   "work"    
## [19] "inform"   "price"    "meet"     "know"     "group"    "manag"   
## [25] "may"      "get"      "like"     "use"      "need"     "busi"
```


```r
emailsTopTerms <- emailsDf[, head(names(v),30)]
```

On colle le label:

```r
emailsTopTerms$spam <- emails$spam
```

### Création train/test datasets


```r
#install.packages('caTools')
library(caTools)
```

Création des jeux de données (70% pour le train, 30% pour le test):

```r
set.seed(1234)
split <- sample.split(emailsTopTerms$spam, 0.7)
trainSet <- emailsTopTerms[split,]
testSet <- emailsTopTerms[-split,]
```

### Écriture des fichiers


```r
write.table(trainSet, file = 'emails_train.csv', row.names = FALSE, sep = ',', quote = FALSE)
write.table(testSet, file = 'emails_test.csv', row.names = FALSE, sep = ',', quote = FALSE)
```
