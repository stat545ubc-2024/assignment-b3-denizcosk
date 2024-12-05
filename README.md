[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/_WsouPuM)

This is the code to the shiny app **"Palmer Penguins Body Mass Analysis"**. You can find the the app [here](https://dezc.shinyapps.io/penguins/).

This is a improvement on the **"Palmer Penguins Body Mass Range"** app which can be found [here](https://dezc.shinyapps.io/test/).

This app explores the dataset _Penguins_ from the R package _palmerpenguins_. These data were collected by Dr. Kristen Gorman and the Palmer Station in Antarctica (which is a member of the Long Term Ecological Research Network). They also made these data publically avalible.

Using this app, users will be able to do some initial analysis of body mass data in the penguins dataset and then view/download the raw data based on their needs.

There are 3 tabs in this app: "Welcome!", "Histogram", and "Data Table". When you first go to the app you will be sent to the welcome tab that includes a basic overview of what the app is and its functionality.

Using the Histogram tab, users can easily visualize the range and frequencies of the recorded body masses of the different species using an interactive histogram. Users can look at any of the 3 species. They are also able to look at all 3 islands that are included in the dataset or a subset of these islands. Users are also able to control the size of bins on the histogram to more easily view borad and specific trends in body mass. This will help users to know which subset of the data they would like to download.

Using the Data Table tab, users can view the raw data used to generate the histogram. Users are able to select between filters for each column and can select how many entries they would like to see on each page. At the bottom of this page, there is a blue download button that allows users to download the filtered data for further analysis. 


In this repo you will find the code (in the file named app.R) for the shiny app located in the _Penguins_ folder along with the .DS_store and rconnect files. 
