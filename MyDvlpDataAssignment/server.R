#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(curl)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  data("diamonds")
  output$distPlot <- renderPlot({
    
    #subset the data
    diamonds_sub<-subset(diamonds,cut==input$cut & color==input$color &clarity==input$clarity )
    
    #plot the diamond data with carat and price
    l<-ggplot(data=diamonds_sub,aes(x=carat,y=price))+geom_point()+geom_smooth(method="lm")+xlab("Carat")+ylab("Price")+xlim(0,6)+ylim(0,20000)
    l
  },height=700)
    
    # create a linear model
    output$predict<-renderPrint({
      diamonds_sub<-subset(diamonds,cut==input$cut & color==input$color & clarity==input$clarity)
      fit<-lm(price~carat,data=diamonds_sub)
      unname(predict(fit,data.frame(carat=input$lm)))
    })  
  
    
    observeEvent(input$predict,{distPlot<<-NULL
    output$distPlot<-renderPlot({l<-ggplot(data=diamonds,aes(x=carat,y=price))+geom_point()+geom_smooth(method="lm")+xlab("Carat")+ylab("Price")+xlim(0,6)+ylim(0,20000)
    l},height=700)
    })
    
  
    
 
  
})
