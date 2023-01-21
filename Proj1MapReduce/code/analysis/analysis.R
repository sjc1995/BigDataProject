#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

# confidence interval by bootstrap
n = 25
files <- paste0('/gpfs/home/sjiecheng/project1/coef', 1:n, '.csv')
data <- data.frame(NULL)
for(i in 1:n){
  tmp_data <- read.csv(files[i], header = T)
  data <- rbind(data, tmp_data)
}

CI_bootstrap <- sapply(data, quantile, c(0.025,0.975, 0.05,0.95))
write.csv(as.data.frame(t(CI_bootstrap)), 'CI_bootstrap.csv')

# theoretical CI by lm function and confint
data2 <- read.csv('/gpfs/projects/AMS598/Projects/project1/project1_data.csv', header = T)
fit <- lm(y ~ X1+X2+X3+X4+X5+X6+X7+X8+X9+X10, data = data2)
CI_theory <- cbind(confint(fit, level = 0.95),confint(fit, level = 0.9))

write.csv(as.data.frame(CI_theory), 'CI_theory.csv')

# theoretical CI by formula
df <- nrow(data2)-11
S <- sqrt(sum(fit$residuals^2)/df)
X <- data.frame(intercept = rep(1, nrow(data2)))
X <- cbind(X,data2[c('X1','X2','X3','X4','X5','X6','X7','X8','X9','X10')])
V <- solve(t(as.matrix(X)) %*% as.matrix(X))
CI_formula <- data.frame('0.025' = numeric(11),'0.975' = numeric(11), '0.05'= numeric(11), '0.95' = numeric(11), 'SE' = numeric(11))
for(i in 1:11){
  CI_formula[i,] <- c(fit$coefficients[i] + qt(c(0.025,0.975,0.05,0.95), df = df) * S * sqrt(V[i,i]) , S * sqrt(V[i,i]))
}
CI_formula['coef'] <- fit$coefficients

write.csv(as.data.frame(CI_formula), 'CI_formula.csv')
