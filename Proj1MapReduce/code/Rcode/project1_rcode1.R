#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

data <- read.csv('/gpfs/projects/AMS598/Projects/project1/project1_data.csv', header = T)

n <- 4000
coef <- data.frame(intercept = numeric(n), x1 = numeric(n), x2 = numeric(n), x3 = numeric(n), x4 = numeric(n), x5 = numeric(n), 
                   x6 = numeric(n), x7 = numeric(n), x8 = numeric(n), x9 = numeric(n), x10 = numeric(n))
for(i in 1:n){
  fit <- lm(y ~ X1+X2+X3+X4+X5+X6+X7+X8+X9+X10, data = data[sample(nrow(data),nrow(data), replace = T),])
  coef[i,] <- fit$coefficients
}

write.csv(coef,'coef1.csv')

