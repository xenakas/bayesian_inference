options(repr.plot.width=6, repr.plot.height=5)
setwd("/media/xenakas/ext4_drive/NIR/1_electricity_2021/data")

library("rstan")
library("tidyverse")
library("recipes")
library('parallel')
library('bayesplot')
library("forecast")
library('bridgesampling')
library('shinystan')

rstan_options(auto_write = TRUE)
# options(mc.cores = parallel::detectCores())
options(mc.cores = 10)


df_all <- read_csv('shortdf_wo.csv')

# temp <-

############################## Model 3 #####################################

df <- drop_na(df_all)

f_order <- 4

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_1']]))
  T <- length(y)
  trend <- as.vector(df[['trend']])
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dhdd <- as.vector(df[['dum_hdd']])
  dcdd <- as.vector(df[['dum_cdd_1']])
  # d1 <-  as.vector(df[['dum_1_1']])
  # d2 <-  as.vector(df[['dum_1_2']])
  # d3 <-  as.vector(df[['dum_1_3']])
  # d4 <-  as.vector(df[['dum_1_4']])
  temp <- as.vector(df[['temp_ma_res_1']])
  dtp  <- as.vector((df[['temp_ma_res_1']]>=0)*1)
  dtn  <- as.vector((df[['temp_ma_res_1']]<0)*1)
  # hdd <- as.vector(df[['hdd_1']])
  # cdd <- as.vector(df[['cdd_1']])
  gdp <-  as.vector(c(0,diff((df[['ipp_trend']]))))
  pgas <- as.vector(c(0,diff(df[['gaz_1pz']])))
#  pgas <- as.vector(log(df[['gaz_rf']]))
  pcoal <- as.vector(c(0,diff(df[['coal_rf']])))
  four_order <- f_order*2
  f_mat <- fourier(ts(log(df[['consumer_price_1']]),frequency = 365), K=f_order)

})


mod1 <- stan_model("model_0_1cz.stan")
mod0x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod0x_fit, 'model_0_1cz.rds')

# check_opt <-optimizing(mod1, data = standata, hessian = TRUE)
# check_opt$par[1:20]
# mod0 <- readRDS('models_RDS/model_0_1cz_m.rds')
# launch_shinystan(mod0)

mod1 <- stan_model("model_1_1cz.stan")
mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod1x_fit, 'model_1_1cz.rds')

mod1 <- stan_model("model_2_1cz.stan")
mod2x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod2x_fit, 'model_2_1cz.rds')

mod1 <- stan_model("model_3_1cz.stan")
mod3x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod3x_fit, 'model_3_1cz.rds')







# https://github.com/quentingronau/bridgesampling/issues/7
    
mod0 <- stan_model("model_0_1cz.stan")
new_mod0 <- sampling(mod0, data = standata,  chains = 0)
mod0_fit <- readRDS('models_RDS/model_0_1cz_m.rds')
lml_0 <- bridge_sampler(mod0_fit, new_mod0)


mod1 <- stan_model("model_1_1cz.stan")
new_mod1 <- sampling(mod1, data = standata,  chains = 0)
mod1_fit <- readRDS('models_RDS/model_1_1cz_m.rds')
lml_1 <- bridge_sampler(mod1_fit, new_mod1)

mod2 <- stan_model("model_2_1cz.stan")
new_mod2 <- sampling(mod2, data = standata,  chains = 0)
mod2_fit <- readRDS('models_RDS/model_2_1cz_m.rds')
lml_2 <- bridge_sampler(mod2_fit, new_mod2)

mod3 <- stan_model("model_3_1cz.stan")
new_mod3 <- sampling(mod3, data = standata,  chains = 0)
mod3_fit <- readRDS('models_RDS/model_3_1cz_m.rds')
lml_3 <- bridge_sampler(mod3_fit, new_mod3)


diff(df[['gaz_1pz']])

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_1']]))
  T <- length(y)
  trend <- as.vector(df[['trend']])
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dhdd <- as.vector(df[['dum_hdd']])
  dcdd <- as.vector(df[['dum_cdd_1']])
  d1 <-  as.vector(df[['dum_1_1']])
  d2 <-  as.vector(df[['dum_1_2']])
  d3 <-  as.vector(df[['dum_1_3']])
  d4 <-  as.vector(df[['dum_1_4']])
  temp <- as.vector(df[['temp_ma_res_1']])
  dtp  <- as.vector((df[['temp_ma_res_1']]>=0)*1)
  dtn  <- as.vector((df[['temp_ma_res_1']]<0)*1)
  # hdd <- as.vector(df[['hdd_1']])
  # cdd <- as.vector(df[['cdd_1']])
  gdp <-  as.vector(c(0,diff((df[['ipp_trend']]))))
  pgas <- as.vector(c(0,diff(df[['gaz_1pz']])))
  #  pgas <- as.vector(log(df[['gaz_rf']]))
  pcoal <- as.vector(c(0,diff(df[['coal_rf']])))
  four_order <- f_order*2
  f_mat <- fourier(ts(log(df[['consumer_price_1']]),frequency = 365), K=f_order)

})

mod1 <- stan_model("model_4_1cz.stan")
mod4x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod4x_fit, 'model_4_1cz.rds')



mod4 <- stan_model("model_4_1cz.stan")
new_mod4 <- sampling(mod4, data = standata,  chains = 0)
mod4_fit <- readRDS('models_RDS/model_4_1cz_m.rds')
lml_4 <- bridge_sampler(mod4_fit, new_mod4)



bridgesampling::bf(lml_1,lml_0) #1
bridgesampling::bf(lml_2,lml_1) #1
bridgesampling::bf(lml_3,lml_2) #0
bridgesampling::bf(lml_4,lml_3) #0






df <- drop_na(df_all)

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_2']]))
  T <- length(y)
  dhdd <- as.vector(df[['dum_hdd']])
  dcdd <- as.vector(df[['dum_cdd_2']])
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  # d1 <-  as.vector(df[['dum_2_1']])
  # d2 <-  as.vector(df[['dum_2_2']])
  # d3 <-  as.vector(df[['dum_2_3']])
  temp <- as.vector(df[['temp_ma_res_2']])
  trend <- as.vector(df[['trend']])
  dtp  <- as.vector((df[['temp_ma_res_2']]>=0)*1)
  dtn  <- as.vector((df[['temp_ma_res_2']]<0)*1)
  # hdd <- as.vector(df[['hdd_1']])
  # cdd <- as.vector(df[['cdd_1']])
  gdp <-  as.vector(c(0,diff((df[['ipp_trend']]))))
  pgas <- as.vector(c(0,diff(df[['gaz_rf']])))
  pcoal <- as.vector(c(0,diff(df[['coal_2pz']])))
  four_order <- f_order*2
  f_mat <- fourier(ts(log(df[['consumer_price_2']]),frequency = 365), K=f_order)
})


mod1 <- stan_model("model_0_1cz.stan")
mod0x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod0x_fit, 'model_0_2cz_m.rds')



mod1 <- stan_model("model_1_1cz.stan")
mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod1x_fit, 'model_1_2cz_m.rds')


mod1 <- stan_model("model_2_1cz.stan")
mod2x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod2x_fit, 'model_2_2cz_m.rds')



mod1 <- stan_model("model_3_1cz.stan")
mod3x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod3x_fit, 'model_3_2cz_m.rds')








mod0 <- stan_model("model_0_1cz.stan")
new_mod0 <- sampling(mod0, data = standata,  chains = 0)
mod0_fit <- readRDS('models_RDS/model_0_2cz_m.rds')
lml_0 <- bridge_sampler(mod0_fit, new_mod0)


mod1 <- stan_model("model_1_1cz.stan")
new_mod1 <- sampling(mod1, data = standata,  chains = 0)
mod1_fit <- readRDS('models_RDS/model_1_2cz_m.rds')
lml_1 <- bridge_sampler(mod1_fit, new_mod1)

mod2 <- stan_model("model_2_1cz.stan")
new_mod2 <- sampling(mod2, data = standata,  chains = 0)
mod2_fit <- readRDS('models_RDS/model_2_2cz_m.rds')
lml_2 <- bridge_sampler(mod2_fit, new_mod2)

mod3 <- stan_model("model_3_1cz.stan")
new_mod3 <- sampling(mod3, data = standata,  chains = 0)
mod3_fit <- readRDS('models_RDS/model_3_2cz_m.rds')
lml_3 <- bridge_sampler(mod3_fit, new_mod3)









df <- drop_na(df_all)

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_2']]))
  T <- length(y)
  dhdd <- as.vector(df[['dum_hdd']])
  dcdd <- as.vector(df[['dum_cdd_2']])
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  d1 <-  as.vector(df[['dum_2_1']])
  d2 <-  as.vector(df[['dum_2_2']])
  d3 <-  as.vector(df[['dum_2_3']])
  temp <- as.vector(df[['temp_ma_res_2']])
  trend <- as.vector(df[['trend']])
  dtp  <- as.vector((df[['temp_ma_res_2']]>=0)*1)
  dtn  <- as.vector((df[['temp_ma_res_2']]<0)*1)
  # hdd <- as.vector(df[['hdd_1']])
  # cdd <- as.vector(df[['cdd_1']])
  gdp <-  as.vector(c(0,diff((df[['ipp_trend']]))))
  pgas <- as.vector(c(0,diff(df[['gaz_rf']])))
  pcoal <- as.vector(c(0,diff(df[['coal_2pz']])))
  four_order <- f_order*2
  f_mat <- fourier(ts(log(df[['consumer_price_2']]),frequency = 365), K=f_order)
})




mod1 <- stan_model("model_4_2cz.stan")
mod4x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod4x_fit, 'model_4_2cz_m.rds')




mod4 <- stan_model("model_4_2cz.stan")
new_mod4 <- sampling(mod4, data = standata,  chains = 0)
mod4_fit <- readRDS('models_RDS/model_4_2cz_m.rds')
lml_4 <- bridge_sampler(mod4_fit, new_mod4)



bridgesampling::bf(lml_1,lml_0) #1
bridgesampling::bf(lml_2,lml_1) #1
bridgesampling::bf(lml_3,lml_2) #0
bridgesampling::bf(lml_4,lml_3) #0


bridgesampling::bf(lml_0,lml_1) #1
bridgesampling::bf(lml_1,lml_2) #1
bridgesampling::bf(lml_2,lml_3) #0.999
bridgesampling::bf(lml_3,lml_4) #0



############################## Model 3 #####################################

df <- drop_na(df_all)

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_1']]))
  T <- length(y)
  # trend <- as.vector(df[['trend']])
  hdd <- as.vector(df[['hdd_1']])
  cdd <- as.vector(df[['cdd_1']])
  gdp <-  as.vector(log(df[['ipp_trend']]))
  #  pgas <- as.vector(log(df[['gaz_1pz']]))
  pgas <- as.vector(log(df[['gaz_rf']]))
  pcoal <- as.vector(log(df[['coal_rf']]))
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dwin <- as.vector(df[['dum_wint']])
  dspr <- as.vector(df[['dum_spring']])
  dsum <- as.vector(df[['dum_summer']])
  daut <- as.vector(df[['dum_autumn']])
})

mod1 <- stan_model("model3_3a.stan")
mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod1x_fit, 'mod3_3a_cz1.rds')


df <- drop_na(df_all)

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_2']]))
  T <- length(y)
  # trend <- as.vector(df[['trend']])
  hdd <- as.vector(df[['hdd_2']])
  cdd <- as.vector(df[['cdd_2']])
  gdp <-  as.vector(log(df[['ipp_trend']]))
  #  pgas <- as.vector(log(df[['gaz_1pz']]))
  pgas <- as.vector(log(df[['gaz_rf']]))
  pcoal <- as.vector(log(df[['coal_rf']]))
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dwin <- as.vector(df[['dum_wint']])
  dspr <- as.vector(df[['dum_spring']])
  dsum <- as.vector(df[['dum_summer']])
  daut <- as.vector(df[['dum_autumn']])
})

# mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
# saveRDS(mod1x_fit, 'mod3_3a_cz2.rds')




############################## Model 4 #####################################

df <- drop_na(df_all)

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_1']]))
  T <- length(y)
  trend <- as.vector(df[['trend']])
  hdd <- as.vector(df[['hdd_1']])
  cdd <- as.vector(df[['cdd_1']])
  # gdp <-  as.vector(log(df[['ipp_trend']]))
  #  pgas <- as.vector(log(df[['gaz_1pz']]))
  # pgas <- as.vector(log(df[['gaz_rf']]))
  # pcoal <- as.vector(log(df[['coal_rf']]))
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dwin <- as.vector(df[['dum_wint']])
  dspr <- as.vector(df[['dum_spring']])
  dsum <- as.vector(df[['dum_summer']])
  daut <- as.vector(df[['dum_autumn']])
})

mod1 <- stan_model("model4_1a.stan")
mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod1x_fit, 'mod4_1a_cz1.rds')


df <- drop_na(df_all)

standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_2']]))
  T <- length(y)
  trend <- as.vector(df[['trend']])
  hdd <- as.vector(df[['hdd_2']])
  cdd <- as.vector(df[['cdd_2']])
  # gdp <-  as.vector(log(df[['ipp_trend']]))
  # #  pgas <- as.vector(log(df[['gaz_1pz']]))
  # pgas <- as.vector(log(df[['gaz_rf']]))
  # pcoal <- as.vector(log(df[['coal_rf']]))
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dwin <- as.vector(df[['dum_wint']])
  dspr <- as.vector(df[['dum_spring']])
  dsum <- as.vector(df[['dum_summer']])
  daut <- as.vector(df[['dum_autumn']])
})

mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
saveRDS(mod1x_fit, 'mod4_1a_cz2.rds')

############################## Model 4 (0) #####################################


df <- drop_na(df_all)

# mean(log(df[['consumer_price_1']]))
# mean(log(df[['consumer_price_2']]))

    standata <- within(list(), {
  y <- as.vector(log(df[['consumer_price_1']]))
  T <- length(y)
  trend <- as.vector(df[['trend']])
  hdd <- as.vector(df[['hdd_1']])
  cdd <- as.vector(df[['cdd_1']])
  # gdp <-  as.vector(log(df[['ipp_trend']]))
  #  pgas <- as.vector(log(df[['gaz_1pz']]))
  # pgas <- as.vector(log(df[['gaz_rf']]))
  # pcoal <- as.vector(log(df[['coal_rf']]))
  dsat <- as.vector(df[['sat_dummy']])
  dsun <- as.vector(df[['sun_dummy']])
  dmon <- as.vector(df[['mon_dummy']])
  dhol <- as.vector(df[['gov_holidays']])
  dwin <- as.vector(df[['dum_wint']])
  dspr <- as.vector(df[['dum_spring']])
  dsum <- as.vector(df[['dum_summer']])
  daut <- as.vector(df[['dum_autumn']])
})

  mod1 <- stan_model("model4_0a.stan")
  mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
  saveRDS(mod1x_fit, 'mod4_0a_cz1.rds')




  df <- drop_na(df_all)

  standata <- within(list(), {
    y <- as.vector(log(df[['consumer_price_2']]))
    T <- length(y)
    trend <- as.vector(df[['trend']])
    hdd <- as.vector(df[['hdd_2']])
    cdd <- as.vector(df[['cdd_2']])
    # gdp <-  as.vector(log(df[['ipp_trend']]))
    # #  pgas <- as.vector(log(df[['gaz_1pz']]))
    # pgas <- as.vector(log(df[['gaz_rf']]))
    # pcoal <- as.vector(log(df[['coal_rf']]))
    dsat <- as.vector(df[['sat_dummy']])
    dsun <- as.vector(df[['sun_dummy']])
    dmon <- as.vector(df[['mon_dummy']])
    dhol <- as.vector(df[['gov_holidays']])
    dwin <- as.vector(df[['dum_wint']])
    dspr <- as.vector(df[['dum_spring']])
    dsum <- as.vector(df[['dum_summer']])
    daut <- as.vector(df[['dum_autumn']])
  })

  mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
  saveRDS(mod1x_fit, 'mod4_0a_cz2.rds')












  df <- drop_na(df_all)

  mean(log(df[['consumer_price_1']]))
  mean(log(df[['consumer_price_2']]))

  standata <- within(list(), {
    y <- as.vector(log(df[['consumer_price_1']]))
    T <- length(y)
    trend <- as.vector(df[['trend']])
    hdd <- as.vector(df[['hdd_1']])
    cdd <- as.vector(df[['cdd_1']])
    # gdp <-  as.vector(log(df[['ipp_trend']]))
    #  pgas <- as.vector(log(df[['gaz_1pz']]))
    # pgas <- as.vector(log(df[['gaz_rf']]))
    # pcoal <- as.vector(log(df[['coal_rf']]))
    dsat <- as.vector(df[['sat_dummy']])
    dsun <- as.vector(df[['sun_dummy']])
    dmon <- as.vector(df[['mon_dummy']])
    dhol <- as.vector(df[['gov_holidays']])
    dwin <- as.vector(df[['dum_wint']])
    dspr <- as.vector(df[['dum_spring']])
    dsum <- as.vector(df[['dum_summer']])
    daut <- as.vector(df[['dum_autumn']])
  })

  mod1 <- stan_model("model4_1b.stan")
  mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
  saveRDS(mod1x_fit, 'mod4_1b_cz1.rds')


  df <- drop_na(df_all)

  standata <- within(list(), {
    y <- as.vector(log(df[['consumer_price_2']]))
    T <- length(y)
    trend <- as.vector(df[['trend']])
    hdd <- as.vector(df[['hdd_2']])
    cdd <- as.vector(df[['cdd_2']])
    # gdp <-  as.vector(log(df[['ipp_trend']]))
    # #  pgas <- as.vector(log(df[['gaz_1pz']]))
    # pgas <- as.vector(log(df[['gaz_rf']]))
    # pcoal <- as.vector(log(df[['coal_rf']]))
    dsat <- as.vector(df[['sat_dummy']])
    dsun <- as.vector(df[['sun_dummy']])
    dmon <- as.vector(df[['mon_dummy']])
    dhol <- as.vector(df[['gov_holidays']])
    dwin <- as.vector(df[['dum_wint']])
    dspr <- as.vector(df[['dum_spring']])
    dsum <- as.vector(df[['dum_summer']])
    daut <- as.vector(df[['dum_autumn']])
  })

  mod1x_fit <- sampling(mod1, data = standata, control = list(adapt_delta = 0.999), cores=10, iter = 5000)
  saveRDS(mod1x_fit, 'mod4_1b_cz2.rds')






