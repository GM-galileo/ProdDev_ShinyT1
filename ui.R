library(shiny)
library(DT)

shinyUI(fluidPage(

    titlePanel("Tarea Shiny Plots"),
    sidebarLayout(
      sidebarPanel(
        selectInput("Col",
                    "Seleccione color:",
                    choices= c('green', 'gray','white', 'red'),
                    selected = 'red'
                    )
      ),
      mainPanel(
        plotOutput("Plot",
                   click = "e_clik",
                   dblclick = 'e_dbclik',
                   hover = 'e_hover',
                   brush = 'e_brush'),
        DT::dataTableOutput('mtcars_tbl')
      )
    )

))
