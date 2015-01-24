library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Splitting the faithful data into K groups with K-Means"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h5("How many clusters?"),
      sliderInput("K",
                  "Number of clusters:",
                  min = 2,
                  max = 10,
                  value = 2),
      submitButton(text = "Submit clusters")
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      uiOutput('matrix')
    )
  )
))