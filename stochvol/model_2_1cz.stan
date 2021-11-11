data {
  int<lower=1> T;            // num observations
  real y[T];                 // observed outputs
  int trend[T];
  int<lower=0, upper=1> dsat[T]; // dummy
  int<lower=0, upper=1> dsun[T]; // dummy
  int<lower=0, upper=1> dmon[T]; // dummy
  int<lower=0, upper=1> dhol[T]; // dummy
  int<lower=0, upper=1> dhdd[T]; // dummy
  int<lower=0, upper=1> dcdd[T]; // dummy
  int<lower=0, upper=1> dtp[T]; // dummy
  int<lower=0, upper=1> dtn[T]; // dummy
  real temp[T];                 // observed temp diff
  real gdp[T];
  real pgas[T];
  real pcoal[T];
  
  int four_order;
  matrix [T, four_order] f_mat;
  
  
}

parameters {
//  real<lower = -1, upper = 1> phi;                  // autoregression coeff
  real ccdd; 
  real chdd;
  
  real ctempp;
  real ctempn;
  real ctemppl;
  real ctempnl;

  
  real csat;                 // coeff dummy
  real csun;                 // coeff dummy
  real cmon;                 // coeff dummy
  real chol;                 // coeff dummy
  real ctrend;
  real cgdp;
  real cgas;
  real ccoal;
  real mu;
  
  vector[four_order] cfour;
  
  real kap;                     // mean log volatility
  real<lower=-1,upper=1> phi;  // persistence of volatility
  vector[T] h;                 // log volatility at time t

  
  
  real<lower=0> sigma;       // noise scale
}
transformed parameters {
  vector[T] res;
  for (t in 1:T)
    res[t] = y[t] - (mu + f_mat[t,]*cfour   +  ctrend*trend[t] + ccdd * dcdd[t] + chdd * dhdd[t] +  csat * dsat[t] + csun * dsun[t] + cmon * dmon[t] + chol * dhol[t] );
}
model {
  h[1] ~ normal(kap, sigma / sqrt(1 - phi * phi));
  for (t in 2:T)
    h[t] ~ normal(kap + phi * (h[t - 1] -  kap), sigma);

  res[1] ~ normal(cgdp * gdp[1] + cgas * pgas[1] + ccoal * pcoal[1] + ctempp * dtp[1] * temp[1] + ctempn * dtn[1] * temp[1], exp(h[1] / 2));
  for (t in 2:T)
    res[t] ~ normal(res[t-1] +  cgdp * gdp[t] + cgas * pgas[t] + ccoal * pcoal[t]  +  ctempp * dtp[t] * temp[t] + ctempn * dtn[t] * temp[t] + ctemppl * dtp[t-1] * temp[t-1] + ctempnl * dtn[t-1] * temp[t-1], exp(h[t] / 2));



  ccdd ~ normal(0, 1); 
  chdd ~ normal(0, 1);

  ctempp ~ double_exponential(0, 1);
  ctemppl ~ double_exponential(0, 1);
  ctempn ~ double_exponential(0, 1);
  ctempnl ~ double_exponential(0, 1);


  csat ~ normal(0, 1);
  csun ~ normal(0, 1);
  cmon ~ normal(0, 1);
  chol ~ normal(0, 1);

  ctrend ~ normal(0, 1);
  
  cfour ~ normal(0, 1);

  cgdp ~ double_exponential(0, 1);
  cgas ~ double_exponential(0, 1); 
  ccoal ~ double_exponential(0, 1); 
  
  mu ~ normal(7, 1);
  phi ~ uniform(-1, 1);
  kap ~ cauchy(0, 10);
  sigma ~ cauchy(0, 5); //  sigma ~ normal(0, 3);
}
