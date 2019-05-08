library(shiny)

ui = fluidPage(
  titlePanel("NBA Awards Predictor"), # Title
  
  sidebarLayout(
    sidebarPanel(
      h3("Award Selection"),
      
      # Dropdowns
      selectInput(inputId ="award", "What award do you want to predict?", 
                  choices = c("MVP", "Rookie of the Year", "Defensive Player of the Year",
                              "Sixth Man", "Most Improved Player")),
      
      numericInput(inputId = "year", label = ("Year (e.g. 1980)"), 
                   value = 2019, min = 1989, max = 2019),
      
      actionButton("button", "Load Preview Awards")
    ),
    
    mainPanel(
      h3("Top Five Predictions"),
      verbatimTextOutput("predictions")
      
      #h3("Radar Plot"),
      #plotOutout("radar")
    )
  )
)

# Define server logic ----
server = function(input, output, session) {
  
  active_awards = eventReactive(input$button, {
    switch(active_awards(), 
           "MVP" = active_dataset()$mvp_odds,
           "Rookie of the Year" = active_dataset()$roy_odds,
           "Defensive Player of the Year" = active_dataset()$dpoy_odds,
           "Sixth Man" = active_dataset()$smoy_odds
           #"Most Improved Player" = active_dataset()[with(mip_2019, order(-mip_odds)),] different dataset
    )
  })
  
  #matching dataset year
  active_dataset = eventReactive(input$button, {
    switch(paste0("players_", input$year),
           "players_1989" = players_1989,
           "players_1990" = players_1990,
           "players_1991" = players_1991,
           "players_1992" = players_1992,
           "players_1993" = players_1993,
           "players_1994" = players_1994,
           "players_1995" = players_1995,
           "players_1996" = players_1996,
           "players_1997" = players_1997,
           "players_1998" = players_1998,
           "players_1999" = players_1999,
           "players_2000" = players_2000,
           "players_2001" = players_2001,
           "players_2002" = players_2002,
           "players_2003" = players_2003,
           "players_2004" = players_2004,
           "players_2005" = players_2005,
           "players_2006" = players_2006,
           "players_2007" = players_2007,
           "players_2008" = players_2008,
           "players_2009" = players_2009,
           "players_2010" = players_2010,
           "players_2011" = players_2011,
           "players_2012" = players_2012,
           "players_2013" = players_2013,
           "players_2014" = players_2014,
           "players_2015" = players_2015,
           "players_2016" = players_2016,
           "players_2017" = players_2017,
           "players_2018" = players_2018,
           "players_2019" = players_2019
           
           )
  })
  #fit_mvp = eventReactive(input$perform, ) if we can generalize the fit, then develop this

  #create column for players and percentages
  cleaning_data = eventReactive(input$button, {
    cbind(active_dataset$player, active_awards())
  })
  output$predictions = renderPrint(
    cleaning_data()
  )
  
  
}

# Launch the App
shinyApp(ui, server)