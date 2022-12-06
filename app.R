#Project - Product Development
#DATA 824
#Sara Hammersmith Peaslee

library(shiny)
library(leaflet)

#Cleaned Data - for process, see "PPP Data Cleaning.R"
pueblo<-read.csv("puebloppp.csv")

#UI ----
ui <- fluidPage(
  
  titlePanel("PPP Loans"),
  
  sidebarLayout(
    sidebarPanel(
      p("Hover over a point to see Business Name, Jobs Retained, and Loan Approval Date."),
      
      column(12,
             dateRangeInput(inputId="daterange", label="Select the Date Range",
                            start=min(pueblo$DateApproved),
                            end=max(pueblo$DateApproved),
                            min=min(pueblo$DateApproved),
                            max=max(pueblo$DateApproved),
                            format="yyyy-mm-dd",separator="to")),
    ),
    
    
    mainPanel(
      h1("Colorado",align="center"),
      leafletOutput("pueblomap", height=1000)
  ),
    
    )
  ) 


#Server ----
server <- function(input, output, session) {
  
  
  #SERVER:
  output$startdate<-renderText({as.character(input$daterange[1])})
  output$enddate<-renderText({as.character(input$daterange[2])})
  
  # create the leaflet map  
  output$pueblomap <- renderLeaflet({
    #Subset of data based on date range input
    s=subset(pueblo,pueblo$DateApproved>=input$daterange[1] & pueblo$DateApproved<=input$daterange[2])
    
    #Creating new column for pop-up on map
    s <- mutate(s, cntnt=paste0('<strong>Name: </strong>',BusinessName,
                                '<br><strong>Jobs:</strong> ', JobsRetained,
                                '<br><strong>Date:</strong> ', DateApproved)) 
    leaflet(s) %>% 
      addCircles(lng = ~long, lat = ~lat) %>% 
      addTiles() %>%
      addCircleMarkers(data = s, lat =  ~lat, lng =~long, 
                       radius = 6, popup = ~as.character(cntnt), 
                       stroke = FALSE, fillOpacity = 0.8) 
})
}
# Run the app ----
shinyApp(ui = ui, server = server)
