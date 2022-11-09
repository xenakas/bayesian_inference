{
options(repr.plot.width=6, repr.plot.height=5)

setwd("~/electricity")  

library("rstan")
library('dplyr')
library("recipes")
library('parallel')
library('bayesplot')
library("forecast")
library('bridgesampling')
library('shinystan')
library(forecast)

rstan_options(auto_write = TRUE)
options(mc.cores = 10)
}


df_locs <- read.csv('data_loc.csv')
names_df <- read.csv('names_df.csv', stringsAsFactors = F)

names_df <- names_df[names_df['names_df_loc']!='DROP',]
row.names(names_df) <- NULL
names_df['num_prices'][names_df['num_prices'] == 'DROP'] <- 0

un_reg <- names_df['names_df_loc']
mat_reg <- names_df['num_prices']

reg = 2
df <- read.csv(paste('reg_FULL/', un_reg[reg,1], '.csv', sep=''))

mod1 <- stan_model("model_stan.stan")
df_coefs <- read.csv('df_par_names.csv')
f_order <- 4

rand_order <- readRDS('rand_order.rds')
rand_order <- rand_order[16:64] 

for (reg in rand_order){
  df <- read.csv(paste('reg_FULL/', un_reg[reg,1], '.csv', sep=''))
  df['trend'] <- seq(1,dim(df)[1])
  
  tsc11 = df['price']
  tsc11[tsc11 < 1] = 1  
  tsc11 = ts(log(tsc11))
  aaa<-tsoutliers(tsc11)
  tsc11[aaa$index] = aaa$replacements
  df['lprice_wo'] = tsc11
  
  standata <- within(list(), {
    y <- as.vector(df[['lprice_wo']])
    T <- length(y)
    trend <- as.vector(df[['trend']])
    
    dw1 <- as.vector(df[['d_w1']])
    dw2 <- as.vector(df[['d_w2']])
    dw4 <- as.vector(df[['d_w4']])
    dw5 <- as.vector(df[['d_w5']])
    dw6 <- as.vector(df[['d_w6']])
    dw7 <- as.vector(df[['d_w7']])
    
    dhol <- as.vector(df[['gov_holidays']])
    dcov1 <- as.vector(df[['gov_covid_2020']])
    dcov2 <- as.vector(df[['gov_covid_2021']])
    dhdd <- as.vector(df[['dum_hdd']])
    dcdd <- as.vector(df[['dum_cdd']])
    
    four_order <- f_order*2
    f_mat <- fourier(ts(df['lprice_wo'],frequency = 365), K=f_order)
    
    temp <- as.vector(df[['temp_delta']])
    dtp  <- as.vector((df[['temp_delta']]>=0)*1)
    dtn  <- as.vector((df[['temp_delta']]<0)*1)
    
    reg_matrix_size <- 3+as.numeric(names_df[reg, 'num_prices'])
    
    reg_matrix <- as.matrix(log(df[,16:(16+reg_matrix_size-1)]))

})
  
  # mod3x_est <- optimizing(mod1, data = standata)
  # cf_df <- as.data.frame(mod3x_est$par)
  # colnames(cf_df) = un_reg[reg,1]
  # cf_df["par_name"] =  rownames(cf_df)
  # df_coefs <- merge(df_coefs, cf_df, by="par_name",  all.x=TRUE)

  start <- Sys.time()
  mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
  end <- Sys.time()
  
  print(end-start)
  print(un_reg[reg,1])
  
  saveRDS(mod1x_fit, paste('rds_models/', un_reg[reg,1], '.rds', sep=''))
  
}

# write.csv(df_coefs, 'df_coefs.csv')

my_sso <- launch_shinystan(mod1x_fit)






