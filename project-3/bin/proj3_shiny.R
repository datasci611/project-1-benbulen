#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1], header=TRUE, row.names=1)
names <-rownames(df)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Top 10 UNC Collaborators by University"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("Collaborator", "University:", 
                  choices=colnames(df)),
      hr(),
      helpText("Doctored Collaboration Data to Work on Shiny App")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("barPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$barPlot <- renderPlot({
    barplot(df[,input$Collaborator], 
            main=input$Collaborator,
            ylab="Number of Collaborations",
            xlab="Purpose of Collaboration",
            names.arg=names,
            ylim=c(0,1.5*max(unlist(df[,input$Collaborator]))))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

