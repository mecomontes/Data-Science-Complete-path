"""
"""
import os.path
import math
import matplotlib.pyplot as plt
import numpy as np
import scipy.special as sp

plt.close("all")
np.random.seed(seed=123)

# Computes the posterior, p is a vector that contains the prior probabilities
# of the parameter being equal to lambda_1, lambda_2 or lambda_3,
# x contains the samples
# lambda_vec contains the possible value for the parameter of the exponential
def post_dist(p, x, lambda_vec):
### INSERT CODE HERE ###

    
p = np.array([0.50, 0.49, 0.01])
lambda_vec = ### INSERT VALUES HERE ###

n_short = 10
n_long = 100
x_short = np.random.exponential(scale=1/lambda_vec[2], size=n_short)
x_long = np.random.exponential(scale=1/lambda_vec[2], size=n_long)

dist_short = post_dist(p, x_short, lambda_vec)
dist_long = post_dist(p, x_long, lambda_vec)
plt.figure()
plt.xlim([0, 0.3])
markerline, stemlines, baseline = plt.stem(lambda_vec, dist_short, "--o", label="n = " + str(n_short))
plt.setp(markerline, 'markerfacecolor', 'dodgerblue')
plt.setp(stemlines, 'color','dodgerblue', 'linewidth', 1)
markerline2, stemlines2, baseline2 = plt.stem(lambda_vec, dist_long, "--o", label="n = " + str(n_long))
plt.setp(markerline2, 'markerfacecolor', 'darkred')
plt.setp(stemlines2, 'color','darkred', 'linewidth', 1)
