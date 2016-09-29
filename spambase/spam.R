require(MASS)
require(ISLR)
require(randomForest)
require(caret)
require(stats)
require(tree)
require(rpart)
require(rattle)
################ PREVIOUS CODE #####################################
# DataSet Initialization
setwd("C:/Users/Ivory/Desktop/RProject")
spam_data <- read.table("spambase.data", sep = ",")
print(spam_data)
names(spam_data)

names <- read.table("spam_names.txt", sep = "\n")
names(spam_data) <- names
names <- as.character(names)
names <- read.table("spam_names.txt", sep="\n")
names(spam_data) <- names[,1]
names(spam_data)
names(spam_data)[58] <- "class"

# Logistic Regression
glm_fit = glm(class ~., data = spam_data, family = "gaussian")
summary(glm_fit)
plot(glm_fit)
glm_pred = predict(glm_fit, type = "response")
#glm_pred[1812:1816]
#glm_pred=ifelse(glm_probs > 0.5,"Up","Down")


# Linear Discriminant Analysis
lda_fit = lda(class ~., data = spam_data)
summary(lda_fit)
plot(lda_fit)
lda_pred = predict(lda_fit, type = "response")
mean(abs(spam_data[, 58] - as.numeric(lda_pred$class)+1))

# 10-fold Cross Validation

## Testing, Traning sample initialization
tmp <- sample(4601, 4601, replace=FALSE)

## Cross validation for LDA
lda_error <- rep(0, 10)
for(i in 0:9){
  testing <- spam_data[tmp[(460*i+1):(460*(i+1))], ]
  training <- spam_data[-tmp[(460*i+1):(460*(i+1))], ]
  
  lda_fit = lda(class ~., data = training)
  lda_pred = predict(lda_fit, type = "response", newdata = testing)
  lda_error[i] <- mean(abs(testing$class-as.numeric(lda_pred$class)+1))  
}
mean(lda_error)

## Cross validation for GLM
glm_error <- rep(0, 10)
for(i in 0:9){
  testing <- spam_data[tmp[(460*i+1):(460*(i+1))], ]
  training <- spam_data[-tmp[(460*i+1):(460*(i+1))], ]

  glm_fit = glm(class ~., data = training, family = "binomial")
  glm_pred = predict(glm_fit, type = "response", newdata = testing)
  glm_error[i] <- mean(abs(testing$class-glm_pred)) 
}
mean(glm_error)

## Do it 100 times!!!
lda <- rep(0, 100)
for(idx in 1 : 100) {
  tmp <- sample(4601, 4601, replace=FALSE)
  
  lda_error <- rep(0, 10)
  for(i in 0:9){
    testing <- spam_data[tmp[(460*i+1):(460*(i+1))], ]
    training <- spam_data[-tmp[(460*i+1):(460*(i+1))], ]
    
    lda_fit = lda(class ~., data = training)
    lda_pred = predict(lda_fit, type = "response", newdata = testing)
    lda_error[i] <- mean(abs(testing$class-as.numeric(lda_pred$class)+1))  
  }
  lda[idx] <- mean(lda_error)
}
mean(lda)
ldasort <- sort(lda)

glm <- rep(0, 100)
for(idx in 1 : 100) {
  tmp <- sample(4601, 4601, replace=FALSE)
  
  glm_error <- rep(0, 10)
  for(i in 0:9){
    testing <- spam_data[tmp[(460*i+1):(460*(i+1))], ]
    training <- spam_data[-tmp[(460*i+1):(460*(i+1))], ]
    
    glm_fit = glm(class ~., data = training, family = "binomial")
    glm_pred = predict(glm_fit, type = "response", newdata = testing)
    glm_error[i] <- mean(abs(testing$class-glm_pred)) 
  }
  glm[idx] <- mean(glm_error)
}
mean(glm)
glmsort <- sort(glm)
######################### NEW CODE #################################
  
set.seed(727)
tmp <- sample(1:nrow(spam_data), round(nrow(spam_data) * 0.9, digits = 0))
#tmp <- sample(1:nrow(spam_data), round(nrow(spam_data) * 0.7, digits = 0))
training <- spam_data[tmp, ]
testing <- spam_data[-tmp, ]

tree_fit <- rpart(class ~., method = "class", data = training)
summary(tree_fit)
plot(tree_fit, uniform = TRUE, main = "class Tree for News Popularity")
text(tree_fit, use.n=TRUE, all=TRUE, cex=.8)
fancyRpartPlot(tree_fit)
tree_pred = predict(tree_fit, newdata = testing, type="class")
table(tree_pred, testing$class)
confusionMatrix(testing$class, sample(testing$class))

# Logistic Regression
glm_fit = glm(class ~., data = training, family = "gaussian")
glm_pred = predict(glm_fit, newdata = testing, type = "response")
confusionMatrix(testing$class, sample(testing$class))

# Distribution Tree and Random Forest using cross validatino
tree_error <- rep(0, 10)
for(i in 0:9){
  testing <- spam_data[tmp[(460*i+1):(460*(i+1))], ]
  training <- spam_data[-tmp[(460*i+1):(460*(i+1))], ]
  
  tree_fit <- rpart(class ~., method = "class", data = training)
  tree_pred = predict(tree_fit, newdata = testing, type="class")
  tree_error[i] <- mean(abs(testing$class-(as.numeric(tree_pred)-1)))  
}
mean(tree_error)

forest_error <- rep(0, 10)
for(i in 0:9){
  testing <- spam_data[tmp[(460*i+1):(460*(i+1))], ]
  training <- spam_data[-tmp[(460*i+1):(460*(i+1))], ]
  
  forest_fit <- randomForest(class ~., data = training)
  forest_pred = predict(forest_fit, newdata = testing, type = "class")
  forest_error[i] <- mean(abs(testing$class-(as.numeric(forest_pred)-1)))  
}
forest_fit <- randomForest(class ~ timedelta + n_tokens_content + num_self_hrefs + num_keywords + num_hrefs + num_imgs + data_channel_is_lifestyle + data_channel_is_socmed + data_channel_is_tech + is_weekend + rate_positive_words + title_subjectivity + title_sentiment_polarity,
                           data = training)


######################### FOR REFERNCE ########################################
if(false) {
  # Cross Validation for GLM using function in slide
  loocv=function(fit){
    h=lm.influence(fit)$h
    mean((residuals(fit)/(1-h))^2)
  }
  loocv(glm_fit)
  
  # Radom Forest
  install.packages("randomForest")
  library(randomForest)
  forestfit <- randomForest(x=spam_data[,1:57], y=as.factor(spam_data$class), data=spam_data)
  order(forestfit$importance)
  forestfit$importance[47]
  forestfit$importance
  plot(spam_data[,52], spam_data[,53], col=spam_data$class)
  plot(spam_data[,52], spam_data[,53], col=(spam_data$class+10))
  
  names <- read.table("spam_names.txt", sep = "\n")
  names(spam_data) <- names
  names <- as.character(names)
  names <- read.table("spam_names.txt", sep = "\n")
  names(spam_data) <- names[,1]
  names(spam_data)
  
  # Make training and test set
  samplesize <- 3601
  train_labels <- sample(1:4601, samplesize)
  train = spam_data[train_labels, ]
  test = spam_data[-train_labels, ]
  glm_fit = glm( class ~., data = train, family = "gaussian")
  glm_probs = predict(glm_fit, newdata = test, type="response") 
  glm_pred=ifelse(glm_probs > 0.5,1,0)
  testclass=spam.csv$class[-train_labels]
  table(glm_pred,testclass)
  mean(glm_pred==testclass) 
}

#######################################################################  

