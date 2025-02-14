# user interface .. 

ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # Page 1 intro tabPanel -- 
  tabPanel(title = "About this App",
           
           "background information will go here"
           
  ), # END Page 1 intro tabPanel
  
  # Page 2 data viz tabPanel
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz --
           tabsetPanel(
             
             #trout tabPanel
             tabPanel(title = "Trout",
                      
                      #trout sidebar layout
                      sidebarLayout(
                        
                        # trout sidebar panel
                        sidebarPanel(
                          
                          # channel type pickerInput
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select Channel Types:",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionsBox = TRUE)),
                          
                          # section checkboxGroupButtons
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a Sampling Section:",
                                               choices = c("Clear Cut Forest" = "clear cut forest",
                                                           "Old Growth Forest" = "old growth forest"),
                                               selected = c("clear cut forest",
                                                            "old growth forest"),
                                               justified = TRUE,
                                               checkIcon = list(
                                                 yes = icon("check", lib = "font-awesome"),
                                                 no = icon("xmark")
                                               )
                                               )
                          
                        ), # END trout sidebar panel
                        
                        mainPanel(
                          
                          # trout scatterplot output
                          plotOutput(outputId = "trout_scatterplot_output")
                          
                        ) # END trout main panel
                        
                      ) # END Trout sidebar layout
                      
             ), # END trout tabPanel
             
             # Penguin tabPanel
             tabPanel(title = "Penguins",
                      
                      #Penguins sidebar layout
                      sidebarLayout(
                        
                        # Penguins sidebar panel
                        sidebarPanel(
                          
                          pickerInput(inputId = "penguin_island_input",
                                      label = "Select Island:",
                                      choices = unique(penguins$island),
                                      selected = c("Torgersen", "Dream", "Biscoe"),
                                      multiple = TRUE,
                                      options = pickerOptions(actionbox = TRUE)
                                      ),
                          
                          sliderInput(inputId = "bin_size",
                                      label = "Select Histogram Bin Size",
                                      min = 1,
                                      max = 100,
                                      value = 25)
                          
                          
                        ), # END Penguins sidebar panel
                        
                        mainPanel(
                          
                          plotOutput(outputId = "penguinplot")
                          
                        ) # END Penguins main panel
                        
                      ) # END Penguins sidebar layout
                      
                      
             ) # END Penguins tab panel
             
           ), # END tabsetPanel
           
           
  ) # End Page 2 data viz tabPanel
)
















