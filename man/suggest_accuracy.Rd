% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/code.R
\name{suggest_accuracy}
\alias{suggest_accuracy}
\title{Compare performance based on accuracy metrics.}
\usage{
suggest_accuracy(addTo, modelTag = NULL, time = FALSE)
}
\arguments{
\item{addTo}{Summary list that contains model fits to compare.}

\item{modelTag}{Select model fits that contains modelTag in their name.}

\item{time}{If TRUE, calculates average time to train model for a single
tuning.}
}
\description{
\code{suggest_accuracy} Compare performance for all model fits in the
Summary list based on Accuracy and Kappa metrics, together with training
time for a single tuning of each model fit.
}
\examples{
\dontrun{
library(mlbench)
data(PimaIndiansDiabetes)
index <- sample(seq_len(nrow(PimaIndiansDiabetes)), 500)
trainingSet <- PimaIndiansDiabetes[index, ]
testSet <- PimaIndiansDiabetes[-index, ]
x <- trainingSet[, -9]
y <- trainingSet[, 9]
x_test <- testSet[, -9]
y_test <- testSet[, 9]
sSummary <- list()
sSummary <- add_model(sSummary, x, y)
sSummary <- add_model(sSummary, x, y, model = c("C5.0Cost", "glmnet"), modelTag = "others")
 
suggest_accuracy(sSummary)
suggest_accuracy(sSummary, time = TRUE)
suggest_accuracy(sSummary, time = TRUE, modelTag = "glm|svm")

# vignette("modeval") #check a vignette for further details
}
}
