## ---- results='hide', message=FALSE, warning=FALSE-----------------------
library(modeval)
library(mlbench)
data(PimaIndiansDiabetes)
index <- sample(seq_len(nrow(PimaIndiansDiabetes)), 500)
trainingSet <- PimaIndiansDiabetes[index, ]
testSet <- PimaIndiansDiabetes[-index, ]
x <- trainingSet[, -9]
y <- trainingSet[, 9]
x_test <- testSet[, -9]
y_test <- testSet[, 9]

## ---- fig.width=6.5, fig.height=5----------------------------------------
suggest_transformation(x)

## ---- results='hide', message=FALSE, warning=FALSE-----------------------
sSummary <- list() # empty list where we store model fit results
models = c("glm", "qrnn", "lda", "rpartScore") # create a character vector with function names
sSummary <- add_model(sSummary, x, y, models)

## ------------------------------------------------------------------------
## 
##  Model:  rpartScore 
##  >> Accuracy and Kappa metrics are available. 
##  >> Best model is selected based on accuracy. 
## 
##  
##  Model:  glm, lda 
##  >> ROC, Sens, Spec, Accuracy and Kappa metrics are available. 
##  >> Best model is selected based on AUC. 
## 
##  
##  Model:  qrnn 
##  >> Model(s) not support classification problem.
## 

## ------------------------------------------------------------------------
names(sSummary)

## ---- results='hide', message=FALSE, warning=FALSE-----------------------
sSummary <- add_model(sSummary, x, y, c("knn", "nnet", "qda"), modelTag = "Nonlinear", tf="tf2")
sSummary <- add_model(sSummary, x, y, c("rf", "rpart", "treebag"), modelTag = "TreeBased", sampling = "down")
sSummary <- add_model(sSummary, x, y, c("svmLinear", "svmRadial", "svmPoly"), modelTag = "svmFamily")

## ------------------------------------------------------------------------
names(sSummary)

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_auc(sSummary)
suggest_auc(sSummary, time = TRUE)

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_auc(sSummary, time = TRUE, "TreeBased")

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_auc(sSummary, time = TRUE, "glm|Tree")

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_accuracy(sSummary, "glm|Tree")

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_category(sSummary, "nnet|knn|rf")

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_variable(sSummary)
suggest_variable(sSummary, "TreeBased")

## ------------------------------------------------------------------------
sSummary <- add_prob(sSummary, x_test, y_test, "pos")

## ---- fig.width=6.5, fig.height=4----------------------------------------
suggest_probPop(sSummary, "pos")
suggest_probPop(sSummary, "pos", modelTag = "Tree")

suggest_probCut(sSummary, "pos")
suggest_probCut(sSummary, "pos", modelTag = "Tree")


## ---- message=FALSE, warning=FALSE, fig.width=6.5, fig.height=4----------
suggest_gain(sSummary, "pos", modelTag = "Tree")
suggest_gain(sSummary, "pos", type = "Gain")
suggest_gain(sSummary, "pos", type = "Lift")
suggest_gain(sSummary, "pos", type = "PctAcc")
suggest_gain(sSummary, "pos", type = "Pct")
suggest_gain(sSummary, "pos", type = "Gain", modelTag = "Tree")


## ---- message=FALSE, warning=FALSE, fig.width=6.5, fig.height=4----------
suggest_gain(sSummary, "pos", type = "Gain") + xlim(0, 0.5)


