\name{PLSreg}
\alias{PLSreg}
\title{
Fitting Partial Least Squares Predictive Models over Different Tuning Parameters.
}
\description{
PLSreg fits partial least squares regression models based on mvr function by pls package, and returns a resampling based performance measure using the train function by caret package. 
}
\usage{
PLSreg(my.datf.train,my.datf.test,sCV,iSplit=1,fDet=F,outFile="")}
\arguments{
 \item{my.datf.train}{the training data set; an object where samples are in rows and features are in columns. The first column should be a numeric or factor vector containing the outcome for each sample.}
 \item{my.datf.test}{the test data set.}
 \item{sCV}{A string or a charcater vector specifying which resampling method to use. See details below.}
 \item{iSplit}{a number indicating from which splitting of the data, the above train and test sets are derived. The default value is 1.}
 \item{fDet}{A logical value for saving model' statistics; the defualt value is FALSE. See below for details.}
 \item{outFile}{A string specifying the output file (could include path) for details (fDet=TRUE).}
}
\details{
RMSE is the summary metric used to select the optimal model.

The tuning parameter examined is the model's number of components, which is set to a sequence of integers from 1 to one fifth of the number of features in the training data set. (If the later is smaller than 1, tuning parameter is set to 1.)

To control the computational nuances of the train function, trainControl is used; number of folds or resampling iterations is set to 10, and the number of completed set of folds is set to 10 (for repeated k-fold cross-validation).
    
sCV can take the following values: boot, boot632, cv, repeatedcv, LOOCV, LGOCV (for repeated training/test splits), none (only fits one model to the entire training set), oob (only for random forest, bagged trees, bagged earth, bagged flexible discriminant analysis, or conditional tree forest models), "adaptive_cv", "adaptive_boot" or "adaptive_LGOCV".

If fDet=TRUE, the following output is produced: a CSV file with detailed statistics about the regression model (Regression method, splitting number, cross-validation type, Training set summary, Test set summary, Fitting summary, List of predictors, Training predictors, Test predictors, resampling statistics, features'importance, residuals of the fitted model, assessment of applicability domain (leverage analysis, Cook's distances, points influence)), 5-12 plots for fitting statistics as a PDF file for each splitting and cross-validation method (Training Yobs-Ypred, Test Yobs-Ypred, Feature Importance, Fitted vs. Residuals for Fitted Model, Leverage for Fitted Model, Cook's Distance for Fitted Model, 6 standard fitting plots using plot function with cutoff.Cook). 

}
\value{
 A list is returned containing:
\item{stat.values}{model's statistics}
\item{model}{the full pls model, i.e. a list of class train}
}
\examples{
\dontrun{
fDet <- FALSE   
iSeed <- i                 

# the fraction of training set from the entire dataset;
trainFrac <- 0.75

# dataset folder for input and output files
PathDataSet <- 'DataResults' 

# upload data set
ds <- read.csv(ds.Housing,header=T)

# split the data into training and test sets
dsList  <- DsSplit(ds,trainFrac,fDet,PathDataSet,iSeed) 
ds.train<- dsList$train
ds.test <- dsList$test

# types of cross-validation methods
CVtypes <- c('repeatedcv','LOOCV')

outPLS<- 'PLSoutput.csv'

PLS.fit <- PLSreg(ds.train,ds.test,CVtypes[1],iSplit=1,fDet=F,outFile=outPLS)
}
}
\author{
Georgia Tsiliki, Cristian R. Munteanu
}
