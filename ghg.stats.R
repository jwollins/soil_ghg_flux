

#___________________________________________________________####
# WD ####

setwd(rstudioapi::getActiveProject())

getwd()


#___________________________________________________________####
# LOAD DATA ####


dat <- read.csv(file = "data/processed.data/gc.data.all.days.csv")
mean.dat <- read.csv(file = "data/processed.data/mean.flux.data.csv")
soil.dat <- read.csv("data/sampling.point.data/ghg.sampling.points.wgs84.csv") # source data load
cosmos.dat <- read.csv(file = "data/COSMOS/cosmos.dat.csv")






#___________________________________________________________####
# Functions ####


source(file = "functions/fun_distribution_plots.R")

source(file = "functions/fun_glm_diagnostic_plots.R")




#___________________________________________________________####
# Intro stats ####

# filter to Treatment 
ca.dat <-  dplyr::filter(mean.dat, Treatment == "Conservation")
con.dat <- dplyr::filter(mean.dat, Treatment == "Conventional")




# ~ CO2 ####

# max fluxes
max(con.dat$mean.co2.g.m3.h)
max(ca.dat$mean.co2.g.m3.h)
# min fluxes
min(con.dat$mean.co2.g.m3.h)
min(ca.dat$mean.co2.g.m3.h)
# mean fluxes
mean(con.dat$mean.co2.g.m3.h)
mean(ca.dat$mean.co2.g.m3.h)

# max cumulative
max(con.dat$cumsum.co2.g.m3.h)
max(ca.dat$cumsum.co2.g.m3.h)





# ~ N2O ####

# max fluxes
max(con.dat$mean.n2o.mg.m3.h)
max(ca.dat$mean.n2o.mg.m3.h)
# min fluxes
min(con.dat$mean.n2o.mg.m3.h)
min(ca.dat$mean.n2o.mg.m3.h)
# mean fluxes
mean(con.dat$mean.n2o.mg.m3.h)
mean(ca.dat$mean.n2o.mg.m3.h)

# max cumulative
max(con.dat$cumsum.n2o.mg.m3.h)
max(ca.dat$cumsum.n2o.mg.m3.h)




# ~ CH4 ####


# max fluxes
max(con.dat$mean.ch4.mg.m3.h)
max(ca.dat$mean.ch4.mg.m3.h)
# min fluxes
min(con.dat$mean.ch4.mg.m3.h)
min(ca.dat$mean.ch4.mg.m3.h)
# mean fluxes
mean(con.dat$mean.ch4.mg.m3.h)
mean(ca.dat$mean.ch4.mg.m3.h)

# max cumulative
min(con.dat$cumsum.ch4.mg.m3.h)
min(ca.dat$cumsum.ch4.mg.m3.h)




# ~ GWP ####

# max flux
max(con.dat$gwp.mean.mg.m3.h / 1000)
min(con.dat$gwp.mean.mg.m3.h /1000)







#___________________####
# Soil Data ####



# ~ sand ####
max(soil.dat$Sand)
min(soil.dat$Sand)


# ~ clay ####
max(soil.dat$Clay)
min(soil.dat$Clay)


# ~ silt ####
max(soil.dat$Silt)
min(soil.dat$Silt)


# ~ SOC ####
min(soil.dat$som)
max(soil.dat$som)


# ~ BD ####
min(soil.dat$bulk.densi)
max(soil.dat$bulk.densi)


# ~ pH ####
min(soil.dat$pH)
max(soil.dat$pH)


# ~ P ####
min(soil.dat$P)
max(soil.dat$P)


# ~ K ####
min(soil.dat$K)
max(soil.dat$K)


# ~ temperature ####
min(cosmos.dat$STP.03.Soil.Temperature.at.10cm)
max(cosmos.dat$STP.03.Soil.Temperature.at.10cm)


# ~ moisture ####
min(cosmos.dat$TDT.01...Volumetric.Water.Content.at.10cm)
max(cosmos.dat$TDT.01...Volumetric.Water.Content.at.10cm)









#___________________________________________________________####
# mixed models ####





# Mixed effects model

# ~ CO2 ####

distribution_plots(data = dat, variable = dat$co2.g.m3.h, colour = dat$co2.g.m3.h)

ggsave(filename = "plots/distributions/dist_co2_g_m3_h.png", width = 10, height = 2.25)



shapiro.test(x = dat$co2.g.m3.h)


c <- lmer(log(co2.g.m3.h) ~ factor(Treatment) + 
            # N.kg.ha + soil.temp + soil.moist + 
            (1 | batch.date) + (1 | block), data = dat)
summary(c)
anova(c)


diagnostic_plots_glm(model = c)


ggsave(filename = "plots/model_diagnostics/model_diag_co2_g_m3_h.png", 
       width = 10, height = 3.5)




# CO2 ~ other variables

c <- lmer(log(co2.g.m3.h) ~ N.kg.ha + soil.temp + soil.moist +
            (1 | batch.date) + (1 | block), data = dat)

summary(c)









# ~ N2O ####




distribution_plots(data = dat, variable = dat$n2o.mg.m3.h, colour = dat$n2o.mg.m3.h)

ggsave(filename = "plots/distributions/dist_n2o_mg_m3_h.png", width = 10, height = 2.25)

n <- lmer(log(n2o.mg.m3.h) ~ factor(Treatment) +
            (1 | batch.date) + (1 | block), data = dat)

summary(n)

diagnostic_plots_glm(model = n)

ggsave(filename = "plots/model_diagnostics/model_diag_n2o_mg_m3_h.png", 
       width = 10, height = 3.5)







# N2O ~ other variables

n <- lmer(log(n2o.mg.m3.h) ~ N.kg.ha + soil.temp + soil.moist +
            (1 | batch.date) + (1 | block), data = dat)

summary(n)










# ~ CH4 ####

distribution_plots(data = dat, variable = dat$ch4.mg.m3.h, colour = dat$ch4.mg.m3.h)

ggsave(filename = "plots/distributions/dist_ch4_mg_m3_h.png", width = 10, height = 2.25)


ch <- lmer(ch4.mg.m3.h ~ factor(Treatment)  +
             (1 | batch.date) + (1 | block), data = dat)
summary(ch)
anova(ch)

diagnostic_plots_glm(model = ch)

ggsave(filename = "plots/model_diagnostics/model_diag_ch4_mg_m3_h.png", 
       width = 10, height = 3.5)



# CH4 ~ other variables

ch <- lmer(log(ch4.mg.m3.h) ~ N.kg.ha + soil.temp + soil.moist +
            (1 | batch.date) + (1 | block), data = dat)

summary(ch)








# ~ GWP ####

distribution_plots(data = dat, 
                   variable = dat$gwp.total, 
                   colour = dat$gwp.total)

ggsave(filename = "plots/distributions/dist_gwp.png", width = 10, height = 2.25)


gwp <- lmer(dat$gwp.total ~ factor(Treatment) + 
              # N.kg.ha + soil.temp + soil.moist + 
              (1 | batch.date) + (1 | block), data = dat)
summary(gwp)

diagnostic_plots_glm(model = gwp)

ggsave(filename = "plots/model_diagnostics/model_diag_gwp.png", 
       width = 10, height = 3.5)




gwp <- lmer(dat$gwp.total ~ N.kg.ha + soil.temp + soil.moist + 
              (1 | batch.date) + (1 | block), data = dat)
summary(gwp)




# ~ yield scaled GWP ####

distribution_plots(data = dat, 
                   variable = dat$ys.gwp.total, 
                   colour = dat$ys.gwp.total)

ggsave(filename = "plots/distributions/dist_gwp_yield_scaled.png", width = 10, height = 2.25)


ys <- lmer(dat$ys.gwp.total ~ factor(Treatment) + 
            # N.kg.ha + soil.temp + soil.moist + 
            (1 | batch.date) + (1 | block), data = dat)
summary(ys)

diagnostic_plots_glm(model = ys)

ggsave(filename = "plots/model_diagnostics/model_diag_gwp_ys.png", 
       width = 10, height = 3.5)


ca.gwp.sum <- sum(ca.dat$ys.gwp.total /1000000)
con.dat.sum <- sum(con.dat$ys.gwp.total /1000000)





#### GLM ####

# run glm with 
glm <- glm(ys.gwp.total ~ factor(Treatment),
           data = dat)

summary(glm) 
anova(glm) 


glm <- glm(ys.gwp.n2o ~ factor(Treatment),
           data = dat)

summary(glm)

mean.filt <- filter(mean.dat, batch.date == "2023-07-28")

glm <- glm(n2o.mg.m3.h ~ factor(Treatment),
           data = mean.filt)

summary(glm)







c <- lmer(co2.g.m3.h ~ factor(Treatment) +
            N.kg.ha + soil.temp + soil.moist +
            (1 | batch.date) + (1 | block), data = dat)



# Find the smallest nonzero value in the dataset
small_const <- min(dat$co2.g.m3.h[dat$co2.g.m3.h > 0]) * 5  # 1% of the smallest value

# Add this small constant to avoid zeros
dat$co2.g.m3.h_adj <- dat$co2.g.m3.h + small_const

# Fit the GLMM model
glm_model <- glmer(co2.g.m3.h_adj ~ factor(Treatment) +
                     N.kg.ha + soil.temp + soil.moist +
                     (1 | batch.date) + (1 | block),
                   data = dat,
                   family = Gamma(link = "inverse"))






