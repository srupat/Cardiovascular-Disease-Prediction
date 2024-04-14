# Load required libraries
library(shiny)

# Load the model from RDS file
model <- readRDS("model.rds")

# Define UI
ui <- fluidPage(
  titlePanel("Model Loader App"),
  
  # Input fields for the 13 parameters
  sidebarLayout(
    sidebarPanel(
      numericInput("Age",label = "Age", value = 0),
      numericInput("Systolic", "Systolic", value = 0),
      numericInput("Lymphocyte", "Lymphocyte", value = 0),
      numericInput("Monocyte", "Monocyte", value = 0),
      numericInput("Platelet.count", "Platelet.count", value = 0),
      numericInput("Red.Cell.Distribution.Width", "Red.Cell.Distribution.Width", value = 0),
      numericInput("Cholesterol", "Cholesterol", value = 0),
      numericInput("Creatinine", "Creatinine", value = 0),
      numericInput("Glucose", "Glucose", value = 0),
      numericInput("LDH", "LDH", value = 0),
      numericInput("Total.Cholesterol", "Total.Cholesterol", value = 0),
      numericInput("Glycohemoglobin", "Glycohemoglobin", value = 0),
      numericInput("CoronaryHeartDisease", "CoronaryHeartDisease", value = 10),
      actionButton("submit_button", "Submit")
    ),
    mainPanel(
      # Display the result in a textbox
      textOutput("result_text")
    )
  )
)

server <- function() {
  # Retrieve input values
  params <- c(
      input$Age, input$Systolic, input$Lymphocyte, input$Monocyte, input$Platelet.count,
    input$Red.Cell.Distribution.Width, input$Cholesterol, input$Creatinine, input$Glucose, input$LDH,
    input$Total.Cholesterol, input$Glycohemoglobin, input$CoronaryHeartDisease
  )
  
  # Pass input parameters to the model and calculate result
  result <- predict(model, as.data.frame(t(params)))
  return(result)
}


# Run the application
shinyApp(ui = ui, server = server)