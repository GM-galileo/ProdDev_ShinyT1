library(shiny)
library(ggplot2)
library(DT)

shinyServer(function(input, output, session) {
  
  output$mtcars_tbl = DT::renderDataTable({
    mtcars
  })

  selected <- reactiveVal(rep(FALSE, nrow(mtcars)))
  
  output$Plot <- renderPlot({
    
    mtcars$sel <- selected()
    ggplot(mtcars, aes(wt, mpg)) + 
      geom_point(aes(colour = sel)) +
      scale_colour_discrete(limits = c("TRUE", "FALSE"))
  }, res = 96)

  
  observeEvent(input$e_clik, {
    
    output$Plot <- renderPlot({
      
      mtcars$sel <- selected()
      ggplot(mtcars, aes(wt, mpg)) + 
        geom_point(aes(colour = sel), color='green') +
        scale_colour_discrete(limits = c("TRUE", "FALSE"))
    }, res = 96)
    
    rbind(c(input$dclk$x, input$dclk$y, updateSliderInput(session,'Col',value = 'green')))
    
  })
  
  observeEvent(input$e_dbclik, {
  
    output$Plot <- renderPlot({
      
      mtcars$sel <- selected()
      ggplot(mtcars, aes(wt, mpg)) + 
        geom_point(aes(colour = sel), color='white') +
        scale_colour_discrete(limits = c("TRUE", "FALSE"))
    }, res = 96)
    
    rbind(c(input$dclk$x, input$dclk$y, updateSliderInput(session,'Col',value = 'white')))
    
  })
  
  
  observeEvent(input$e_hover, {
    
    output$Plot <- renderPlot({
      
      mtcars$sel <- selected()
      ggplot(mtcars, aes(wt, mpg)) + 
        geom_point(aes(colour = sel), color='gray') +
        scale_colour_discrete(limits = c("TRUE", "FALSE"))
    }, res = 96)
    
    rbind(c(input$dclk$x, input$dclk$y, updateSliderInput(session,'Col',value = 'gray')))
  })
  
 
  
  observeEvent(input$e_brush, {

    brushed <- brushedPoints(mtcars, input$e_brush, allRows = TRUE)$selected_
    
    output$Plot <- renderPlot({
      
      mtcars$sel <- brushed
      ggplot(mtcars, aes(wt, mpg)) + 
        geom_point(aes(colour = sel)) +
        scale_colour_discrete(limits = c("TRUE", "FALSE"))
      }, res = 96)
    
      rbind(c(input$dclk$x, input$dclk$y, updateSliderInput(session,'Col',value = 'green')))
      

  })




})
