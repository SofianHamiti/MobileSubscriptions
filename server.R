require(googleVis)
require(shiny)

## Prepare data to be displayed
data <- read.table("mobile.txt", header=TRUE, sep=";")
data <- data[,c("Country.or.Area","Year", "Value")]
data$Country.or.Area <- as.character(data$Country.or.Area)
data$Year <- as.numeric(data$Year)
data$Value[is.na(data$Value)] <- 0
data$Value <- round(data$Value, digits = 2)
data <- subset(data, data$Year >= 1998)

shinyServer(function(input, output) {
        inputYear <- reactive({input$Year})
        
        output$inputyear <- renderText({paste("Mobile subscriptions (per 100 inhabitants) in", inputYear())})
        
        #Map
        output$map <- renderGvis({
                #subset with Input Year  
                inputData <- subset(data, (Year > (inputYear()-1)) & (Year < (inputYear()+1)))
                  
                gvisGeoChart(inputData,
                             locationvar="Country.or.Area", 
                             colorvar="Value",
                             options=list(width="100%", 
                                          height="100%", 
                                          backgroundColor= '#81d4fa',
                                          datalessRegionColor= '#D8D8D8',
                                          defaultColor= '#f5f5f5',
                                          colorAxis="{values:[0,100,100,304.08],
                                                        colors:[\'#E3170D', 
                                                                \'#FFA824', 
                                                                \'#00EE76', 
                                                                \'#008000']}",
                                          legend="{textStyle: {color: 'black', 
                                                        fontSize: 10},
                                                        numberFormat:'#'}"

                             ))
        })
        #Table 
        output$table <- renderGvis({
                #subset with Input Year  
                inputData <- subset(data, (Year > (inputYear()-1)) & (Year < (inputYear()+1)))

                gvisTable(inputData, 
                          options=list(width="100%", 
                                       height="100%",
                                       page='enable',
                                       pageSize=25,
                                       showRowNumber='True'))

        })

})
