"""
DS GA 1002 Homework 4 Problem 2
"""
import os.path
import math
import matplotlib.pyplot as plt
import numpy as np

plt.close("all")

# Load data
### CHANGE PATH TO WHEREVER YOU SAVE THE WEIGHTS FILE ### 
weights = np.loadtxt("weights.txt") 

# True mean
mean_weight = np.mean(weights)

# Function to compute sample variance from a sample
def compute_sample_variance(x):
    x_mean = np.mean(x)
    x_var = np.sum(np.power(x_mean - x, 2)) / (len(x) - 1)
    return x_var, x_mean

# Compute approximate confidence interval, returns the lower and upper limit 
# of the interval l and u as a list [l,u]
def approximate_confidence_interval(x):
    x_var, x_mean = compute_sample_variance(x)
    upper_lim = x_mean + x_var/(0.05 * len(x)) ** 0.5
    lower_lim = x_mean - x_var/(0.05 * len(x)) ** 0.5
    return lower_lim, upper_lim
    
    
# Plot confidence intervals for different values of n
n_val = [20, 1000]
n_tries = 100
for n in n_val:
    conf_interval_list = []
    outside = 0
    for i in range(n_tries):
        # Uniform sampling with replacement
        random_ind = np.random.choice(weights.size, n, replace=True)
        conf_interval = approximate_confidence_interval(weights[random_ind])
        conf_interval_list.append(conf_interval)
        if conf_interval[0] > mean_weight or conf_interval[1] < mean_weight:
            outside += 1
    plt.figure(n, figsize=(14, 7))
    ax = plt.subplot(111)    
    ax.axes.get_xaxis().set_visible(False)
    ax.axes.get_yaxis().set_visible(False)    
    plt.plot(mean_weight, 0, color = 'red', lw=2, label='True mean') 
    plt.plot([mean_weight, mean_weight], [0, n_tries-1], color = 'red', lw=2) 
    for i in range(n_tries):
      plt.plot(conf_interval_list[i],[i, i] , color = 'blue', lw=2)
    plt.legend(fontsize=20)
    plt.title(str(outside) + " intervals out of 100 don't contain the true mean")
    
n_tries = 10000
for n in n_val:
    outside = 0
    for i in range(n_tries):
        # Uniform sampling with replacement
        random_ind = np.random.choice(weights.size, n, replace=True)
        conf_interval = approximate_confidence_interval(weights[random_ind])
        if conf_interval[0] > mean_weight or conf_interval[1] < mean_weight:
            outside += 1
    print("n = " + str(n))
    print(str(outside) + " intervals out of 10000 don't contain the true mean")
    
# Print distribution of sample variance for n = 20 and n = 1000
sample_var_list = []
for i_n in range(len(n_val)):
    n = n_val[i_n]
    sample_var_list.append([])
    for i in range(n_tries):  
        random_ind = np.random.choice(weights.size, n, replace=True)
        sample_var_list[i_n].append(compute_sample_variance(weights[random_ind]))
plt.figure(n+1, figsize=(14, 7))
ax = plt.subplot(111)    
plt.title("Distribution of sample variance")
plt.hist(sample_var_list[0],50,normed=True,edgecolor = "none", color="skyblue", 
         label="n = 20")
plt.hist(sample_var_list[1],50,normed=True,edgecolor = "none", color="green", 
         label="n = 1000")  
