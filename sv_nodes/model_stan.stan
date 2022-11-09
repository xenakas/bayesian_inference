data {
  int<lower=1> T;            // num observations
  real<lower=0> y[T];                 // observed outputs
  int trend[T];

  int<lower=0, upper=1> dw1[T]; // dummy
  int<lower=0, upper=1> dw2[T]; // dummy
  int<lower=0, upper=1> dw4[T]; // dummy
  int<lower=0, upper=1> dw5[T]; // dummy
  int<lower=0, upper=1> dw6[T]; // dummy
  int<lower=0, upper=1> dw7[T]; // dummy

  int<lower=0, upper=1> dhol[T]; // dummy
  int<lower=0, upper=1> dcov1[T]; // dummy
  int<lower=0, upper=1> dcov2[T]; // dummy
  int<lower=0, upper=1> dhdd[T]; // dummy
  int<lower=0, upper=1> dcdd[T]; // dummy

  int four_order;
  matrix [T, four_order] f_mat;

  int reg_matrix_size;
  matrix [T, reg_matrix_size] reg_matrix;

  int<lower=0, upper=1> dtp[T]; // dummy
  int<lower=0, upper=1> dtn[T]; // dummy
  real temp[T];                 // observed temp diff

}

parameters {

  real ccdd;
  real chdd;
  
  real ctempp;
  real ctempn;
  real ctemppl;
  real ctempnl;

  real cw1;                 // coeff dummy
  real cw2;                 // coeff dummy
  real cw4;                 // coeff dummy
  real cw5;                 // coeff dummy
  real cw6;                 // coeff dummy
  real cw7;                 // coeff dummy
  
  real chol;                 // coeff dummy
  real ccov1;                 // coeff dummy
  real ccov2;                 // coeff dummy
  
  real ctrend;
  real mu;
  
  vector[four_order] cfour;
  vector[reg_matrix_size] creg;
  
  real kap;                     // mean log volatility
  real<lower=-1,upper=1> phi;  // persistence of volatility
  vector[T] h;                 // log volatility at time t

  real<lower=0> sigma;       // noise scale
}


transformed parameters {
  vector[T] res;
  for (t in 1:T)
    res[t] = y[t] - (mu + f_mat[t,]*cfour   +  ctrend*trend[t] +  reg_matrix[t,]*creg   + 
    ccdd * dcdd[t] + chdd * dhdd[t] +
    cw1 * dw1[t] +  cw2 * dw2[t] +  cw4 * dw4[t] +  cw5 * dw5[t] +  cw6 * dw6[t] +  cw7 * dw7[t] +
    chol * dhol[t] + ccov1 * dcov1[t] + ccov2 * dcov2[t] ); 
}

model {
  h[1] ~ normal(kap, sigma / sqrt(1 - phi * phi));
  for (t in 2:T)
    h[t] ~ normal(kap + phi * (h[t - 1] -  kap), sigma);

  res[1] ~ normal(ctempp * dtp[1] * temp[1] + ctempn * dtn[1] * temp[1], exp(h[1] / 2));
  for (t in 2:T)
    res[t] ~ normal(res[t-1] +  ctempp * dtp[t] * temp[t] + ctempn * dtn[t] * temp[t] +
    ctemppl * dtp[t-1] * temp[t-1] + ctempnl * dtn[t-1] * temp[t-1], exp(h[t] / 2));

  ccdd ~ normal(0, 1);
  chdd ~ normal(0, 1);

  ctempp ~ double_exponential(0, 1);
  ctemppl ~ double_exponential(0, 1);
  ctempn ~ double_exponential(0, 1);
  ctempnl ~ double_exponential(0, 1);

  cw1 ~ normal(0, 1);
  cw2 ~ normal(0, 1);
  cw4 ~ normal(0, 1);
  cw5 ~ normal(0, 1);
  cw6 ~ normal(0, 1);
  cw7 ~ normal(0, 1);

  chol ~ normal(0, 1);
  ccov1 ~ normal(0, 1);
  ccov2 ~ normal(0, 1);

  ctrend ~ normal(0, 1);
  
  cfour ~ normal(0, 1);
  creg ~ normal(0, 1);

  mu ~ normal(7, 1);
  phi ~ uniform(-1, 1);
  kap ~ cauchy(0, 10);
  sigma ~ cauchy(0, 5); 
}

