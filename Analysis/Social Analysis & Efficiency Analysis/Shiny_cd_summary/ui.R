
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com

library(shiny)
library(plotly)

request_types = c("Bulky Items", "Dead Animal Removal", "Graffiti Removal",
                  "Electronic Waste", "Illegal Dumping Pickup", "Other",
                  "Metal/Household Appliances", "Homeless Encampment",
                  "Single Streetlight Issue", 
                  "Multiple Streetlight Issue", "Feedback", "Report Water Waste")

CD_lists = c(as.character(1:15), "city of LA")

social_types = c("Median_Age", "Median_Household_Income")

ui <- navbarPage(
    
    "Requesting Analysis",
    
    fluid = TRUE, 
    
    tabPanel("Regional Requests Analysis",
             
             
             sidebarLayout(
                 sidebarPanel(
                     selectInput(inputId = "CD", 
                                 label = "Council Districts: ", 
                                 choices = CD_lists, 
                                 multiple = TRUE, selectize = TRUE,
                                 selected = "city of LA"),
                     
                     actionButton(inputId = "button_cd",
                                  label = "Submit",
                                  style='padding:3px'),
                     
                     width = 3),
                 
                 mainPanel(
                     fluidRow(
                         tableOutput('cd_summary'))
                     #                      hr(),
                     #                      tableOutput('table2'))
                 )
             ),
             
             hr(),
             
             fluidRow(
                 column(6,
                        plotlyOutput(outputId = "plot_income")),
                 column(6,
                        plotlyOutput(outputId = "plot_unemployment")))
    ),
    
    tabPanel("Requests Type Analysis",
             
             sidebarPanel(
                 selectInput(inputId = "request_type", 
                             label = "Request Type: ", 
                             choices = request_types, 
                             multiple = FALSE, selectize = TRUE,
                             selected = "Metal/Household Appliances"),
                 
                 selectInput(inputId = "social_type", 
                             label = "Social Characteristics: ", 
                             choices = social_types, 
                             multiple = FALSE, selectize = TRUE,
                             selected = "Median_Household_Income"),
                 
                 actionButton(inputId = "button_req",
                              label = "Submit"),
                 
                 width = 4),
             
             mainPanel(
                 fluidRow(
                     plotOutput(outputId = 'req_summary')))
             
    ),
    
    tabPanel("Requests Efficiency Analysis",
             
             fluidRow(
                 column(6,
                        tableOutput(outputId = "type_summary")
                 ),
                 
                 column(4,
                        plotOutput(outputId = "wc")))
             
    ),
    
tabPanel("Department Efficiency Analysis",
         
         column(3,
         actionButton(inputId = "dep_source",
                     label = "Department and request source")),
         
         column(3,
         actionButton(inputId = "dep_type",
                     label = "Department and request type")),
         
         column(3,
         actionButton(inputId = "dep_cd",
                     label = "Department and Council Districts")),
         
         plotOutput("dep_plot")
         )

)


