"""
"""
import os.path
import math
import matplotlib.pyplot as plt
import numpy as np

plt.close("all")
plt.rcParams['xtick.major.pad']='8'
plt.rcParams['ytick.major.pad']='8'

### CHANGE PATH TO WHEREVER YOU SAVE THE DATA FILES ### 
data = np.loadtxt(".../heights_weights.txt") 

n_train = 20000
n_test = 1000

# Randomly select training, test and validation sets
np.random.shuffle(data)
data_train = data[range(n_train),:]
data_test = data[range(n_train, n_train+n_test),:]
heights_train = data_train[:,1]
weights_train = data_train[:,2]
heights_test = data_test[:,1]
weights_test = data_test[:,2]

### INSERT CODE HERE ###
# Hint: To fit model 1 use the expression you found directly
# to fit model 2 you can use np.linalg.lstsq
pred_model_1 =
pred_model_2 = 

plt.figure(figsize=(12, 9))  
plt.plot(heights_test, weights_test, '.',  color='skyblue',markeredgecolor='blue')
plt.plot(heights_test, pred_model_1,  c="red")

plt.figure(figsize=(12, 9))  
plt.plot(heights_test, weights_test, '.', color='skyblue',markeredgecolor='blue')
plt.plot(heights_test, pred_model_2, c="red")

error_1 = np.sum(np.abs((pred_model_1 - weights_test)/weights_test))/n_test
error_2 = np.sum(np.abs((pred_model_2 - weights_test)/weights_test))/n_test

print "Model 1 relative error: " + str(error_1)
print "Model 2 relative error: " + str(error_2)
