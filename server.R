require(googleVis)
require(shiny)

## read and Prepare data to be displayed
data <- read.table("mobile.txt", header=TRUE, sep=";")
data <- data[,c("Country.or.Area","Year", "Value")]
data$Country.or.Area <- as.character(data$Country.or.Area)
data$Year <- as.numeric(data$Year)
data$Value[is.na(data$Value)] <- 0
data$Value <- round(data$Value, digits = 2)
data <- subset(data, data$Year >= 1998)

#Server function
shinyServer(function(input, output) {
        #reactive input
        inputYear <- reactive({input$Year})
        
        #Text update reactively with input
        output$inputyear <- renderText({paste("Mobile subscriptions (per 100 inhabitants) in", inputYear())})
        
        #Map
        output$map <- renderGvis({
                #subset with input Year  
                inputData <- subset(data, (Year > (inputYear()-1)) & (Year < (inputYear()+1)))
                #geo chart 
                gvisGeoChart(inputData,
                             locationvar="Country.or.Area", 
                             colorvar="Value",
                             options=list(width="100%", 
                                          height="100%", 
                                          backgroundColor= '#81d4fa',
                                          datalessRegionColor= '#D8D8D8',
                                          defaultColor= '#f5f5f5',
                                          colorAxis="{values:[0, 50, 50, 100, 100, 304.08],
                                                        colors:[\'#800000', 
                                                                \'#FF0000', 
                                                                \'#FFC200', 
                                                                \'#FFA500',
                                                                \'#FFFF00',
                                                                \'#00FF00']}",
                                          legend="{textStyle: {color: 'black', 
                                                        fontSize: 10},
                                                        numberFormat:'#'}"

                             ))
        })
        #data table 
        output$table <- renderGvis({
                #subset with input Year  
                inputData <- subset(data, (Year > (inputYear()-1)) & (Year < (inputYear()+1)))
                #table
                gvisTable(inputData, 
                          options=list(width="100%", 
                                       height="100%",
                                       page='enable',
                                       pageSize=20,
                                       showRowNumber='True'))

        })

})
