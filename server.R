Random_Lab <- read.table('C:/Users/HARDPC/Desktop/Laczenie/Random_LabValuesInfo_2020.tsv',sep = '\t',header = TRUE)
Random_Patient <- read.table('C:/Users/HARDPC/Desktop/Laczenie/Random_PatientLevelInfo_2020.tsv',sep = '\t',header = TRUE)
DF <- merge(Random_Lab,Random_Patient)
head(DF)

library(shiny)
library(ggplot2)
function(input, output) {
  
  output$table <- DT::renderDataTable(DT::datatable({
    data1 <- DF
    if (input$SEX != "All") {
      data1 <- DF[DF$SEX == input$SEX,]
    }
    if (input$AGE != "All") {
      data1 <- DF[DF$AGE == DF$AGE,]
    }
    if (input$RACE != "All") {
      data1 <- DF[DF$RACE == DF$RACE,]
    }
    if (input$BMRKR2 != 'All'){
      data1 <- DF[DF$BMRKR2 == input$BMRKR2,]
    }
    if (input$LBTESTCD != 'All'){
      data1 <- DF[DF$LBTESTCD == input$LBTESTCD,]
    }
    if (input$LBCAT != "All"){
      data1 <- DF[DF$LBCAT == input$LBCAT,]
    }
    if (input$ACTARM != "All"){
      data1 <- DF[DF$ACTARM == input$ACTARM,]
    }
    data1
  }))
  
  output$trend = renderPlot({
    plots <- DF[DF$LBTESTCD,]
    
    ggplot(plots, aes(DF$USUBJID, DF$AVAL, color = DF$SEX))+
      geom_point()
  })
  
  output$plot2 = renderPlot({
    plots2 <- DF[DF$ACTARM,]
    
    ggplot(plots2, aes(DF$AVAL, DF$ACTARMCD, color = DF$SEX)) + 
      geom_boxplot()
      
})

}

