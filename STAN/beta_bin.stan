/*
*Simple beta-binomial example
*/

data {
  int N; //the number of observations
  int K; //the number of columns in the model matrix
  int y[N]; //the response
  matrix[N,K] X; //the model matrix
  int W[N]; //the number of trials per observations, ie a vector of 1 for a 0/1 dataset
}
parameters {
  vector[K] betas; //the regression parameters
  real phi; //the overdispersion parameter
}
transformed parameters {
  vector[N] mu; //the linear predictor
  vector[N] alpha; //the first shape parameter for the beta distribution
  vector[N] beta; //the second shape parameter for the beta distribution
  
  for(n in 1:N)
   mu[n] <- inv_logit(X[n,]*betas); //using logit link
  alpha <- mu * phi;
  beta <- (1-mu) * phi;
}
model {  
  betas[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008

  for(i in 2:K)
   betas[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008
  
  y ~ beta_binomial(W,alpha,beta);
}
generated quantities {
 vector[N] y_rep;
 for(n in 1:N){
  y_rep[n] <- beta_binomial_rng(W[n],alpha[n],beta[n]); //posterior draws to get posterior predictive checks
 }
}
