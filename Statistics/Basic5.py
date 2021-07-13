import numpy as np
import matplotlib.pyplot as plt
import os.path

plt.close("all")
### CHANGE PATH TO WHEREVER YOU SAVE THE DATA FILES ### 
data = np.load(".../heart_disease_data.npz") 


# Function that outputs the position of x that contain val
def ind_x_eq_val(x, val):
    return np.where(x==val)[0]


# Function that counts the number of entries equal to val in x
def count_x_eq_val(x, val):
    return len(ind_x_eq_val(x, val))/float(len(x))
    

# Function that computes a Gaussian pdf with mean mu and std sig at the values in x
def gaussian(x, mu, sig):
    return np.exp(-np.power(x - mu, 2.) / (2 * np.power(sig, 2.))) / sig / np.sqrt(2 * np.pi)


# Estimate the pmf of H
P_H0 = ### INSERT CODE HERE ###
P_H1 = ### INSERT CODE HERE ###

# Estimate the conditional pmf of S given H
P_S_H0 = np.zeros(2)
P_S_H1 = np.zeros(2)
for ind_S in range(2):
    P_S_H0[ind_S] = ### INSERT CODE HERE ### 
    P_S_H1[ind_S] = ### INSERT CODE HERE ### 

# Estimate the conditional pmf of C given H
P_C_H0 = np.zeros(4)
P_C_H1 = np.zeros(4)
for ind_C in range(4):
    P_C_H0[ind_C] = ### INSERT CODE HERE ###
    P_C_H1[ind_C] = ### INSERT CODE HERE ###

# MAP estimate
MAP_estimate_S_C = ### INSERT CODE HERE ###
error_rate_S_C = ### INSERT CODE HERE ###

print "Probability of error " + str(error_rate_S_C)

## Estimate conditional pdf of X given H
mean_X_H = np.zeros(2)
std_X_H = np.zeros(2)
mean_X_H[0]= ### INSERT CODE HERE ###
std_X_H[0] = ### INSERT CODE HERE ###
mean_X_H[1]= ### INSERT CODE HERE ###
std_X_H[1] = ### INSERT CODE HERE ###

n_plot = 100
for i in range(2):
    plt.figure(figsize=(12, 9))  
    ax = plt.subplot(111)    
    ax.spines["top"].set_visible(False)    
    ax.spines["right"].set_visible(False)    
    ax.get_xaxis().tick_bottom()  
    ax.get_yaxis().tick_left() 
    yticks = ax.yaxis.get_major_ticks()
    yticks[0].label1.set_visible(False) 
    plt.xticks(fontsize=22) 
    plt.yticks(fontsize=22) 
    plt.xlabel("Cholesterol", fontsize=22)  
    plt.hist(### INSERT CODE HERE ###,
             60,normed=True,edgecolor = "none", color="skyblue")
    plt.plot(np.linspace(50, 450, n_plot),gaussian(np.linspace(50, 450, n_plot), 
                     mean_X_H[i], std_X_H[i]), color="darkred", lw=2)
                 

# MAP estimate
MAP_estimate_S_C_X = ### INSERT CODE HERE ###
error_rate_S_C_X = ### INSERT CODE HERE ###
print "Probability of error using cholesterol " + str(error_rate_S_C_X)

