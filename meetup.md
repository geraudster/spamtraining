# Sujet Meetup TDS NoBlaBla
Géraud  

## Intro R

* R c'est quoi? les origines...
* Présentation RStudio

### R c'est quoi?

**R** est un dialecte de **S**.

S c'est quoi? C'est un environnement pour l'analyse statistique développé en Fortran 
par les laboratoires Bell dès 1976.
Il a été réécrit en C en 1988. 
En 1991, début de l'implémentation de R par l'université d'Aukland, pour pallier au fait que la version de S-PLUS
était propriétaire.

Jusqu'en 2008 S-PLUS devient la propriété de TIBCO.

2015: R en version 3.2

La philosophie de S / R: fournir un environnement interactif pour l'analyse statistique.

### RStudio

[Rstudio](http://www.rstudio.com/) est une société qui publie l'éditeur Rstudio (et d'autres services comme ShinyApps, Rpubs...)

Plusieurs versions sont disponibles dont une version *Open Source*.

## Les bases du langage

R est une grosse calculatrice qui fournit une interface REPL (Read-Eval-Print-Loop).


```r
1 + 2
```

```
## [1] 3
```

```r
log(5)
```

```
## [1] 1.609438
```

```r
sqrt(25)
```

```
## [1] 5
```

À tout moment, il est possible d'accéder à l'aide en ligne:


```r
?log
?sqrt
?`+`
```

### Opérateurs, valeurs, listes, dataframes

Utiliser des scalaires:

```r
1 + 2
```

```
## [1] 3
```

```r
log(5)
```

```
## [1] 1.609438
```

```r
sqrt(25)
```

```
## [1] 5
```

Affecter un résultat à une variable:

```r
result <- 1 + 2
result
```

```
## [1] 3
```


Manipuler des vecteurs:


```r
c(1,2,3,4,5,6,7,8,9)
```

```
## [1] 1 2 3 4 5 6 7 8 9
```

```r
c(1:9)
```

```
## [1] 1 2 3 4 5 6 7 8 9
```

```r
c('a', 'b', 'c')
```

```
## [1] "a" "b" "c"
```

```r
letters[1:3]
```

```
## [1] "a" "b" "c"
```

Les vecteurs ne contiennent que des données du même type:

```r
c(1,2,'toto')
```

```
## [1] "1"    "2"    "toto"
```


Opérations entre scalaires et vecteurs:

```r
c(1:9) + 2
```

```
## [1]  3  4  5  6  7  8  9 10 11
```

```r
c(1:9) * 3
```

```
## [1]  3  6  9 12 15 18 21 24 27
```

Opérations entre vecteurs:

```r
c(1:9)*c(1:9)
```

```
## [1]  1  4  9 16 25 36 49 64 81
```

```r
c(1:9)*c(2:4)
```

```
## [1]  2  6 12  8 15 24 14 24 36
```

Les listes peuvent contenir des types différents:

```r
list(1,2,'toto')
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2
## 
## [[3]]
## [1] "toto"
```

```r
maListe <- list(1,2,'toto')
maListe[2]
```

```
## [[1]]
## [1] 2
```

```r
maListe[[2]]
```

```
## [1] 2
```

Les Data Frames permettent de stocker des tableaux de données:

```r
prenoms <- c('Alice', 'Bob', 'Carole')
emails <- c('alice@example.com', 'bob@example.com', 'carole@example.com')
ages <- c(24, 30, 23)
monDataFrame <- data.frame(prenoms, emails, ages)
monDataFrame
```

```
##   prenoms             emails ages
## 1   Alice  alice@example.com   24
## 2     Bob    bob@example.com   30
## 3  Carole carole@example.com   23
```

```r
monDataFrame[2, 'prenoms']
```

```
## [1] Bob
## Levels: Alice Bob Carole
```

```r
monDataFrame$prenoms
```

```
## [1] Alice  Bob    Carole
## Levels: Alice Bob Carole
```

Aide-mémoire pour les indices des data.frames: [ROW, COL] -> ROW is COol


* Structure de contrôle (if, loop..)


## Cas d'utilisation spam filter

### Récupération et exploration des données

* Récupération du jeu de données (https://archive.ics.uci.edu/ml/datasets/Spambase)
* Un peu de stats descriptives, quelques plots
* *Réduction de dimensions ?*

Récupérer les données depuis l'url distante:

```r
url <- 'https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.zip'
dest <- './data'
dir.create(dest)
```

```
## Warning in dir.create(dest): './data' already exists
```

```r
download.file(url,
              paste(dest, 'spambase.zip', sep='/'), method = 'curl')
```

Ensuite on décompresse l'archive:

```r
unzip(paste(dest, 'spambase.zip', sep='/'), exdir=dest)
```

Regardons les fichiers créés:

```r
list.files(dest)
```

```
## [1] "spambase.data"          "spambase.DOCUMENTATION"
## [3] "spambase.names"         "spambase.zip"
```

Chargement des données:

```r
spambase <- read.csv('data/spambase.data')

dim(spambase)
```

```
## [1] 4600   58
```

```r
colnames(spambase)
```

```
##  [1] "X0"      "X0.64"   "X0.64.1" "X0.1"    "X0.32"   "X0.2"    "X0.3"   
##  [8] "X0.4"    "X0.5"    "X0.6"    "X0.7"    "X0.64.2" "X0.8"    "X0.9"   
## [15] "X0.10"   "X0.32.1" "X0.11"   "X1.29"   "X1.93"   "X0.12"   "X0.96"  
## [22] "X0.13"   "X0.14"   "X0.15"   "X0.16"   "X0.17"   "X0.18"   "X0.19"  
## [29] "X0.20"   "X0.21"   "X0.22"   "X0.23"   "X0.24"   "X0.25"   "X0.26"  
## [36] "X0.27"   "X0.28"   "X0.29"   "X0.30"   "X0.31"   "X0.33"   "X0.34"  
## [43] "X0.35"   "X0.36"   "X0.37"   "X0.38"   "X0.39"   "X0.40"   "X0.41"  
## [50] "X0.42"   "X0.43"   "X0.778"  "X0.44"   "X0.45"   "X3.756"  "X61"    
## [57] "X278"    "X1"
```

```r
head(spambase, 5)
```

```
##     X0 X0.64 X0.64.1 X0.1 X0.32 X0.2 X0.3 X0.4 X0.5 X0.6 X0.7 X0.64.2 X0.8
## 1 0.21  0.28    0.50    0  0.14 0.28 0.21 0.07 0.00 0.94 0.21    0.79 0.65
## 2 0.06  0.00    0.71    0  1.23 0.19 0.19 0.12 0.64 0.25 0.38    0.45 0.12
## 3 0.00  0.00    0.00    0  0.63 0.00 0.31 0.63 0.31 0.63 0.31    0.31 0.31
## 4 0.00  0.00    0.00    0  0.63 0.00 0.31 0.63 0.31 0.63 0.31    0.31 0.31
## 5 0.00  0.00    0.00    0  1.85 0.00 0.00 1.85 0.00 0.00 0.00    0.00 0.00
##   X0.9 X0.10 X0.32.1 X0.11 X1.29 X1.93 X0.12 X0.96 X0.13 X0.14 X0.15 X0.16
## 1 0.21  0.14    0.14  0.07  0.28  3.47  0.00  1.59     0  0.43  0.43     0
## 2 0.00  1.75    0.06  0.06  1.03  1.36  0.32  0.51     0  1.16  0.06     0
## 3 0.00  0.00    0.31  0.00  0.00  3.18  0.00  0.31     0  0.00  0.00     0
## 4 0.00  0.00    0.31  0.00  0.00  3.18  0.00  0.31     0  0.00  0.00     0
## 5 0.00  0.00    0.00  0.00  0.00  0.00  0.00  0.00     0  0.00  0.00     0
##   X0.17 X0.18 X0.19 X0.20 X0.21 X0.22 X0.23 X0.24 X0.25 X0.26 X0.27 X0.28
## 1     0     0     0     0     0     0     0     0     0     0     0  0.07
## 2     0     0     0     0     0     0     0     0     0     0     0  0.00
## 3     0     0     0     0     0     0     0     0     0     0     0  0.00
## 4     0     0     0     0     0     0     0     0     0     0     0  0.00
## 5     0     0     0     0     0     0     0     0     0     0     0  0.00
##   X0.29 X0.30 X0.31 X0.33 X0.34 X0.35 X0.36 X0.37 X0.38 X0.39 X0.40 X0.41
## 1     0     0  0.00     0     0  0.00     0  0.00  0.00     0     0  0.00
## 2     0     0  0.06     0     0  0.12     0  0.06  0.06     0     0  0.01
## 3     0     0  0.00     0     0  0.00     0  0.00  0.00     0     0  0.00
## 4     0     0  0.00     0     0  0.00     0  0.00  0.00     0     0  0.00
## 5     0     0  0.00     0     0  0.00     0  0.00  0.00     0     0  0.00
##   X0.42 X0.43 X0.778 X0.44 X0.45 X3.756 X61 X278 X1
## 1 0.132     0  0.372 0.180 0.048  5.114 101 1028  1
## 2 0.143     0  0.276 0.184 0.010  9.821 485 2259  1
## 3 0.137     0  0.137 0.000 0.000  3.537  40  191  1
## 4 0.135     0  0.135 0.000 0.000  3.537  40  191  1
## 5 0.223     0  0.000 0.000 0.000  3.000  15   54  1
```

```r
#View(spambase) # ou clic sur spambase dans l'onglet Environment

table(spambase[,58])
```

```
## 
##    0    1 
## 2788 1812
```

Chargement des entêtes:

```r
spambase.names <- readLines('data/spambase.names')
spambase.names <- sub(':.*$', '', spambase.names[34:length(spambase.names)])
spambase.names [length(spambase.names) + 1] <- 'spam'

spambase.names
```

```
##  [1] "word_freq_make"             "word_freq_address"         
##  [3] "word_freq_all"              "word_freq_3d"              
##  [5] "word_freq_our"              "word_freq_over"            
##  [7] "word_freq_remove"           "word_freq_internet"        
##  [9] "word_freq_order"            "word_freq_mail"            
## [11] "word_freq_receive"          "word_freq_will"            
## [13] "word_freq_people"           "word_freq_report"          
## [15] "word_freq_addresses"        "word_freq_free"            
## [17] "word_freq_business"         "word_freq_email"           
## [19] "word_freq_you"              "word_freq_credit"          
## [21] "word_freq_your"             "word_freq_font"            
## [23] "word_freq_000"              "word_freq_money"           
## [25] "word_freq_hp"               "word_freq_hpl"             
## [27] "word_freq_george"           "word_freq_650"             
## [29] "word_freq_lab"              "word_freq_labs"            
## [31] "word_freq_telnet"           "word_freq_857"             
## [33] "word_freq_data"             "word_freq_415"             
## [35] "word_freq_85"               "word_freq_technology"      
## [37] "word_freq_1999"             "word_freq_parts"           
## [39] "word_freq_pm"               "word_freq_direct"          
## [41] "word_freq_cs"               "word_freq_meeting"         
## [43] "word_freq_original"         "word_freq_project"         
## [45] "word_freq_re"               "word_freq_edu"             
## [47] "word_freq_table"            "word_freq_conference"      
## [49] "char_freq_;"                "char_freq_("               
## [51] "char_freq_["                "char_freq_!"               
## [53] "char_freq_$"                "char_freq_#"               
## [55] "capital_run_length_average" "capital_run_length_longest"
## [57] "capital_run_length_total"   "spam"
```

Renommage des colonnes du data.frame:

```r
colnames(spambase) <- spambase.names

str(spambase)
```

```
## 'data.frame':	4600 obs. of  58 variables:
##  $ word_freq_make            : num  0.21 0.06 0 0 0 0 0 0.15 0.06 0 ...
##  $ word_freq_address         : num  0.28 0 0 0 0 0 0 0 0.12 0 ...
##  $ word_freq_all             : num  0.5 0.71 0 0 0 0 0 0.46 0.77 0 ...
##  $ word_freq_3d              : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_our             : num  0.14 1.23 0.63 0.63 1.85 1.92 1.88 0.61 0.19 0 ...
##  $ word_freq_over            : num  0.28 0.19 0 0 0 0 0 0 0.32 0 ...
##  $ word_freq_remove          : num  0.21 0.19 0.31 0.31 0 0 0 0.3 0.38 0.96 ...
##  $ word_freq_internet        : num  0.07 0.12 0.63 0.63 1.85 0 1.88 0 0 0 ...
##  $ word_freq_order           : num  0 0.64 0.31 0.31 0 0 0 0.92 0.06 0 ...
##  $ word_freq_mail            : num  0.94 0.25 0.63 0.63 0 0.64 0 0.76 0 1.92 ...
##  $ word_freq_receive         : num  0.21 0.38 0.31 0.31 0 0.96 0 0.76 0 0.96 ...
##  $ word_freq_will            : num  0.79 0.45 0.31 0.31 0 1.28 0 0.92 0.64 0 ...
##  $ word_freq_people          : num  0.65 0.12 0.31 0.31 0 0 0 0 0.25 0 ...
##  $ word_freq_report          : num  0.21 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_addresses       : num  0.14 1.75 0 0 0 0 0 0 0.12 0 ...
##  $ word_freq_free            : num  0.14 0.06 0.31 0.31 0 0.96 0 0 0 0 ...
##  $ word_freq_business        : num  0.07 0.06 0 0 0 0 0 0 0 0 ...
##  $ word_freq_email           : num  0.28 1.03 0 0 0 0.32 0 0.15 0.12 0.96 ...
##  $ word_freq_you             : num  3.47 1.36 3.18 3.18 0 3.85 0 1.23 1.67 3.84 ...
##  $ word_freq_credit          : num  0 0.32 0 0 0 0 0 3.53 0.06 0 ...
##  $ word_freq_your            : num  1.59 0.51 0.31 0.31 0 0.64 0 2 0.71 0.96 ...
##  $ word_freq_font            : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_000             : num  0.43 1.16 0 0 0 0 0 0 0.19 0 ...
##  $ word_freq_money           : num  0.43 0.06 0 0 0 0 0 0.15 0 0 ...
##  $ word_freq_hp              : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_hpl             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_george          : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_650             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_lab             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_labs            : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_telnet          : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_857             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_data            : num  0 0 0 0 0 0 0 0.15 0 0 ...
##  $ word_freq_415             : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_85              : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_technology      : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_1999            : num  0.07 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_parts           : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_pm              : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_direct          : num  0 0.06 0 0 0 0 0 0 0 0.96 ...
##  $ word_freq_cs              : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_meeting         : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_original        : num  0 0.12 0 0 0 0 0 0.3 0 0 ...
##  $ word_freq_project         : num  0 0 0 0 0 0 0 0 0.06 0 ...
##  $ word_freq_re              : num  0 0.06 0 0 0 0 0 0 0 0 ...
##  $ word_freq_edu             : num  0 0.06 0 0 0 0 0 0 0 0 ...
##  $ word_freq_table           : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ word_freq_conference      : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ char_freq_;               : num  0 0.01 0 0 0 0 0 0 0.04 0 ...
##  $ char_freq_(               : num  0.132 0.143 0.137 0.135 0.223 0.054 0.206 0.271 0.03 0 ...
##  $ char_freq_[               : num  0 0 0 0 0 0 0 0 0 0 ...
##  $ char_freq_!               : num  0.372 0.276 0.137 0.135 0 0.164 0 0.181 0.244 0.462 ...
##  $ char_freq_$               : num  0.18 0.184 0 0 0 0.054 0 0.203 0.081 0 ...
##  $ char_freq_#               : num  0.048 0.01 0 0 0 0 0 0.022 0 0 ...
##  $ capital_run_length_average: num  5.11 9.82 3.54 3.54 3 ...
##  $ capital_run_length_longest: int  101 485 40 40 15 4 11 445 43 6 ...
##  $ capital_run_length_total  : int  1028 2259 191 191 54 112 49 1257 749 21 ...
##  $ spam                      : int  1 1 1 1 1 1 1 1 1 1 ...
```

```r
class(spambase$spam)
```

```
## [1] "integer"
```

Gestion du label de spam:

```r
spambase$spam <- factor(spambase$spam, c(0,1), labels = c('nospam', 'spam'))
str(spambase$spam)
```

```
##  Factor w/ 2 levels "nospam","spam": 2 2 2 2 2 2 2 2 2 2 ...
```

```r
table(spambase$spam)
```

```
## 
## nospam   spam 
##   2788   1812
```

### Exploration

Quelques histogrammes:

```r
hist(spambase$word_freq_people)
```

![](meetup_files/figure-html/unnamed-chunk-18-1.png) 

```r
hist(spambase$`char_freq_(`)
```

![](meetup_files/figure-html/unnamed-chunk-18-2.png) 

Un histogramme plus avancé:

```r
hist(spambase$word_freq_order[spambase$spam == 'nospam'], col = 'blue', breaks = 20)
hist(spambase$word_freq_order[spambase$spam == 'spam'], col = 'red', add = T, breaks = 20)
```

![](meetup_files/figure-html/unnamed-chunk-19-1.png) 

On voit qu'il y a beaucoup de valeurs à 0 ou proche de 0 (**à voir si on normalise**).


### Modélisation

* Bref rappel des principes de machine learning
* Préparation train set / test set
* Problématique de la classification / présentation de la régression logistique
* Application de l'algo
* Interprétation du modèle
* Évaluation du modèle (score, matrice de confusion)

Pour aller plus loin, introduction au package [caret](http://topepo.github.io/caret/index.html) et tests avec différents algorithmes de machine learning (arbres de décision, random forest, gbm, *Naive Bayes*...)

## Bibliographie

* http://www.cs.cmu.edu/~eugene/research/full/detect-scam.pdf
* http://cran.r-project.org/web/views/MachineLearning.html
* http://kooperberg.fhcrc.org/logic/documents/ingophd-logic.pdf
* Lichman, M. (2013). UCI Machine Learning Repository [http://archive.ics.uci.edu/ml]. Irvine, CA: University of California, School of Information and Computer Science. 
