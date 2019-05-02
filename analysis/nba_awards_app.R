library(shiny)

ui = fluidPage(
  titlePanel("NBA Awards Predictor"), # Title
  
  sidebarLayout(
    sidebarPanel(
      h3("Award Selection"),
      
      # Dropdowns
      selectInput("aw", "What award do you want to predict?", 
                  choices = c("MVP", "Rookie of the Year", "Defensive Player of the Year",
                              "Sixth Man", "Most Improved Player")),
      
      numericInput(inputId = "year", label = ("Year (e.g. 1980)"), 
                   value = 2019, min = 1989, max = 2019),
      
      submitButton("Load Preview Awards")
    ),
    
    mainPanel("CONTENT GOES HERE")
  )
)

# Define server logic ----
server = function(input, output, session) {
  
}

# Launch the App
shinyApp(ui, server)