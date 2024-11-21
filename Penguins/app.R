
library(shiny)
library(palmerpenguins)
library(ggplot2)

ui <- fluidPage(

    #App title
    titlePanel("Palmer Penguins body mass range data"),

    # Sidebars
    #Feature 1: I am adding in a drop down menu for species so when users are
    #looking at the histogram of body mass they can look at the distribution of
    #body mass separately for each species. Body mass will vary widely between
    #species so it is helpful to be able to look at each species separately.
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "species",
          label = "Choose a Penguin Species:",
          choices = unique(penguins$species),
          selected = "Adelie"
        ),
    #Feature 2: I am adding check box menu here so user can choose
    #between islands or look at all or a group of islands together.
    #This is useful because the user might be interested in overall body mass
    #of all islands or only body mass in a particular island.
    #This feature gives them this option.
    checkboxGroupInput(
      inputId = "island",
      label = "Choose Island(s):",
      choices = as.character(unique(penguins$island)),
      selected = as.character(unique(penguins$island))
    ),
    #Feature 3: I am adding a slider so users can choose the bin size of their
    #histogram. This is useful because users might be interested in broad trends
    #of body mass or they may be interested in more exact (smaller) bins.
        sliderInput(
          inputId = "bins",
          label = "Number of Bins:",
          min = 1,
          max = 50,
          value = 25
        )
      ),

      mainPanel(
        plotOutput(outputId = "bodyMassPlot")
      )
    )
)


server <- function(input, output) {
  #this filters the data so that only the species selected with the drop down
  #menu and the islands selected in the check boxes are included in the
  #rendered plot.
  output$bodyMassPlot <- renderPlot({
    filtered_data <- penguins[penguins$species == input$species, ]
    if (!is.null(input$island) && length(input$island) > 0) {
      filtered_data <- filtered_data[filtered_data$island %in% input$island, ]
    }
    #Plot
    ggplot(filtered_data, aes(x = body_mass_g)) +
      geom_histogram(
        bins = input$bins,
        fill = "orange",
        color = "orangered",
        na.rm = TRUE
      ) +
      labs(
        title = paste(
          "Body Mass Range of",
          input$species,
          "Penguins"
        ),
        x = "Body Mass (g)",
        y = "Frequency"
      ) +
      theme_linedraw()
  })
}


shinyApp(ui = ui, server = server)

