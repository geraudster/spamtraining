library(markdown)

shinyUI(
  navbarPage(div(img(src='240px-No-spam.svg.png', height='32px', width='32px'),
                 'Data NoBlaBla'),
             tabPanel('About',
                      includeMarkdown('about.md')),
             tabPanel('Explorer',
                      sidebarLayout(
                        sidebarPanel(
                          # TODO
                          uiOutput('variableChoice')
                        ),
                        mainPanel(
                          # TODO
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
                          actionButton("goButton", "Go!")
                        ),
                        mainPanel(
                          # TODO
                          imageOutput('modelResult')
                        )
                      )),
             tabPanel('Prédiction',
                      sidebarLayout(
                        sidebarPanel(
                          # TODO
                        ),
                        mainPanel( 
                          # TODO
                          ))),
             header = wellPanel(
               # TODO
             ),
             footer = p(br(), wellPanel(
               # TODO
             )))
)