/*
*Hierarchical AR(K) Models
*/


data {
  int<lower=1> N; // total number of observations
  int<lower=1> K; // number of lagged factor
  int<lower=1> numG; // number of groups
  vector[N] y; // data for Hierarchical AR(K)
  int sizes[numG]; // sizes of observations across groups
}
parameters {
  real<lower = 0> local_sigma; 
  vector<lower = 0>[K] global_sigma;
  vector[K] z[numG];
  vector<lower = -2, upper = 2>[K] global_beta; // global AR(K) multipliers
}
transformed parameters {
  vector[K] group_betas[numG]; // group level AR(K) multipliers
  for(i in 1:numG) {
    group_betas[i] = global_beta + global_sigma .* z[i]; // NCP formulation, no correlations
  }
}
model {
  int pos;
  pos = 1;
  for(i in 1:numG) {  // loop over groups
    int local_N;
    vector[sizes[i]] local_y;
    local_N = sizes[i];
    local_y = segment(y, pos, local_N);
    for (n in (K + 1):local_N) { // loop over observations
      real mu;
      mu = 0;
      for (k in 1:K) { // loop over lags
        mu = mu + group_betas[i][k] * local_y[n - k];
      }
      y[n] ~ normal(mu, local_sigma);
    }
    z[i] ~ normal(0, 1);
    pos = pos + local_N;
  }
  
  // hyperpriors
  local_sigma ~ cauchy(0, 2);
  global_sigma ~ cauchy(0, 2);
  global_beta ~ cauchy(0, 2);
}

