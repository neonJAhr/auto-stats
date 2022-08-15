# setwd("~/Documents/GitHub/auto-stats")

library(shiny)
require(faux)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Auto-stats"),
    tabsetPanel(
    #  tabPanel("Choose Dataset",
    # Tab for uploading datasets, but it would require some more finesse
    #        sidebarPanel(
    #          radioButtons("pickData", 
    #                       "Choose the dataset",
    #                       choices = c("moon", "kitchen rolls"), 
    #                       selected = character(0)),
    #          radioButtons("verbosity",
    #                       "Which level of verbosity would you like?",
    #                       choices = c("Low Verbosity", "Medium Verbosity",
    #                                   "High Verbosity"), 
    #                       selected = character(0))),
    #
    #        mainPanel(
    #           plotOutput("qqPlot")
    #        )
    #    ),
    
    tabPanel("Explore Options",
        sidebarPanel(
          radioButtons("typeData", 
                       "What type of data do you have?",
                       choices = c("unpaired", "paired"), 
                       selected = character(0)),
          
          radioButtons("verbosity",
                       "Which level of verbosity would you like?",
                       choices = c("Low Verbosity", "Medium Verbosity",
                                   "High Verbosity"), 
                       selected = character(0)),
          tags$hr(),
          
          radioButtons("outliers",
                       label = "Are there any significant outliers in the data?",
                       choices = c("No" = 0, "Yes" = 1), 
                       selected = character(0)),

          conditionalPanel(condition = "input.outliers == 1",
                           radioButtons("outliers_cons",
                                         label = "Are these outliers consequential?",
                                         choices = c("No" = 0, "Yes" = 1), 
                                        selected = character(0))),
          tags$hr(),
          
          radioButtons("skewness",
                       label = "How skewed is the data?",
                       choices = c("No skew" = 0, "Moderate skew" = 1, "Strong skew" = 2), 
                       selected = 0),
          conditionalPanel(condition = "input.skewness != 0",
                           radioButtons("skewness_cons",
                                        label = "Is the skewness consequential?",
                                        choices = c("No" = 0, "Yes" = 1), 
                                        selected = character(0))),
          tags$hr(),
          
          radioButtons("normality",
                       label = "Does the data resemble a normal distribution?",
                       choices = c("Yes" = 0, "Somewhat" = 1, "No" = 2), 
                       selected = 0),
          conditionalPanel(condition = "input.normality != 0",
                           radioButtons("normality_cons",
                                        label = "Is this distribution consequential?",
                                        choices = c("No" = 0, "Yes" = 1), 
                                        selected = character(0))),
          tags$hr()
      ),
      mainPanel(
        textOutput("noData"),
        plotOutput("qqPlot")
      )
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
  # Part "Choose Dataset"
  #  reactive({
  #    if (input$typeData == "moon") {
  #      data <- read.csv("moonAggression.csv")
  #    } else if (input$typeData == "kichenRolls") {
  #      data <- 
  #    } else {
  #      noData <- "Select a Dataset"
  #    }
  #  })
  
  # Part "Explore Options"
  reactive({
    groups <- c(group1 = "Group 1",
                group2 = "Group 2")
    if (input$typeData == "paired") data <- sim_design(within = groups)
    else if (input$typeData == "unpaired") data <- sim_design(between = groups)
    else noData <- "Choose type of data"
  })
    output$qqPlot <- renderPlot({
      qqnorm(x = data[,1], y = data[,2])
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
