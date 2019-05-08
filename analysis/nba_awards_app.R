library(shiny)
library(fmsb)
library(gridExtra)
data("mtcars")

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
    
    mainPanel(
      column(6,plotOutput(outputId="plotgraph", width="700px",height="500px"))
    )
  )
)

# Define server logic ----
server = function(input, output, session) {
  
  set.seed(123)
  pt1 <- reactive({
    radarchart( mtcars  , axistype=1 , 
                
                #custom polygon
                pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                
                #custom the grid
                cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                
                #custom labels
                vlcex=0.8 
    )
  })
  pt2 <- reactive({
    radarchart(mtcars, axistype=1 , 
                
                #custom polygon
                pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                
                #custom the grid
                cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                
                #custom labels
                vlcex=0.8 
    )
  })
  pt3 <- reactive({
    radarchart( mtcars  , axistype=1 , 
                
                #custom polygon
                pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                
                #custom the grid
                cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                
                #custom labels
                vlcex=0.8 
    )
  })
  output$plotgraph = renderPlot({
    ptlist <- list(pt1(),pt2(),pt3())
    wtlist <- c(input$wt1,input$wt2,input$wt3)
    # remove the null plots from ptlist and wtlist
    to_delete <- !sapply(ptlist,is.null)
    ptlist <- ptlist[to_delete] 
    wtlist <- wtlist[to_delete]
    if (length(ptlist)==0) return(NULL)
    
    grid.arrange(grobs=ptlist,widths=wtlist,ncol=length(ptlist))
  })
  
  
}

# Launch the App
shinyApp(ui, server)