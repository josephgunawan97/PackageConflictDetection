library(sna)
library(rpart)
library(party)
library(plyr)
library(dplyr)

#READ MERGE DATA12
data_12 <- read.dot("12-Merge.dot") #Use complete directory of file location
data_12 <- data_12[rowSums(data_12)>0,]
data_12 <- data_12[,colSums(data_12)>0]

#SETUP DATA, SEPERATE COLOR BY NUMBER CODE
data_12 <- as.data.frame(data_12)
data_12.red <- data_12[,grepl("=red", names(data_12))]
data_12.blue <- data_12[,grepl("=blue", names(data_12))]
data_12.green <- data_12[,grepl("=green", names(data_12))]
data_12.purple <- data_12[,grepl("=purple", names(data_12))]

data_12.red[data_12.red>0] <- "2"
data_12.blue[data_12.blue>0] <- "3"
data_12.green[data_12.green>0] <- "4"
data_12.purple[data_12.purple>0] <- "5"

data_12[,grepl("red", names(data_12))] <- data_12.red
data_12[,grepl("blue", names(data_12))] <- data_12.blue
data_12[,grepl("green", names(data_12))] <- data_12.green
data_12[,grepl("purple", names(data_12))] <- data_12.purple

#REMOVE TAG
data_12 <- as.matrix(data_12)
rownames(data_12)<-sub("\\[.*?\\]","",rownames(data_12)) #Remove Tag start with [ end with ]
colnames(data_12)<-sub("\\[.*?\\]","",colnames(data_12))
rownames(data_12)<-sub("\\;","",rownames(data_12)) #Remove semicolon
colnames(data_12)<-sub("\\;","",colnames(data_12))
colnames(data_12)<-sub(" ","",colnames(data_12)) #Remove empty space
rownames(data_12)<-sub(" ","",rownames(data_12))
colnames(data_12)<-sub(" ","",colnames(data_12))
rownames(data_12)<-sub(" ","",rownames(data_12))

#DATAFRAME FOR TRAINING
dataframe_12 <- as.data.frame(data_12)
rownames(dataframe_12) <- c()

#READ MERGE DATA14
data_14 <- read.dot("14-Merge.dot") #Use complete directory of file location
data_14 <- data_14[rowSums(data_14)>0,]
data_14 <- data_14[,colSums(data_14)>0]

#SETUP DATA, SEPERATE COLOR BY NUMBER CODE
data_14 <- as.data.frame(data_14)
data_14.red <- data_14[,grepl("=red", names(data_14))]
data_14.blue <- data_14[,grepl("=blue", names(data_14))]
data_14.green <- data_14[,grepl("=green", names(data_14))]
data_14.purple <- data_14[,grepl("=purple", names(data_14))]

data_14.red[data_14.red>0] <- "2"
data_14.blue[data_14.blue>0] <- "3"
data_14.green[data_14.green>0] <- "4"
data_14.purple[data_14.purple>0] <- "5"

data_14[,grepl("red", names(data_14))] <- data_14.red
data_14[,grepl("blue", names(data_14))] <- data_14.blue
data_14[,grepl("green", names(data_14))] <- data_14.green
data_14[,grepl("purple", names(data_14))] <- data_14.purple

#REMOVE TAG
data_14 <- as.matrix(data_14)
rownames(data_14)<-sub("\\[.*?\\]","",rownames(data_14)) #Remove Tag start with [ end with ]
colnames(data_14)<-sub("\\[.*?\\]","",colnames(data_14))
rownames(data_14)<-sub("\\;","",rownames(data_14)) #Remove semicolon
colnames(data_14)<-sub("\\;","",colnames(data_14))
colnames(data_14)<-sub(" ","",colnames(data_14)) #Remove empty space
rownames(data_14)<-sub(" ","",rownames(data_14))
colnames(data_14)<-sub(" ","",colnames(data_14))
rownames(data_14)<-sub(" ","",rownames(data_14))


#DATAFRAME FOR TRAINING
dataframe_14 <- as.data.frame(data_14)
rownames(dataframe_14) <- c()

#READ MERGE DATA16
data_16 <- read.dot("16-Merge.dot") #Use complete directory of file location
data_16 <- data_16[rowSums(data_16)>0,]
data_16 <- data_16[,colSums(data_16)>0]

#SETUP DATA, SEPERATE COLOR BY NUMBER CODE
data_16 <- as.data.frame(data_16)
data_16.red <- data_16[,grepl("=red", names(data_16))]
data_16.blue <- data_16[,grepl("=blue", names(data_16))]
data_16.green <- data_16[,grepl("=green", names(data_16))]
data_16.purple <- data_16[,grepl("=purple", names(data_16))]

data_16.red[data_16.red>0] <- "2"
data_16.blue[data_16.blue>0] <-"3"
data_16.green[data_16.green>0] <- "4"
data_16.purple[data_16.purple>0] <-"5"

data_16[,grepl("red", names(data_16))] <- data_16.red
data_16[,grepl("blue", names(data_16))] <- data_16.blue
data_16[,grepl("green", names(data_16))] <- data_16.green
data_16[,grepl("purple", names(data_16))] <- data_16.purple

#REMOVE TAG
data_16 <- as.matrix(data_16)
rownames(data_16)<-sub("\\[.*?\\]","",rownames(data_16)) #Remove Tag start with [ end with ]
colnames(data_16)<-sub("\\[.*?\\]","",colnames(data_16))
rownames(data_16)<-sub("\\;","",rownames(data_16)) #Remove semicolon
colnames(data_16)<-sub("\\;","",colnames(data_16))
colnames(data_16)<-sub(" ","",colnames(data_16)) #Remove empty space
rownames(data_16)<-sub(" ","",rownames(data_16))
colnames(data_16)<-sub(" ","",colnames(data_16))
rownames(data_16)<-sub(" ","",rownames(data_16))

#DATAFRAME FOR TRAINING
dataframe_16 <- as.data.frame(data_16)
rownames(dataframe_16) <- c()

#MERGE ALL
dataframe_all <- rbind.fill(dataframe_12,dataframe_14)
dataframe_all <- rbind.fill(dataframe_all,dataframe_16)
dataframe_all[is.na(dataframe_all)] <- "0"
dataframe_all[dataframe_all==1] <- "1"

#INSERT NEW COLUMNS
dataframe_all$conflicts <-as.numeric( rowSums(dataframe_all=="2"))

#CREATE TRAINING AND TESTING DATA
set.seed(120)
split <- caTools::sample.split (dataframe_all, SplitRatio=0.7)
training <- subset (dataframe_all, split=="TRUE")
testing <- subset (dataframe_all, split=="FALSE")

#TRAIN AND PREDICT
model.tree.reg <- rpart(conflicts~., data=training, method="anova")
res.tree.reg <- predict(model.tree.reg,testing,method="anova")
table.res.reg <- table (Actual=testing$conflicts>=1,Prediction=res.tree.reg>=0.5)

model.tree.clas <- rpart(conflicts~., data=training, method="class")
res.tree.clas <- predict(model.tree.clas,testing,method="class")
res.tree.clas.filter <- colnames(res.tree.clas)[apply(res.tree.clas,1,which.max)]
table.res.clas  <- table (Actual=testing$conflicts>=1,Prediction=res.tree.clas.filter>=1)

#PLOT GRAPH
rpart.plot::rpart.plot(model.tree.reg)
rpart.plot::rpart.plot(model.tree.clas)

#PRINT CP_TABLE
cptable.reg <- as.data.frame(model.tree.reg$cptable)
cptable.class <- as.data.frame(model.tree.clas$cptable)

par(mfrow=c(1,2))
rsq.rpart(model.tree.reg)
rsq.rpart(model.tree.clas)

plot( cptable.reg$`rel error`, type="l", col="red" ,ylim=c(0.8,1))
lines( cptable.class$`rel error`, type="l", col="green" )
legend("topright", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

plot( cptable.reg$`xerror`, type="l", col="red" ,ylim=c(0.85,1.05))
lines( cptable.class$`xerror`, type="l", col="green" )
legend("bottomleft", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

plot( cptable.reg$`xstd`, type="l", col="red",ylim=c(0,0.6)  )
lines( cptable.class$`xstd`, type="l", col="green" )
legend("topleft", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

plot( cptable.reg$`CP`, type="l", col="red",ylim=c(0,0.07) )
lines( cptable.class$`CP`, type="l", col="green" )
legend("topright", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

#GET PVALUE
t.test(dataframe_all$conflicts)
t.test(training$conflicts)
t.test(testing$conflicts)

#TRAIN AND PREDICT 2
model.tree.reg2 <- rpart(conflicts~., data=training, method="anova", control = rpart.control(minsplit=9,cp=0.0001))
bestcp.reg <- model.tree.reg2$cptable[which.min(model.tree.reg2$cptable[,"xerror"]),"CP"]
tree.reg.pruned <- prune(model.tree.reg2, cp = bestcp.reg)
res.tree.reg2 <- predict(tree.reg.pruned ,testing,method="anova")
table.res.reg2 <- table (Actual=testing$conflicts>=1,Prediction=res.tree.reg2>=0.5)

model.tree.clas2<- rpart(conflicts~., data=training, method="class", control = rpart.control(minsplit=9,cp=0.0001))
bestcp.clas<- model.tree.clas2$cptable[which.min(model.tree.clas2$cptable[,"xerror"]),"CP"]
tree.class.pruned <- prune(model.tree.clas2, cp = bestcp.clas)
res.tree.clas2 <- predict(tree.class.pruned ,testing,method="class")
res.tree.clas2.filter <- colnames(res.tree.clas2)[apply(res.tree.clas2,1,which.max)]
table.res.clas2  <- table (Actual=testing$conflicts>=1,Prediction=res.tree.clas2.filter>=1)

#PLOT GRAPH
rpart.plot::rpart.plot(tree.reg.pruned)
rpart.plot::rpart.plot(tree.class.pruned)

#PRINT CP_TABLE
cptable.reg2 <- as.data.frame(tree.reg.pruned$cptable)
cptable.class2 <- as.data.frame(tree.class.pruned$cptable)

par(mfrow=c(1,2))
rsq.rpart(model.tree.reg2)
rsq.rpart(model.tree.clas2)

plot( cptable.reg2$`rel error`, type="l", col="red" ,ylim=c(0.5,1))
lines( cptable.class2$`rel error`, type="l", col="green" )
legend("topright", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

plot( cptable.reg2$`xerror`, type="l", col="red" ,ylim=c(0.8,1.05))
lines( cptable.class2$`xerror`, type="l", col="green" )
legend("bottomleft", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

plot( cptable.reg2$`xstd`, type="l", col="red",ylim=c(0,0.6)  )
lines( cptable.class2$`xstd`, type="l", col="green" )
legend("topleft", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

plot( cptable.reg2$`CP`, type="l", col="red",ylim=c(0,0.15) )
lines( cptable.class2$`CP`, type="l", col="green" )
legend("topright", legend=c("Regression", "Classification"), col=c("red", "green"), lty=1:1, cex=0.8)

##TRAIN WITH RANDOM FOREST
library(randomForest)
rf.training <- training
names(rf.training ) <- make.names(names(rf.training ))
model.rf <- randomForest(conflicts~.,rf.training)
rf.testing <- testing
names(rf.testing) <- make.names(names(rf.testing))
res.rf <- predict(model.rf ,rf.testing)
table.rf  <-table (Actual=testing$conflicts>=1,Prediction=res.rf>=1)


RMSE_class <- caret::RMSE(testing$conflicts,as.numeric(res.tree.clas.filter))
RMSE_reg <- caret::RMSE(testing$conflicts,res.tree.reg)
RMSE_class2 <- caret::RMSE(testing$conflicts,as.numeric(res.tree.clas2.filter))
RMSE_reg2 <- caret::RMSE(testing$conflicts,res.tree.reg2)
RMSE_rf <- caret::RMSE(testing$conflicts,res.rf)

MAE_class <- caret::MAE(testing$conflicts,as.numeric(res.tree.clas.filter))
MAE_reg <- caret::MAE(testing$conflicts,res.tree.reg)
MAE_class2 <- caret::MAE(testing$conflicts,as.numeric(res.tree.clas2.filter))
MAE_reg2 <- caret::MAE(testing$conflicts,res.tree.reg2)
MAE_rf <- caret::MAE(testing$conflicts,res.rf)

MSE_class <- RMSE_class^2
MSE_reg <-  RMSE_reg^2
MSE_class2 <-  RMSE_class2^2
MSE_reg2 <- RMSE_reg2^2
MSE_rf <- RMSE_rf^2

table_RMSE <- c(RMSE_class,RMSE_reg, RMSE_class2,RMSE_reg2,RMSE_rf )
table_MSE <- c(MSE_class,MSE_reg, MSE_class2,MSE_reg2,MSE_rf )
table_MAE <- c(MAE_class,MAE_reg, MAE_class2,MAE_reg2,MAE_rf )
data_statistic <- data.frame(Method=c("Classification","Regression", "Classification(pruned)","Regression(pruned)","Random Forest"),MSE=table_MSE, RMSE=table_RMSE, MAE=table_MAE)

#https://stats.stackexchange.com/questions/215290/performance-of-regression-tree-rpart
#https://stackoverflow.com/questions/9666212/how-to-compute-error-rate-from-a-decision-tree
#https://infocenter.informationbuilders.com/wf80/index.jsp?topic=%2Fpubdocs%2FRStat16%2Fsource%2Ftopic47.htm
#colnames(res.tree.clas)

ds <-melt(data_statistic,id.vars="Method")
ggplot(ds, aes(x = variable, y = value,fill=Method)) + geom_bar(stat = "identity",position="dodge")

