library(shiny)
library(tidyverse)
library(mclust)

source("helper_functions.R",local=F)

# Define ui for Shiny APP
ui<-navlistPanel("Project 2 (Yilun Li)", widths = c(3,9),
  # Organize the fitst tab
  tabPanel(title = "1) Trend",
           fluidPage(
             # Sidebar layout with input and output definitions
             sidebarLayout(
               # Sidebar panel for inputs
               sidebarPanel(
                 helpText("Please select a variable and view its trend over years. 
                          The first plot shows the times of selected kind of assistance in different years.
                          And the second plot shows the average amout of selected kind of assistance in different years, normalized by the times of its occurence."),
                 # Select Input with a Select Box
                 selectInput("select", width='400px',
                             h3("Select Variable for x-axis"),
                             choices = c("Food Pounds","Clothing Items","Diapers","School Kits","Hygiene Kits","Financial Support"), 
                             selected = "Food Pounds")
               ),
               # Main panel for displaying outputs
               mainPanel(
                 # Plot results with ggplot()
                 plotOutput("Counting_Result"),
                 plotOutput("Ave_Result")
               )
             )
           )
  ),
  
  # Organize the second tab
  tabPanel(title = "2) Linear Regression",
           fluidPage(
             # Vertical layout with input and output definitions
             verticalLayout(
               # Sidebar panel for inputs
               sidebarPanel(
                 helpText("Please select a variable and view its linear regression result on the number of people in the family, which is indicated in the column \"Food Provided for\".
                          Due to the large sample size, please wait a few seconds after your selection."),
                 # Select Input with a Select Box
                 selectInput("select2", width='400px',
                             h3("Select Variable for x-axis"),
                             choices = c("Food Pounds","Clothing Items","Hygiene Kits"), 
                             selected = "Food Pounds")
               ),
               # Main panel for displaying outputs
               mainPanel(
                 # Plot results with ggplot()
                 plotOutput("Reg_Result")
               )
             )
           )
  ),
  
  # Organize the third tab
  tabPanel(title = "3) Cluster Analysis",
           fluidPage(
             # Sidebar layout with input and output definitions
             sidebarLayout(
               # Sidebar panel for inputs
               sidebarPanel(
                 helpText(paste("Please select two different variables, and input the number of cluster according to your need.
                                Clustering result is given based on your choice and K-means Clustering Method.
                                Due to the large sample size, please wait a few moments after your selection.")),
                 # Select Input with a Select Box
                 selectInput("select31", width='400px',
                             h3("Select Variables 1 for cluster analysis"),
                             choices = c("Food Pounds","Clothing Items","Financial Support"), 
                             selected = "Food Pounds"),
                 selectInput("select32", width='400px',
                             h3("Select Variables 2 for cluster analysis"),
                             choices = c("Food Pounds","Clothing Items","Financial Support"), 
                             selected = "Clothing Items"),
                 # Select Input indicating the number of cluster
                 numericInput("num", 
                              h3("Number of Cluster"), 
                              value=3)),
               # Main panel for displaying outputs
               mainPanel(
                 # Plot results with ggplot()
                 plotOutput("Cluster_Result")
               )
             )
           )
  )
)

# Define server logic to present results
server<-function(input,output){
  # Data table output using renderPlot(), linked to ui
  output$Counting_Result <- renderPlot({
    Trend_plot_count(input$select)
  })
  output$Ave_Result <- renderPlot({
    Trend_plot_ave(input$select)
  })
  output$Reg_Result <- renderPlot({
    Reg_plot(input$select2)
  })
  output$Cluster_Result <- renderPlot({
    Cluster_plot(input$select31,input$select32,input$num)
  })
}

shinyApp(ui=ui, server=server)
