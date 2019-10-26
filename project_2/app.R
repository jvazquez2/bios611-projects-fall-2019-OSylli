library(shiny)
library(tidyverse)
library(mclust)

source("helper_functions.R",local=F)

# Define ui for Shiny APP
ui<-navlistPanel("Project 2 (Yilun Li)", widths = c(3,9),
                 
                 # Introduction Tab
                 tabPanel(title = "Introduction",
                          fluidPage(
                            # Sidebar layout with input and output definitions
                            verticalLayout(
                              # Sidebar panel for inputs
                              sidebarPanel(
                                "Background and Purpose of Project"
                              ),
                              # Main panel for displaying outputs
                              mainPanel(
                                textOutput("Intro_data_0"),
                                br(),
                                textOutput("Intro_data_1"),
                                textOutput("Intro_data_2"),
                                textOutput("Intro_data_3"),
                                textOutput("Intro_data_4"),
                                textOutput("Intro_data_5"),
                                textOutput("Intro_data_6"),
                                textOutput("Intro_data_7"),
                                textOutput("Intro_data_8"),
                                textOutput("Intro_data_9"),
                                textOutput("Intro_data_10"),
                                br(),
                                textOutput("Intro_0"),
                                br(),
                                textOutput("Intro_1"),
                                textOutput("Intro_2"),
                                textOutput("Intro_3")
                              )
                            )
                          )
                 ),               
                 
                 # Organize the fitst tab
                 tabPanel(title = "Part 1: Trend",
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
                 tabPanel(title = "Part 2: Linear Regression",
                          fluidPage(
                            # Vertical layout with input and output definitions
                            sidebarLayout(
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
                                plotOutput("Reg_Result"),
                                tableOutput("Reg_Table_Result"),
                                textOutput("Reg")
                              )
                            )
                          )
                 ),
  
                 # Organize the third tab
                 tabPanel(title = "Part 3: Cluster Analysis",
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
                                            choices = c("Food Pounds","Clothing Items","Diapers"), 
                                            selected = "Food Pounds"),
                                selectInput("select32", width='400px',
                                            h3("Select Variables 2 for cluster analysis"),
                                            choices = c("Food Pounds","Clothing Items","Diapers"), 
                                            selected = "Clothing Items"),
                                # Select Input indicating the number of cluster
                                radioButtons("num", width='400px',
                                             h3("Number of Cluster"),
                                             choices=list("2"=2,"3"=3,"4"=4,"5"=5),
                                             selected=3)),
                              # Main panel for displaying outputs
                              mainPanel(
                                # Plot results with ggplot()
                                plotOutput("Cluster_Result"),
                                textOutput("Cluster")
                              )
                            )
                          )
                 )
)

# Define server logic to present results
server<-function(input,output){
  output$Intro_data_0<-renderText("The dataset of the project is provided by Urban Ministries of Durham (UMD) and has recorded the assistance to those in need. 
                                  It contains a collection of data with 79838 observations from 1990's to 2019. variables in the dataset mainly include:")
  output$Intro_data_1<-renderText("Date---Date when the case occurred")
  output$Intro_data_2<-renderText("Client File Number---Identity of the clients")
  output$Intro_data_3<-renderText("Bus Tickets (Number of)---Number of bus tickets that each individual or family received")
  output$Intro_data_4<-renderText("Food Provided for---Number of people in the family for which food was provided")
  output$Intro_data_5<-renderText("Food Pounds---Number of pounds of food that each individual or family received when shopping at UMD food pantry")
  output$Intro_data_6<-renderText("Clothing Items---Number of clothing items received per family or individual")
  output$Intro_data_7<-renderText("Diapers---Number of packs of diapers received (on aver age they are receiving packs of an average of 22 diapers, and 2 packs per child.)")
  output$Intro_data_8<-renderText("School Kits---Number of school kits received in the case")
  output$Intro_data_9<-renderText("Hygiene Kits---Number of hygiene kits received per individual or family")
  output$Intro_data_10<-renderText("Financial Support---Money provided")
  
  output$Intro_0<-renderText("In this project, we will primarily focus on three problems:")
  output$Intro_1<-renderText("1. Exploring the trend of different kinds of assistance over years.")
  output$Intro_2<-renderText("2. A linear regression of the specfic kind of assistance you selected on the number of people in the family.")
  output$Intro_3<-renderText("3. Performing a cluster analysis based on the two variables you selected.")
  
  output$Counting_Result <- renderPlot({
    Trend_plot_count(input$select)
  })
  
  output$Ave_Result <- renderPlot({
    Trend_plot_ave(input$select)
  })
  
  output$Reg_Result <- renderPlot({
    Reg_plot(input$select2)
  })
  
  output$Reg_Table_Result <- renderTable({
    Reg_Table(input$select2)
  })
  
  output$Reg <- renderText("Based on the sample size, here we only provide three variables for selection.")
  
  output$Cluster_Result <- renderPlot({
    Cluster_plot(input$select31,input$select32,input$num)
  })
  
  output$Cluster <- renderText("Based on the sample size, here we only provide three variables for selection. And please do not choose two identical variables for cluster analysis.")
}

shinyApp(ui=ui, server=server)
