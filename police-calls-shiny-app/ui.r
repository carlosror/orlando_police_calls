library(shiny)
library(leaflet)
library(ggmap)
crimes_vector <- c("ALARM" = "alarm", "ARSON" = "arson", "ASSAULT" = "assault", "BATTERY" = "battery", "B&E" = "b&e",
                  "DISTURBANCE" = "disturbance", "DRUGS" = "drugs", "DUI" = "dui", "FIRE" = "fire", "FRAUD" = "fraud",
                  "MISCHIEF" = "mischief", "MURDER" = "murder", "ROBBERY" = "robbery", "SUICIDE" = "suicide",
                  "SUSPICIOUS" = "suspicious", "THEFT" = "theft", "TRAFFIC" = "traffic", "TRESPASS" = "trespass", "OTHER" = "other")
crimes_checked <- c("alarm", "arson", "assault", "battery", "b&e", "disturbance", "drugs", "dui", "fire", "fraud",
                    "mischief", "murder", "robbery", "suicide", "suspicious", "theft", "trespass")
days_vector <- c("Sunday" = "Sunday", "Monday" = "Monday", "Tuesday" = "Tuesday", "Wednesday" = "Wednesday", "Thursday" = "Thursday", "Friday" = "Friday", "Saturday" = "Saturday")
days_checked <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday") 
periods_vector <- c("MIDNIGHT - 6:00 A.M." = "early_morning", "6:00 A.M. - NOON" = "morning", 
                    "NOON - 6:00 P.M." = "afternoon", "6:00 P.M. - MIDNIGHT" = "evening")
periods_checked <- c("early_morning", "morning", "afternoon", "evening")
plots_facets_vector <- c("day of week" , "time of day" , "crime category" )
years_vector <- c("2015", "2014", "2013", "2012", "2011", "2010", "2009")
locations_vector <- c("Anderson St and Division Ave, Orlando", "Fashion Square Mall, Orlando", "Millenia Mall, Orlando", "John Young Pkwy and Princeton St, Orlando",
                      "Lake Eola Park, Orlando", "International Dr and Kirkman Rd, Orlando", "Semoran and Hoffner, Orlando", "Narcoossee Rd and Lee Vista Blvd, Orlando",
                      "Mills and Colonial, Orlando", "Baldwin Park, Orlando", "S Conway Rd and Curry Ford Rd, Orlando", "Michigan St and Orange Ave, Orlando",
                      "Magnolia and Colonial, Orlando", "Lake Orlando, Orlando", "Lake Lawne, Orlando", "Gaston Edwards Park, Orlando", "Lake Rowena, Orlando",
                      "Curry Ford and Semoran, Orlando", "Lake Concord, Orlando", "Americana and Conroy, Orlando", "Millennia Park, Orlando", "Lake Pineloch, Orlando")

shinyUI(fluidPage(
  titlePanel(h3("Orlando Police Calls Map"), windowTitle = "Orlando Police Calls Map"),
  sidebarLayout (
    sidebarPanel(
           textInput("address",label=h4("Enter location or click on map"),
                     value=sample(locations_vector, size=1, replace=TRUE) ),
           
           sliderInput("radius",label=h4("Radius in miles"),
                       min=0.5,max=2.0,value=0.5, step=0.5),
           actionButton("goButton", "Search", style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
           selectInput("year", label = h4("Year"), years_vector),
           checkboxGroupInput("crimes", label = h4("Crime Type"), choices = crimes_vector, selected = crimes_checked, inline = TRUE),
           checkboxGroupInput("days_of_week", label = h4("Days of Week"), choices = days_vector, selected = days_checked, inline = TRUE),
           checkboxGroupInput("time_periods", label = h4("Time Periods"), choices = periods_vector, selected = periods_checked, inline = TRUE),
           selectInput("plots_facets", label = h4("Facet density maps and bar plots by"), plots_facets_vector),
           HTML('<a href="https://github.com/carlosror/orlando_police_calls" target="_blank"><img src = "github_icon.png" alt = "xyz"></a>
                 <a href="https://twitter.com/LrnDataScience" target="_blank"><img src = "twitter_icon.png" alt = "xyz"></a>')
    ),
    mainPanel(
        tabsetPanel(
            tabPanel("Map", leafletOutput("map",width="auto",height="640px")),
            tabPanel("Data", dataTableOutput("DataTable")),
            tabPanel("Barplots", plotOutput("barplots", width = "auto", height="640px")),
            tabPanel("Density Maps (Patience)", plotOutput("density_maps", width = "auto", height="640px")),
            tabPanel("Table", verbatimTextOutput("table")),
            tabPanel("Notes", htmlOutput("notes"))
            # tabPanel("Debug", verbatimTextOutput("debug"))
        )
    )
)))