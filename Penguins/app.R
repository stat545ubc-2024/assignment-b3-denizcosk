
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
    #Feature 2: I am adding another drop down menu here so user can toggle
    #between islands or look at all islands together. This is useful because
    #the user might be interested in overall body mass or only body mass in a
    #particular island. This feature gives them this option.
        selectInput(
          inputId = "island",
          label = "Choose an Island:",
          choices = c("All", as.character(unique(penguins$island))),
          selected = "All"
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
  output$bodyMassPlot <- renderPlot({
    # Filter data based on selected species and island
    filtered_data <- penguins[penguins$species == input$species, ]
    if (input$island != "All") {
      filtered_data <- filtered_data[filtered_data$island == input$island, ]
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
          "Body Mass Histogram for",
          input$species,
          "Penguins",
          ifelse(input$island == "All", "", paste("on", input$island))
        ),
        x = "Body Mass (g)",
        y = "Frequency"
      ) +
      theme_minimal()
  })
}


shinyApp(ui = ui, server = server)

