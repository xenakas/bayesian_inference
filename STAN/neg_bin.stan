/*
*Simple negative binomial regression example
*using the 2nd parametrization of the negative
*binomial distribution, see section 40.1-3 in the Stan
*reference guide
*/

data {
  int N; //the number of observations
  int K; //the number of columns in the model matrix
  int y[N]; //the response
  matrix[N,K] X; //the model matrix
}
parameters {
  vector[K] beta; //the regression parameters
  real phi; //the overdispersion parameters
}
transformed parameters {
  vector[N] mu;//the linear predictor
  mu <- exp(X*beta); //using the log link 
}
model {  
  beta[1] ~ cauchy(0,10); //prior for the intercept following Gelman 2008

  for(i in 2:K)
   beta[i] ~ cauchy(0,2.5);//prior for the slopes following Gelman 2008
  
  y ~ neg_binomial_2(mu,phi);
}
generated quantities {
 vector[N] y_rep;
 for(n in 1:N){
  y_rep[n] <- neg_binomial_2_rng(mu[n],phi); //posterior draws to get posterior predictive checks
 }
}
