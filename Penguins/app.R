library(shiny)
library(palmerpenguins)
library(ggplot2)
library(DT)
library(bslib)


ui <- fluidPage(
  # Adding in a theme
  theme = bs_theme(
    version = 4,
    bootswatch = "cosmo",
    primary = "#FF6347",
    secondary = "#20B2AA"
  ),

  # App title
  titlePanel("Palmer Penguins Body Mass Analysis"),

  # Feature: Tabset panel with three tabs so users will be welcomed with a greeting page
  # and then be able to toggle between the visual representation of the body mass data
  #and the raw data table
  tabsetPanel(
    # Tab 1: Welcome Page
    tabPanel(
      title = "Welcome!",
      h2("Welcome to the Palmer Penguins Body Mass Analysis App :)"),
      p("This app allows you to explore the body mass distribution of penguins based on species and island using the Penguins data
         from the PalmerPenguins R  package."),
      p("Use the tabs above to navigate through the app. You can visualize histograms of body mass or explore the raw data.")
    ),

    # Tab 2: Histogram
    #Feature: I am adding in a drop down menu for species so when users are
    #looking at the histogram of body mass they can look at the distribution of
    #body mass separately for each species. Body mass will vary widely between
    #species so it is helpful to be able to look at each species separately.
    tabPanel(
      title = "Histogram of Body Mass",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "species",
            label = "Choose a Penguin Species:",
            choices = unique(penguins$species),
            selected = "Adelie"
          ),
          #Feature: I am adding check box menu here so user can choose
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
          #Feature: I am adding a slider so users can choose the bin size of their
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
    ),

    # Tab 3: Data Table
    tabPanel(
      title = "Raw Data Table",
      DTOutput(outputId = "dataTable")
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

  # Render the data table with built-in filtering
  output$dataTable <- renderDT({
    datatable(
      penguins[, c("species", "island", "body_mass_g")],
      #Feature: Letting users decide which species and islands they want to view
      #in the data table
      filter = "top",
      #Feature: Creating a drop down menu so users can choose the number of entries they
      #wish to see on the page
      options = list(
        pageLength = 10,
        lengthMenu = c(5, 10, 25, 50)
      ),
      rownames = FALSE
    )
  })
}

shinyApp(ui = ui, server = server)
