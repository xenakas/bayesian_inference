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
  
  
  real<lower=0> sigma;       // noise scale
}
model {
  y[1] ~ normal( mu + f_mat[1,]*cfour   +  ctrend*trend[1] + ccdd * dcdd[1] + chdd * dhdd[1] +  csat * dsat[1] + csun * dsun[1] + cmon * dmon[1] + chol * dhol[1] + cgdp * gdp[1] + cgas * pgas[1] + ccoal * pcoal[1] + ctempp * dtp[1] * temp[1] + ctempn * dtn[1] * temp[1] , sigma); 
  for (t in 2:T) {
    y[t] ~ normal(y[t-1] + mu + f_mat[t,]*cfour   +  ctrend*trend[t] + ccdd * dcdd[t] + chdd * dhdd[t] +  csat * dsat[t] + csun * dsun[t] + cmon * dmon[t] + chol * dhol[t] +  cgdp * gdp[t] + cgas * pgas[t] + ccoal * pcoal[t]  +  ctempp * dtp[t] * temp[t] + ctempn * dtn[t] * temp[t] + ctemppl * dtp[t-1] * temp[t-1] + ctempnl * dtn[t-1] * temp[t-1] , sigma);
  }




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

  sigma ~ cauchy(0, 5); //  sigma ~ normal(0, 3);
}
