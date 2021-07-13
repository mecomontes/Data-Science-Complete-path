"""
DS GA 1002 Homework 4 Problem 2
"""
import os.path
import math
import matplotlib.pyplot as plt
import numpy as np

plt.close("all")

# Load data
### CHANGE PATH TO WHEREVER YOU SAVE THE DATA FILES ### 
data_2_days = np.loadtxt(".../call_center_data_2_days.txt") 
data_september = np.loadtxt(".../call_center_data_september.txt") 
data_october = np.loadtxt(".../call_center_data_october.txt") 

# Function to estimate the parameters of a Poisson r.v. from iid data
def poisson_ml_estimator(data):
### INSERT CODE HERE ###


# Function to estimate the empirical pmf from iid data
def empirical_pmf(data):
### INSERT CODE HERE ###


# Function to compute pmf of Poisson with parameter param at x 
def poisson_pmf(param, x):
### INSERT CODE HERE ###
    

# Function to compute pmf of Poisson with parameter param for values between 0 and n 
def poisson_pmf_vec(param, n):
    pmf = np.zeros(n+1)
    for i in range(len(pmf)):
        pmf[i] = poisson_pmf(param, i)
    return pmf
    

# Function to compute error between two pdfs
def error(x, y):
    err = 0.0
    for i in range(max(len(x), len(y))):
        if len(y) <= i:
           err += np.abs(x[i])
        elif len(x) <= i:
           err += np.abs(y[i])
        else:
           err += np.abs(x[i] - y[i])
    return err

# Pmf of October data
pmf_october = empirical_pmf(data_october)

# Maximum likelihood estimation
lambda_2_days = poisson_ml_estimator(data_2_days)
lambda_september = poisson_ml_estimator(data_september)
n = len(pmf_october) + 5 
pmf_2_days_ml = poisson_pmf_vec(lambda_2_days, n)
pmf_september_ml = poisson_pmf_vec(lambda_september, n)
plt.figure(figsize=(14, 7))
ax = plt.subplot(111)    
plot1 = plt.plot(range(n+1), pmf_2_days_ml, lw=1, ls="dashed", markeredgewidth = 0, color = 'skyblue',
                 marker="o", markersize=8, markerfacecolor = 'skyblue', label='2 days')
plot2 = plt.plot(range(n+1), pmf_september_ml, lw=1, ls="dashed", markeredgewidth = 0,
                 marker="o", markersize=8, markerfacecolor = 'green', label='September')
plot3 = plt.plot(range(len(pmf_october)), pmf_october, lw=1, ls="dashed", markeredgewidth = 0,color = 'darkred',
                 marker="o", markersize=8, markerfacecolor = 'darkred', label='October')
plt.legend()

pmf_2_days_emp = empirical_pmf(data_2_days)
pmf_september_emp = empirical_pmf(data_september)
plt.figure(figsize=(14, 7))
plot1 = plt.plot(range(len(pmf_2_days_emp)), pmf_2_days_emp, lw=1, ls="dashed", markeredgewidth = 0,color = 'skyblue',
                 marker="o", markersize=8, markerfacecolor = 'skyblue', label='2 days')
plot2 = plt.plot(range(len(pmf_september_emp)), pmf_september_emp, lw=1, ls="dashed", markeredgewidth = 0,
                 marker="o", markersize=8, markerfacecolor = 'green', label='September')
plot3 = plt.plot(range(len(pmf_october)), pmf_october, lw=1, ls="dashed", markeredgewidth = 0,color = 'darkred',
                 marker="o", markersize=8, markerfacecolor = 'darkred', label='October')
plt.legend()

print "ML fitting errors"
print "2 days: " + str(error(pmf_2_days_ml, pmf_october)) 
print "September: " + str(error(pmf_september_ml, pmf_october)) 

print "Nonparametric fitting errors"
print "2 days: " + str(error(pmf_2_days_emp, pmf_october)) 
print "September: " + str(error(pmf_september_emp, pmf_october)) 
