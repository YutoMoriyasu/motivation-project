library("dplyr")
library("glmnet")
data=read.table("wave.txt",header=TRUE,sep="\t")

x=as.matrix(dplyr::select(data,-observation))
write.table(x,file="x.txt",quote=FALSE)
y=unlist(dplyr::select(data,observation))
write.table(y,file="y.txt",quote=FALSE)

doukizuke=glmnet(x,y,intercept=TRUE)
plot(doukizuke)
dev.new()
plot(doukizuke,xvar="lambda")

cv.doukizuke=cv.glmnet(x,y,intercept=TRUE)
coefficient=coef(cv.doukizuke,s="lambda.1se")
write.table(as.matrix(coefficient),file="coefficient.txt",quote=FALSE)
dev.new()
plot(cv.doukizuke)
