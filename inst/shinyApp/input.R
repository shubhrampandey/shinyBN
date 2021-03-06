input_page <- tabItem(
  tabName = "input",
  br(),
  br(),
  
  radioButtons("inType",h4(strong("Select the type of Input:")),c("R Object in R","R Object(.Rdata)","Individual level Data(.csv)","Structure in Excel"),inline = T,width="100%"),
  conditionalPanel(
    condition = "input.inType == 'R Object in R'",
    br(),
    column(width=6,textInput("inFit","Enter your Network and Data (if need):","Stroke_bnfit",width=500)),
    column(width=12,helpText("Separated by a comma.")),
    column(width=12,helpText("To change default network, please input 'Stroke_bnfit' (For Stroke Network) or 'Asia_fit,Asia_data' (For Asia Network)."))
  ),
  conditionalPanel(
    condition = "input.inType == 'Individual level Data(.csv)'",
    br(),
    h4(strong("Structure learning:")),
    column(width=12,
           column(width=4,fileInput("inFile","Choose your Individual level Data(.csv):")),
           column(width=4,checkboxInput("inHeader","Header?",TRUE)),
           column(width=4,radioButtons("inSep","Separator:",c("Comma"=",","Tabs"="\t","Spaces"=" "),inline = T))),
    column(width=12,
           column(width=6,radioButtons("YNsplit","Training network using:",c("All sample"="no","Split sample for model validation"="yes"),inline = T)),
           conditionalPanel(
             condition = "input.YNsplit == 'yes'",
             column(width=6,radioButtons("Split_Proportion","Proportion:",c("5:5","6:4","7:3","8:2","9:1"),selected="7:3",inline=T))
           )),
    column(width=12,br()),
    column(width=12,
           column(width=4,selectInput("inLearnType","Type of Structure Algorithm:",c("Score-Based Algorithms","Constraint-Based Algorithms",
                                                                                     "Hybrid Algorithms","Bootstrap"))),
           conditionalPanel(
             condition = "input.inLearnType == 'Constraint-Based Algorithms'",
             column(width=4,selectInput("inLearn1","Structure Algorithm:",c("Grow-Shrink","Incremental Association","Fast Incremental Association",
                                                                            "Interleaved Incremental Association","Max-Min Parents and Children","Semi-Interleaved HITON-PC"))),
             column(width=4,selectInput("inTest1","Test:",c('mutual information'='mi','shrinkage estimator for the mutual information'='mi-sh',
                                                            "Pearson's X2"='x2'))),
	     column(width=4,sliderInput("inAlpha1","Alpha:",min=0.05,max=0.2,step=0.05,value=0.05))),
           conditionalPanel(
             condition = "input.inLearnType == 'Score-Based Algorithms'",
             column(width=4,selectInput("inLearn2","Structure Algorithm:",c("hill-climbing","tabu search"))),
             column(width=4,selectInput("inScore2","Scores:",c("Bayesian Information Criterion score"="bic","Akaike Information Criterion score"="aic","Multinomial log-likelihood score"="loglik",
                                                "Bayesian Dirichlet equivalent score"="bde","Bayesian Dirichlet sparse score"="bds","Modified Bayesian Dirichlet equivalent score"="mbde",
                                                "Locally averaged Bayesian Dirichlet score"="bdla","K2 score"="k2"))),
             conditionalPanel(
               condition = "input.inLearn2 == 'hill-climbing'",
               column(width=4,sliderInput("inRestart2","Num of restart:",min=0,max=10,step=1,value=0)),
               column(width=4,sliderInput("inPerturb2","Num of perturb:",min=0,max=10,step=1,value=1))
             ),
             conditionalPanel(
               condition = "input.inLearn2 == 'tabu search'",
               column(width=4,sliderInput("intabu2","Num of tabu:",min=10,max=100,step=10,value=10))
             )),
           conditionalPanel(
             condition = "input.inLearnType == 'Hybrid Algorithms'",
             column(width=4,selectInput("inLearn3","Structure Algorithm:",c("Max-Min Hill Climbing","2-phase Restricted Maximization"))),
             column(width=12,
             column(width=4,selectInput("inLearn31","Constraint Algorithm:",c("Grow-Shrink"="gs","Incremental Association"="iamb","Fast Incremental Association"="fast.iamb",
                                                                              "Interleaved Incremental Association"="inter.iamb","Max-Min Parents and Children"="mmpc","Semi-Interleaved HITON-PC"="si.hiton.pc"))),
             column(width=4,selectInput("inTest31","Test:",c('mutual information'='mi','shrinkage estimator for the mutual information'='mi-sh',
                                                            "Pearson's X2"='x2'))),
             column(width=4,sliderInput("inAlpha31","Alpha:",min=0.05,max=0.2,step=0.05,value=0.05))),
             column(width=12,column(width=4,selectInput("inLearn32","Score Algorithm:",c("hill-climbing"="hc","tabu search"="tabu"))),
             conditionalPanel(
               condition = "input.inLearn32 == 'hc'",
               column(width=4,sliderInput("inRestart32","Num of restart:",min=0,max=10,step=1,value=0)),
               column(width=4,sliderInput("inPerturb32","Num of perturb:",min=0,max=10,step=1,value=1))
             ),
             conditionalPanel(
               condition = "input.inLearn32 == 'tabu'",
               column(width=4,sliderInput("intabu32","Num of tabu:",min=10,max=100,step=10,value=10))
             ))),
           conditionalPanel(
             condition = "input.inLearnType == 'Bootstrap'",
             column(width=4,selectInput("inLearn4","Structure Algorithm:",list(`Score-Based Algorithms`=c("hill-climbing"="hc","tabu search"='tabu'),
                                                                               `Constraint-Based Algorithms`=c("Grow-Shrink"='gs',"Incremental Association"='iamb',"Fast Incremental Association"='fast.iamb',"Interleaved Incremental Association"='inter.iamb'
                                                                                                               ,"Max-Min Parents and Children"='mmpc',"Semi-Interleaved HITON-PC"='si.hiton.pc')))),
             conditionalPanel(
               condition = "input.inLearn4 !='hc' && input.inLearn4 !='tabu'",
               column(width=4,selectInput("inTest41","Test:",c('mutual information'='mi','shrinkage estimator for the mutual information'='mi-sh',
                                                              "Pearson's X2"='x2'))),
               column(width=4,sliderInput("inAlpha41","Alpha:",min=0.05,max=0.2,step=0.05,value=0.05))
             ),
             conditionalPanel(
               condition = "input.inLearn4 =='hc' || input.inLearn4 =='tabu'",
               column(width=4,selectInput("inScore4","Score:",c("Bayesian Information Criterion score"="bic","Akaike Information Criterion score"="aic","Multinomial log-likelihood score"="loglik",
                                                 "Bayesian Dirichlet equivalent score"="bde","Bayesian Dirichlet sparse score"="bds","Modified Bayesian Dirichlet equivalent score"="mbde",
                                                 "Locally averaged Bayesian Dirichlet score"="bdla","K2 score"="k2")))),
             conditionalPanel(
               condition = "input.inLearn4 == 'hc'",
               column(width=4,sliderInput("inRestart42","Num of restart:",min=0,max=10,step=1,value=0)),
               column(width=4,sliderInput("inPerturb42","Num of perturb:",min=0,max=10,step=1,value=1))
             ),
             conditionalPanel(
               condition = "input.inLearn4 == 'tabu'",
               column(width=4,sliderInput("intabu42","Num of tabu:",min=10,max=100,step=10,value=10))
             ),
             column(width=12,
                    column(width=4,radioButtons("N_Boot","Num of Boot:",c(10,500,1000,2000),inline=T)),
                    column(width=5,sliderInput("Strength_Boot","Strength threshold:",0.5,1,0.85,step=0.05)))
           )),
    
    column(width=12,
           column(width=2,checkboxInput("prior_TF", "Prior?", F)),
           column(width=2,checkboxInput("prior_hide", "Hide?", F))),
    conditionalPanel(
      condition = "input.prior_TF",
      column(width=12,radioButtons("Prior_Type","Input type:",c("Single","Batch"),inline = T)),
      conditionalPanel(
        condition="input.Prior_Type == 'Single'",
        column(width=12,
               column(width=6,uiOutput("from")),
               column(width=6,uiOutput("to"))),
        column(width=12,radioButtons("BorW",NULL,c("blacklist","whitelist"),inline = T)),
        column(width=3,actionButton("AddButtonP", "Add!",icon=icon("plus"),lib="glyphicon")),
        column(width=3,actionButton("delButtonP", "Delete!",icon=icon("trash"),lib="glyphicon")),
        column(width=3,actionButton("ClearButtonP", "Clear!",icon=icon("refresh"),lib="glyphicon")),
        column(width=3,actionButton("GoButtonP", "Go!",icon=icon("play"),lib="glyphicon"))
      ),
      conditionalPanel(
        condition="input.Prior_Type == 'Batch'",
        column(width=12,
               column(width=4,fileInput("Pri_Batch","Upload prior(.csv)")),
               column(width=4,checkboxInput("PriHeader","Header?",TRUE)),
               column(width=4,radioButtons("PriSep","Separator:",c("Comma"=",","Tabs"="\t","Spaces"=" "),inline = T)),
               column(width=12,helpText("Please input a csv file with 3 column: From, To, Type!")))
      )
    ),
    conditionalPanel(
      condition = "input.inType == 'Individual level Data(.csv)' & input.prior_TF &  ! input.prior_hide",
      column(width=12,dataTableOutput("Pri_table"))
    ),
    br(),
    h4(strong("Parameter learning:")),
    column(width=12,
           column(width=12,selectInput("inMethod","Parameter Algorithm:",c("Maximum Likelihood parameter estimation"="mle",
                                                    "Bayesian parameter estimation"="bayes"))))
  ),
  conditionalPanel(
    condition = "input.inType == 'R Object(.Rdata)'",
    br(),
    column(width=12,fileInput("inObject","Choose your R Object(.Rdata) and Data(if needed):"))
  ),
  conditionalPanel(
    condition = "input.inType == 'Structure in Excel'",
    br(),
    column(width=12,fileInput("inContinue","Choose your Structure File(.xlsx):"))
  ),
  column(width=12,
         br(),
         actionButton("ClearLog","Clear log!",icon=icon("trash"),lib="glyphicon"),
         verbatimTextOutput("input_ERROR"))
)