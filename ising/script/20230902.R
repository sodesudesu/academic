#2nd September 2023
#first trial making Ising model simulation

library(ggplot2)
library(gganimate)

#clear screen
rm(list = ls())

#格子の長さ(要設定)
N = 500
A = N*N

#constant
H = 0 #magnetic field
J = 10^{-21} #exchange interaction constant
T = 50 #absolute temperature(K)
k = 1.380649 * 10^{-23} #Boltzmann  constant

#order parameter C
#C = exp(2 * J / (k * T))
C = 100 + sqrt(2)

#the number of frames
t = 1000000

#initial state (random numbers)
spin = matrix(sample(size = A, x = c(-1,1), replace = T), N, N)
#spin = matrix(sample(size = A, x = c(-1,1), replace = T), N, N)

#covert to data frame
df_spin = data.frame(
  i_y = rep(1:N, times = N), 
  i_x = rep(1:N, each = N), 
  spin = as.vector(spin), 
  label = as.factor(paste0("iter:", 0, ", rate:", sum(spin) / N^2))
)

#heat map at initial state
ggplot(df_spin, aes(x = i_x, y = i_y, fill = spin)) +
  geom_tile() +
  xlab("") +
  ylab("") +
  scale_fill_gradient(low = "white", high = "black") +
  theme_bw() +
  coord_fixed(ratio = 1) +
  theme(legend.position = "none")

#chose a point 0 in a random manner
random_x = as.integer(runif(t, min = 1, max = N + 1)) #x coordinate
random_y = as.integer(runif(t, min = 1, max = N + 1)) #y coordinate
random_prob = runif(t) #random number between zero and one

#probability (up)
prob_up = function(sum_spin){
  y = 1 / (1 + C^sum_spin )
  return(y)
}

#simulate
for(i in 1:t){
  #boundary condition
  if(random_x[i] == 1){
    random_x_exc1 = N + 1
  }else{
    random_x_exc1 = random_x[i]
  }
  if(random_y[i] == 1){
    random_y_exc1 = N + 1
  }else{
    random_y_exc1 = random_y[i]
  }
  if(random_x[i] == N){
    random_x_exc2 = 0
  }else{
    random_x_exc2 = random_x[i]
  }
  if(random_y[i] == N){
    random_y_exc2 = 0
  }else{
    random_y_exc2= random_y[i]
  }
  
  #sum four spin variables around point o
  sum_S = - spin[random_x_exc1 - 1, random_y[i]] - spin[random_x_exc2 + 1, random_y[i]] - spin[random_x[i], random_y_exc1 - 1] - spin[random_x[i], random_y_exc2 + 1]
  
  #replace S_0
  if(random_prob[i] < prob_up(sum_S)){
    spin[random_x[i], random_y[i]] = 1
  }
  else{
    spin[random_x[i], random_y[i]] = -1
  }
}

#covert to data frame
df_spin = data.frame(
  i_y = rep(1:N, times = N), 
  i_x = rep(1:N, each = N), 
  spin = as.vector(spin), 
  label = as.factor(paste0("iter:", 0, ", rate:", sum(spin) / N^2))
)

#heat map at final state
ggplot(df_spin, aes(x = i_x, y = i_y, fill = spin)) +
  geom_tile() +
  xlab("") +
  ylab("") +
  scale_fill_gradient(low = "white", high = "black") +
  theme_bw() +
  coord_fixed(ratio = 1) +
  theme(legend.position = "none")