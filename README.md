## Spam Email Filter

# Introduction

The goal of this project is to classify spam from ham (good emails) based on the frequencies of words in the email. The project has a given dataset of word frequency of 6000+ emails for me to construct and test model. The statistical learning algorithms I implemented in this project are:

1. **Logistic Regression (GLM)**: This algorithm is the log-based version of Linear Regression. In linear regression model, we assign weights to each of the predictors to find the best fitting line (regression line) which minimize the error (absolute distance from data to regression line). Logistic Regression model does the same thing but it adds upper bound 1 and lower bound 0 to the regression line. Therefore we can use this model to predict probablity.

![image](https://cloud.githubusercontent.com/assets/16885033/18940765/46f04370-85d9-11e6-85b7-f3fe5ee72284.png)

2. **Linear Discriminant Analysis (LDA)**: This algorithm is based on Bayes Theorem. Bayes theorem says that the probability of the variable Y equals k given the variable X equals x can be write as probability that X is x given Y equals k, multiplied by the marginal probability or prior probability that Y is k, and then divided by the marginal probability that X equals x. 

![image](https://cloud.githubusercontent.com/assets/16885033/18940782/4b322430-85d9-11e6-9867-c694cfae678d.png)

