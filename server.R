library(shiny)
library(ggplot2)

score <-c(0:9)
rate  <-c(0.2, 0.6, 2.2, 3.2, 4.8, 7.2, 9.7, 11.2, 10.8, 12.2)
labels <-c("0.2%","0.6%","2.2%","3.2%","4.8%","7.2%","9.7%","11.2%","10.8%","12.2%")


function(input, output) {
  currentScore <-reactive({  ifelse(input$sex=="Female",1,0) +
                             ifelse(input$age=="65-74",1,0) +
                             ifelse(input$age==">74",2,0) +
                             ifelse(input$chf==TRUE,1,0) +
                             ifelse(input$hypertension==TRUE,1,0)+
                             ifelse(input$diabetes==TRUE,1,0) +
                             ifelse(input$stroke==TRUE,2,0) +
                             ifelse(input$vascular==TRUE,1,0)
                           })
  output$inputScore <- renderPrint({currentScore() })    
  output$inputRisk <-  renderPrint({rate[currentScore()+1] })

  
  output$plot <- renderPlot({
    if (currentScore()==0) {result <- c(1,rep(0,9))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==1) {result <- c(0,1,rep(0,8))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==2) {result <- c(0,0,1,rep(0,7))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==3) {result <- c(rep(0,3),1,rep(0,6))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==4) {result <- c(rep(0,4),1,rep(0,5))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==5) {result <- c(rep(0,5),1,rep(0,4))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==6) {result <- c(rep(0,6),1,rep(0,3))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==7) {result <- c(rep(0,7),1,rep(0,2))
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==8) {result <- c(rep(0,8),1,0)
                            df <- data.frame(score,rate,labels,result)}
    if (currentScore()==9) {result <- c(rep(0,9),1)
                            df <- data.frame(score,rate,labels,result)}
    
    p <- ggplot(df,aes(x=factor(score),y=rate)) + geom_bar(aes(fill=result),stat="identity") +
      guides(fill=FALSE) + xlab("Patient CHA2DS2-VASc Score") +
      ylab("Annual Stroke Rate (% of patients)") +
      ggtitle("Annual Stroke Risk") + coord_fixed(ratio = 1/2) +
      annotate("text", x = c(1:10), y =c(1,1.5,3,4,6,8,10.5,12,11.5,13) , label = labels)
    
    print(p)
    
                              }, height=700)                                     
    
}