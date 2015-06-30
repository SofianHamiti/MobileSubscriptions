require(shiny)

shinyUI(pageWithSidebar(
        #title
        titlePanel("Mobile Subscriptions in the world (United Nations)"),
        #slider panel
        sidebarPanel(
                #input bar to slect year
                sliderInput("Year", 
                            "Year to be displayed:", 
                            min=1998, 
                            max=2013, 
                            value=2013,
                            animate=TRUE),
                width = 3
        ),
        
        mainPanel(
                #ouput of selected year
                textOutput("inputyear"),
                #tabs
                tabsetPanel(
                                   tabPanel("Summary", HTML(
                                        "<h4>This application displays the World Mobile-cellular subscriptions per 100 inhabitants values</h4>
                                         <br>
                                         <b>Data Source:</b>
                                         <a href='http://data.un.org/Data.aspx?d=MDG&f=seriesRowID:756#MDG'> Millennium Development Goals Database | United Nations Statistics Division</a>
                                         <br>
                                         <br>
                                         <a2>The application uses a dataset range from year 1998 to 2013.</a2>
                                         <br>
                                         <br>
                                         <a2>You can select the Year to display or run an automatic animation.</a2>
                                         <br>
                                         <br>
                                         <b>Code:</b>
                                         <a href='https://github.com/SofianHamiti/MobileSubscriptions' target='_blank'>Published in my GitHub repository</a>
                                        ")
                                ),
                                tabPanel("Map", htmlOutput("map")), 
                                tabPanel("Dataset", htmlOutput("table"))
                )
                
        )
)
)
