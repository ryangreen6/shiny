library(shiny)
library(tidyverse)
library(palmerpenguins)

ui <- fluidPage(
  
  # app title
  tags$h1("Penguins are Cool"),
  
  # app subtitle
  tags$h4(tags$strong("Exploring Antarctic Penguin Data")),
  
  # slider widget
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700,
              max = 6300,
              value = c(3000, 4000)),
  
  # body mass plot output
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # year input
  checkboxGroupInput(inputId = "year_input",
                     label = "Select Years:",
                     choices = unique(penguins$year),
                     selected = c(2007, 2008),
                     inline = TRUE),
  
  # create DT output
  DT::dataTableOutput(outputId = "penguin_DT_output")
  
)

server <- function(input, output, session) {
  
  # filter body masses for plot, making it reactive to user input on the slider
  body_mass_df <- reactive({
    
    penguins %>%
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2])) %>%
      filter(year %in% input$year_input)
    
  })
  
  # render penguin scatterplot
  output$body_mass_scatterplot_output <- renderPlot({
    
    # code to generate plot
    ggplot(na.omit(body_mass_df()), 
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
           color = "Penguin species", shape = "Penguin species") +
      guides(color = guide_legend(position = "inside"),
             size = guide_legend(position = "inside")) +
      theme_minimal() +
      theme(legend.position.inside = c(0.85, 0.2), 
            legend.background = element_rect(color = "white"))
  })
    
  # creating reactive DF 
  # year_filter <- reactive({
  #   penguins %>%
  #     filter(year %in% input$year_input)
  # })
  
  
  # add new server instructions
  output$penguin_DT_output <- DT::renderDataTable({
    DT::datatable(body_mass_df())
  })
  
  
  
  
}

shinyApp(ui, server)









