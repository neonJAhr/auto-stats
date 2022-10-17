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
    tabPanel("Introduction", # Requires Dependency on Verbosity Level
             tags$h2("1"),
             tags$h4("What are you achieving with this test?"),
             "Dear user,
You selected to conduct a Student's t-test. This test checks whether the data follows a Student's t-Distribution under the null hypothesis.
It is often used to see whether the means of two sets of data are significantly different from one another.",
             tags$h4("What is Null-Hypothesis Significance Testing (NHST)?"),
             "When researchers want to test whether some property or parameter has an effect on the distribution of observed data, 
             they conduct a null hypothesis test. In this case, the null hypothesis assumes that the parameter influencing the distribution has no effect, 
             i.e. it is equal to zero. In contrast, the alternative/statistical hypothesis calculates the size of the effect on the distribution.
             Statistical significance is asserted via the p-value. This value calculated by the probability of obtaining 
             a parameter that is at least as extreme as the observed parameter, assuming the null hypothesis to be correct/true. 
             In other words, were one to repeat this experiment and collect data each time, the chance of getting a test result that is as high 
             or higher as the observed result would only occur in p-value*100 percent of the time. Significance is assumed if the p-value falls 
             below some previously asserted threshold value, usually set to 0.05, also known as the alpha level."
    ),
    tabPanel("Examine Options",
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
                       label = "Do the data resemble a normal distribution?",
                       choices = c("Yes" = 0, "Somewhat" = 1, "No" = 2), 
                       selected = 0),
          conditionalPanel(condition = "input.normality != 0",
                           radioButtons("normality_cons",
                                        label = "Is this distribution consequential?",
                                        choices = c("No" = 0, "Yes" = 1), 
                                        selected = character(0))),
          tags$hr(),
          
          radioButtons("variance",
                       label = "Do both groups have an equal amount of variance?",
                       choices = c("Yes" = 0, "Somewhat" = 1, "No" = 2), 
                       selected = 0),
          conditionalPanel(condition = "input.variance != 0",
                           radioButtons("variance_cons",
                                        label = "Is this difference in variance consequential?",
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
