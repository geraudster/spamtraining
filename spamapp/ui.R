library(markdown)

shinyUI(
  navbarPage(div(img(src='240px-No-spam.svg.png', height='32px', width='32px'),
                 'Data NoBlaBla'),
             tabPanel('About',
                      includeMarkdown('about.md')),
             tabPanel('Explorer les données',
                      sidebarLayout(
                        sidebarPanel(
                          # TODO
                          uiOutput('variableChoice'),
                          width = 3
                        ),
                        mainPanel(
                          # TODO
                          wellPanel(includeMarkdown('data_exploration.md')),
                          h2('Boxplot'),
                          imageOutput('termBoxplot', width = '500', height = '400'),
                          h2('Répartition'),
                          h3('Données d\'entrainement'),
                          tableOutput('contingencyTable'),
                          h3('Données de validation'),
                          tableOutput('contingencyTableTest'),
                          h2('Échantillon'),
                          tableOutput('trainDataTable')
                        )
                      )),
             tabPanel('Modèle',
                      sidebarLayout(
                        sidebarPanel(
                          selectInput('modelType', 'Choix de l\'algo',
                                      c('Régression logistique' = 'glm',
                                        'Arbre de décision' = 'rpart')),
                          sliderInput('seuil', 'Seuil',
                                      min = 0, max = 1,
                                      value = 0.5, step = 0.05),
                          width = 3
                        ),
                        mainPanel(
                          wellPanel(includeMarkdown('model_evaluation.md')),
                          # TODO
                          imageOutput('modelResult', width = '500', height = '400'),
                          tableOutput('modelMetrics')
                        )
                      )),
#              tabPanel('Prédiction',
#                       sidebarLayout(
#                         sidebarPanel(
#                           # TODO
#                         ),
#                         mainPanel( 
#                           # TODO
#                           ))),
             footer = p(br(), wellPanel(
               includeHTML('license.html')
             )))
)