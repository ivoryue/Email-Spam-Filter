## Spam Email Filter

# Introduction

The goal of this project is to classify spam from ham (good emails) based on the frequencies of words in the email. The project has a given dataset of word frequency of 6000+ emails, and the emails have already been classified for me to construct and test model. 

# Statistical Algorithms (Models)

The statistical learning algorithms I implemented in this project are:

i. **Logistic Regression (GLM)**: This algorithm is the log-based version of Linear Regression. In linear regression model, we assign weights to each of the predictors to find the best fitting line (regression line) which minimize the error (absolute distance from data to regression line). Logistic Regression model does the same thing but it adds upper bound 1 and lower bound 0 to the regression line. Therefore we can use this model to predict probablity. Limit: cannot be applied to seperate data.

![image](https://cloud.githubusercontent.com/assets/16885033/18940765/46f04370-85d9-11e6-85b7-f3fe5ee72284.png)

ii. **Linear Discriminant Analysis (LDA)**: This algorithm is based on Bayes Theorem. Bayes theorem says that the probability of the variable Y equals k given the variable X equals x can be write as probability that X is x given Y equals k, multiplied by the marginal probability or prior probability that Y is k, and then divided by the marginal probability that X equals x. 

![image](https://cloud.githubusercontent.com/assets/16885033/18940782/4b322430-85d9-11e6-9867-c694cfae678d.png)

Generally, discriminant analysis method uses Bayes theorem to separate the points into 2 groups, and minimize the number of points which classified wrong. Linear Discriminant Analysis seperate the points with strainght lines. Limit: cannot be applied to clustered data.

![image](https://cloud.githubusercontent.com/assets/16885033/18940783/4d8df358-85d9-11e6-8f08-67af65b14347.png)

# Testing Methods

i. **K-fold Cross Validation**. The purpose of testing data using this method is to avoid extreme cases. First, I randomly divided the data into 10 equal-sized parts, marked as 1 to 10. Leave out part 1 as testing data set, fit the model to the other 9 parts combined as the training data set, and then obtain predictions for the testing data set. Do this process 10 times by switching around testing data set from part 1 to part 10 and treat the rest of the data sets as training data sets. Every time we record the error rate, and after we finished 10 times cross validation, we calculate the mean error rate.

![image](https://cloud.githubusercontent.com/assets/16885033/18940784/511e3dd4-85d9-11e6-818b-bebab601dcc3.png)

ii. **Bootstrap**: Do k-fold Cross Validation test 100 times, and then throw out the 2 smallest error rates and 2 largest error rates to get 96% confidence interval.

# Result and Conclusion

Logistic Regression has **10.6%-11.1%** mean error rate and Linear Descriminant Analysis has **9.9%-10.5%** mean error rate. Both algorithms can detect about 90% of spam emails but LDA has a better performance.

# Limitation and Improvement

Limitation: the dataset is not large enough. We also have no idea whether the dataset is bias.

Improvement: gather more data and implement more algorithms.

# Data Sources and References:

Data from: Mark Hopkins, Erik Reeber, George Forman, and Jaap Suermondt. "Spambase Data Set." Spambase Data Set. 	Hewlett-Packard Labs, 1 July 1999. Web. 1 Mar. 2015. <http://archive.ics.uci.edu/ml/datasets/Spambase>.

Reference: Trevor Hastie, Rob Tibshirani. “Statistical Learning.” Statistical Learning. Stanford University Online CourseWare, 21 January 2014. Lecture. <http://online.stanford.edu/course/statistical-learning-winter-2014 >
