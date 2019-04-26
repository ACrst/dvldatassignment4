#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

data(diamonds)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diamonds and features"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("This Shiny app shows the variation of price with other features and variables in the diamond dataset. Select the options from the features Cut,Color and Clarity to see how the predicted price varies with the carat feature in the diamond dataset."),
      h4("Choose a diamond feature"),
      selectInput("cut","Cut",(sort(unique(diamonds$cut),decreasing = TRUE))),
      selectInput("color","Color",(sort(unique(diamonds$color)))),
      selectInput("clarity","Clarity",(sort(unique(diamonds$clarity),decreasing = TRUE))),
      sliderInput("lm","Carat",min=min(diamonds$carat),max=max(diamonds$carat),value=max(diamonds$carat)/2,step=0.1),
      h4("Predicted Price"),verbatimTextOutput("predict"),width=4
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel("Price-Carat Relationship",
       plotOutput("distPlot")
    )
  )
))
