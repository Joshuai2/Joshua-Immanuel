library(shiny)
library(fmsb)
library(gridExtra)

ui = fluidPage(
  titlePanel("NBA Awards Predictor"), # Title
  
  sidebarLayout(
    sidebarPanel(
      h3("Award Selection"),
      
      # Dropdowns
      selectInput(inputId ="award", "What award do you want to predict?", 
                  choices = c("MVP", "Rookie of the Year", "Defensive Player of the Year",
                              "Sixth Man of the Year")),
      
      numericInput(inputId = "year", label = ("Year (e.g. 1980)"), 
                   value = 2019, min = 1989, max = 2019),
      
      actionButton("button", "Load Preview Awards")
    ),
    
    mainPanel(
      h3("2019 Top Five Predictions"),
      verbatimTextOutput("predictions")
      
      #h3("Radar Plot"),
      #plotOutout("radar")
    )
  )
)

# Define server logic ----
server = function(input, output, session) {
  
  active_awards2019 = eventReactive(input$button, input$award)

  active_year = eventReactive(input$button, input$year)
  
  #matching dataset year
  active_dataset = eventReactive(input$button, {
    switch(paste0("players_", active_year()),
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
  
  active_awards = eventReactive(input$button, {
    switch(input$award,
           "MVP" = active_dataset()$mvp, 
           "Rookie of the Year" = active_dataset()$roy, 
           "Defensive Player of the Year"= active_dataset()$dpoy,
           "Sixth Man of the Year" = active_dataset()$smoy
    )
  })

  cleaning_df = eventReactive(input$button,{
    cleaning_df = data.frame(Player = active_dataset()$player, 
                    Position = active_dataset()$pos, 
                    Age = active_dataset()$age,
                    Chance = active_awards()) 
    return(cleaning_df)
  })
 
  #create column for players and percentages
  output$predictions = renderPrint(
  if(active_year() == 2019){
   if(active_awards2019() == "MVP"){
     head(df_mvp)
   }else if(active_awards2019() == "Rookie of the Year"){
     head(df_roy)
   }else if(active_awards2019() == "Defensive Player of the Year"){
     head(df_dpoy)
   }else if(active_awards2019() == "Sixth Man of the Year"){
     head(df_smoy)
   }
  }else{
        cleaning_df()[cleaning_df()$Chance == 1,]
    }
  )
  
  

}
# Launch the App
shinyApp(ui, server)
