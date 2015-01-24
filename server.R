library(shiny)
library(ggplot2)
library(googleVis)
library(xtable)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  output$distPlot <- renderPlot({
    #x    <- faithful[, 2]  # Old Faithful Geyser data
    #y    <- faithful[, 1]
    
    set.seed(1000)
    model <- kmeans(faithful, centers = input$K)
    #groups <- model$cluster
    
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    faithful$cluster <- as.factor(model$cluster)
    # draw the histogram with the specified number of bins
    #plot(x, y, col = as.factor(groups))
    ggplot(faithful, aes(x = waiting, y = eruptions, colour = cluster)) + geom_point() +
      labs(x = 'Waiting time to next eruption (min.)', y = 'Eruption time (min.)', 
           title = 'Old Faithful geyser in Yellowstone National Park, Wyoming, USA')
  })
  
  h5('What are the corresponding cluster centers?')
  
   output$matrix <- renderGvis({
     set.seed(1000)
     model <- kmeans(faithful, centers = input$K)
     results <- as.data.frame(cbind(center = 1:input$K, round(model$centers, 2)))
     gvisTable(results); 
     # gvisTable(as.data.frame(model$centers));  
   })
  
#     output$matrix <- renderUI({
#       set.seed(1000)
#       model <- kmeans(faithful, centers = input$K)
#       
#       M <- matrix(round(model$centers, 2), ncol = 2)
#       #M <- matrix(rep(1,6),nrow=3)
#       colnames(M) <- c('waiting', 'eruptions')
#       rownames(M) <- c(1 : input$K)
#       #rownames(M) <- c('a','b','c')
#       M <- print(xtable(M, align=rep("c", ncol(M)+1)), 
#                  floating=FALSE, tabular.environment="array", comment=FALSE, print.results=FALSE)
#       html <- paste0("$$", M, "$$")
#       list(
#         tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript'),
#         HTML(html)
#       )
#     })


})