# Sujet Meetup TDS NoBlaBla
Géraud  

## Programme

![R](images/Rlogo.png)

R est un langage de programmation et outil d'analyse statistique dont la popularité ne cesse
de croître parmi la communauté des data heroes. 
Au cours de cet atelier, nous allons travailler autour du sujet de la détection de spam
et ainsi:

* découvrir les bases du langages R
* apprendre à charger et manipuler des jeux de données
* appliquer des algorithmes de Machine Learning pour la détection de spam
* interpréter et évaluer les modèles générés

### Pré-requis

Vous devez avoir installé les outils suivants:

* R 3.2:
    * [Windows](http://cran.rstudio.com/bin/windows/base/)
    * [MacOS](http://cran.rstudio.com/bin/macosx/)
    * [Linux](http://cran.rstudio.com/bin/linux/)
* RStudio Desktop: http://www.rstudio.com/products/rstudio/download/

Les packages suivants doivent être installés (lancer Rstudio puis menu Tools -> Install packages...):

* rpart
* rpart.plot

![Installation package](images/rstudio-package.png)

Les jeux de données doivent être téléchargés depuis les urls suivantes:

* [Données d'entraînement](https://raw.githubusercontent.com/geraudster/spamdata/master/emails_train.csv)
* [Données de test](https://raw.githubusercontent.com/geraudster/spamdata/master/emails_test.csv)

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

[Rstudio](http://www.rstudio.com/) est une société qui publie l'environnement de développement Rstudio (et d'autres services comme ShinyApps, Rpubs...)

Plusieurs versions sont disponibles dont une version *Open Source*.

## Les bases du langage

R est une grosse calculatrice qui fournit une interface REPL (Read-Eval-Print-Loop).

### Opérations arithmétiques de base


```r
> 1 + 2
```

```
## [1] 3
```

```r
> 6 * 7
```

```
## [1] 42
```

```r
> 12 - 30
```

```
## [1] -18
```

```r
> 5 / 13
```

```
## [1] 0.3846154
```

```r
> 10 * (5 + 3)
```

```
## [1] 80
```

Exo:

* Calculer le carré de 5
* Calculer la somme des entiers de 1 à 10

```r
> # Carré de 5
> 5 * 5
```

```
## [1] 25
```

```r
> 5 ^ 2
```

```
## [1] 25
```

```r
> # Somme des 10 premiers entiers
> 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10
```

```
## [1] 55
```

```r
> 10 * (10 + 1 ) / 2
```

```
## [1] 55
```

### Fonctions


```r
> log(5)
```

```
## [1] 1.609438
```

```r
> sqrt(25)
```

```
## [1] 5
```

À tout moment, il est possible d'accéder à l'aide en ligne:


```r
> ?log
> ?sqrt
> ?`+`
```

Les paramètres de fonction:

```r
> # log en base 10
> log(5, base = 10)
```

```
## [1] 0.69897
```


Exo:

* Calculer la racine carrée de 2
* Calculer la norme d'un vecteur de coordonnées (3,5):
$||\vec{u}|| = \sqrt{x^2 + y^2}$


```r
> # Racine carrée de 2
> sqrt(2)
```

```
## [1] 1.414214
```

```r
> # Norme du vecteur
> sqrt(3^2 + 5^2)
```

```
## [1] 5.830952
```

### Variables

Affecter un résultat à une variable:

```r
> resultat <- 1 + 2
> resultat
```

```
## [1] 3
```

```r
> resultat * 2
```

```
## [1] 6
```

### Vecteurs

Manipuler des vecteurs:


```r
> c(42,123)
```

```
## [1]  42 123
```

```r
> chiffres <- c(1,2,3,4,5,6,7,8,9)
> chiffres
```

```
## [1] 1 2 3 4 5 6 7 8 9
```

```r
> chiffres <- 1:9
> chiffres
```

```
## [1] 1 2 3 4 5 6 7 8 9
```

Fonctions arithmétiques:

```r
> length
> mean
> sum
```

Exo:

* Créer un vecteur contenant les 10 premiers entiers
* Calculer la somme des 10 premiers entiers
* Calculer la moyenne des 10 premiers entiers


```r
> # Création du vecteur
> entiers <- 1:10
> 
> # Calcul de la somme
> sum(entiers)
```

```
## [1] 55
```

```r
> # Calcul de la moyenne
> mean(entiers)
```

```
## [1] 5.5
```

On peut aussi utiliser des chaînes de caractères:

```r
> prenoms <- c('Alice', 'Bob', 'Carole')
```

Exo:

* Créer un vecteur contenant les éléments 42 et "Hello"


```r
> c(42, 'Hello')
```

```
## [1] "42"    "Hello"
```

Les vecteurs ne contiennent que des données du même type:

```r
> c(1,2,'toto')
```

```
## [1] "1"    "2"    "toto"
```

### Vecteurs - la suite

Opérations entre scalaires et vecteurs:

```r
> 1:9 + 2
```

```
## [1]  3  4  5  6  7  8  9 10 11
```

```r
> 1:9 * 3
```

```
## [1]  3  6  9 12 15 18 21 24 27
```

Opérations entre vecteurs:

```r
> 1:9 * 1:9
```

```
## [1]  1  4  9 16 25 36 49 64 81
```

Exo:

* Que se passe-t-il si vous exécutez le code `{r} 1:9 * 1:9` ?
* Essayez `{r} 1:9 * 2:4`

### Vecteurs - la fin

Pour sélectionner des éléments:

```r
> prenoms[2]
```

```
## [1] "Bob"
```

```r
> prenoms[2:3]
```

```
## [1] "Bob"    "Carole"
```

```r
> prenoms[c(FALSE, TRUE, TRUE)]
```

```
## [1] "Bob"    "Carole"
```

Trouver les éléments répondant à une condition:

```r
> entiers > 5
```

```
##  [1] FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
```

```r
> entiers[entiers > 5]
```

```
## [1]  6  7  8  9 10
```

```r
> subset(entiers, entiers > 5)
```

```
## [1]  6  7  8  9 10
```

Exo:

* Trouver les entiers pairs (utiliser %% pour le modulo)


```r
> positionPairs <- (entiers %% 2) == 0
> entiers[positionPairs]
```

```
## [1]  2  4  6  8 10
```

### Quelques valeurs spéciales

Tester les opérations suivantes:


```r
> 1/0
```

```
## [1] Inf
```

```r
> sqrt(-1)
```

```
## [1] NaN
```

```r
> entiers[20]
```

```
## [1] NA
```

### Data Frames

Les Data Frames permettent de stocker des tableaux de données, "à la Excel".
**cf. slides**


```r
> prenoms <- c('Alice', 'Bob', 'Carole')
> sexe <- c('F', 'M', 'F')
> ages <- c(24, 30, 23)
> monDataFrame <- data.frame(prenoms, sexe, ages)
> monDataFrame
```

```
##   prenoms sexe ages
## 1   Alice    F   24
## 2     Bob    M   30
## 3  Carole    F   23
```

```r
> monDataFrame[2, 'prenoms']
```

```
## [1] Bob
## Levels: Alice Bob Carole
```

```r
> monDataFrame$prenoms
```

```
## [1] Alice  Bob    Carole
## Levels: Alice Bob Carole
```

Exo:

* Créer le data frame monDF avec les données ci-dessus
* Récupérer l'ensemble des couples (prenom, age)
* Calculer la moyenne d'âge
* Quelle personne est la plus âgée (on utilisera la fonction `which.max`)?


```r
> monDataFrame[, c('prenoms', 'ages')]
```

```
##   prenoms ages
## 1   Alice   24
## 2     Bob   30
## 3  Carole   23
```

```r
> mean(monDataFrame$ages)
```

```
## [1] 25.66667
```

```r
> monDataFrame[which.max(monDataFrame$ages),]
```

```
##   prenoms sexe ages
## 2     Bob    M   30
```

Table de contingence:

```r
> table(monDataFrame$sexe)
```

```
## 
## F M 
## 2 1
```


Pour modifier le data.frame:

```r
> monDataFrame$recu <- c(TRUE, FALSE, TRUE)
> table(monDataFrame$sexe, monDataFrame$recu)
```

```
##    
##     FALSE TRUE
##   F     0    2
##   M     1    0
```

Moyen mnémotechnique pour les indices des data.frames: [ROW, COL] -> ROW is COol

### Structures de contrôle (if, loop..)

Voir 

```r
> ?Control
```

## Bibliographie

* Intro à R: https://github.com/juba/intro-r
