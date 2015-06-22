library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  
  titlePanel("CHA2DS2-VASc Calculator for Atrial Fibrillation Stroke Risk"),
  tags$p("Calculates stroke risk for patients with atrial fibrillation, possibly better than the CHADS2 score."),
           
  
  sidebarPanel(
    h3('Criteria'),
    radioButtons('age','Age in years',c("<65","65-74",">74")),
    radioButtons('sex','Patient is:',c("Male","Female")),
    checkboxInput('chf', 'Has a history of congestive heart failure', FALSE),
    checkboxInput('hypertension', 'Has a history of hypertension (resting BP > 140/90 mmHg on at least 2 occasions or current antihypertensive pharmacologic treatment)',FALSE),
    checkboxInput('diabetes', 'Has been diagnosed with diabetes mellitus (fasting glucose > 125 mg/dL or treatment with oral hypoglycemic agent and/or insulin)',FALSE),
    checkboxInput('stroke', 'Has a history of stroke, TIA, or TE (includes any history of cerebral ischemia)',FALSE),
    checkboxInput('vascular', 'Has been diagnosed with vascular disease (Prior MI, peripheral arterial disease, or aortic plaque)',FALSE)  
  ),
  
  mainPanel(
    h3('Results'),
    h4('Your total score is:'),
    verbatimTextOutput('inputScore'),
    h5('Your yearly stroke risk (in %) is:'),
    verbatimTextOutput('inputRisk'),
    plotOutput('plot')
  )
))