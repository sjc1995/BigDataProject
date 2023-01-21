updatebeta <- function(i){
  data_file <- paste0('~/Documents/2021 fall/AMS 598/project4/project4_data_part',i,'.csv')
  data <- read.csv(data_file)
  x <- data[,-1]
  x <- cbind(intercept = rep(1, nrow(x)), x)
  x <- as.matrix(x)
  y <- data[,1]
  
  beta_file <- paste0('~/Documents/2021 fall/AMS 598/project4/lasso/beta',i,'.csv')
  beta <- read.csv(beta_file)
  beta <- as.matrix(beta)
  
  betabar <- read.csv('~/Documents/2021 fall/AMS 598/project4/lasso/betabar.csv')
  betabar <- as.matrix(betabar)
  
  uall <- read.csv('~/Documents/2021 fall/AMS 598/project4/lasso/u.csv')
  u <- uall[,i]
  u <- as.matrix(u)
  
  rho <- 100
  
  g <- function(z) 1/(1 + exp(-z))
  likelihood <- function(x,y,beta, betabar, rho, u){
    return(- sum(log(1 + exp(x %*% beta))) + (t(y) %*% x) %*% beta - rho/2 * sum((beta- betabar + u)^2))
  }
  
  l <- likelihood(x,y,beta, betabar, rho, u)
  l1 <- l - 10
  
  while(l - l1 > 0.001){
    l1 <- l
    beta <- beta - 1e-6 * ((t(x) %*% (g(x %*% beta)-y)) + rho * (beta - betabar + u))
    beta <- as.vector(beta)
    l <- likelihood(x,y,beta, betabar, rho, u)
  }
  beta <- as.matrix(beta)
  write.csv(beta, beta_file, row.names = F)
  
  likelihood2 <- function(x,y,beta){
    return(- sum(log(1 + exp(x %*% beta))) + (t(y) %*% x) %*% beta)
  }
  likelihoods <- likelihood2(x, y, betabar)
  return(likelihoods)
}

like <- read.csv('~/Documents/2021 fall/AMS 598/project4/lasso/likelihood.csv')

likelihoods <- c()
for(i in 1:10){
  print(i)
  likelihoods <- c(likelihoods, updatebeta(i))
}

like <- rbind(like, likelihoods)
apply(like,1,mean)
write.csv(like, '~/Documents/2021 fall/AMS 598/project4/lasso/likelihood.csv', row.names = F)

####################

betaall <- NULL
for(i in 1:10){
  beta_file <- paste0('~/Documents/2021 fall/AMS 598/project4/lasso/beta',i,'.csv')
  beta <- read.csv(beta_file)
  beta <- as.matrix(beta)
  betaall <- cbind(betaall, beta)
}

betabar <- apply(betaall, 1, mean)
lambda <- 1e-2
updatebar <- function(x, lambda){
  for(i in 1:length(x)){
    x[i] <- ifelse(abs(x[i]) > lambda,x[i] - sign(x[i])*lambda, 0)
  }
  return(x)
}

betabar <- updatebar(betabar, lambda)
betabar <- as.matrix(betabar)
write.csv(betabar, '~/Documents/2021 fall/AMS 598/project4/lasso/betabar.csv', row.names = F)

u <- read.csv('~/Documents/2021 fall/AMS 598/project4/lasso/u.csv')

for(i in 1:10){
  beta_file <- paste0('~/Documents/2021 fall/AMS 598/project4/lasso/beta',i,'.csv')
  u[,i] <- u[,i] + (betaall[,i] - betabar)
}

write.csv(u, '~/Documents/2021 fall/AMS 598/project4/lasso/u.csv', row.names = F)






