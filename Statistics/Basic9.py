# -*- coding: utf-8 -*-
"""
"""
import os.path
import math
import matplotlib.pyplot as plt
import numpy as np
plt.close("all")


def derivative_descent(x_ini, der_f, step, eps):
### INSERT CODE HERE ###


def newton_method(x_ini, der_f, der2_f, eps):
### INSERT CODE HERE ###    
    
def quadratic_approx(x, point, f, df, d2f):
### INSERT CODE HERE ###


def trajectory(x,f):
    n = len(x)
    res = np.zeros((2, n*2 - 1))
    for i in range(n-1):
        res[0, 2*i] = x[i]
        res[0, 2*i+1] = x[i+1]
        res[1, 2*i:(2*i+2)] = f(x[i])
    res[0,2*n-2] = x[-1]
    res[1,2*n-2] = f(x[-1])
    return res
    
x_min = -2.
x_max = 2.
x = np.arange(x_min,x_max,1e-2)
f =lambda y: (1-np.exp(-y)) * y 
df =lambda y: (1-np.exp(-y)) + y * np.exp(-y)
d2f =lambda y: (2 -y) * np.exp(-y)

eps=1e-2
step = 0.2
x_ini = -1.8
sol_der_desc = derivative_descent(x_ini, f, df, step, eps)
plt.figure(figsize=(12, 9))  
plt.plot(x,f(x),lw=3)
traj = trajectory(sol_der_desc,f)
plt.plot(sol_der_desc, f(sol_der_desc), 'o', c="darkred",lw=3, markersize=10)
plt.plot(traj[0,:],traj[1,:],'--',c='darkred',lw=3)

step = 0.05
x_ini = -1.8
sol_der_desc = derivative_descent(x_ini, df, step, eps)
plt.figure(figsize=(12, 9))  
plt.plot(x,f(x),lw=3)
traj = trajectory(sol_der_desc,f)
plt.plot(sol_der_desc, f(sol_der_desc), 'o', c="darkred",lw=3, markersize=10)
plt.plot(traj[0,:],traj[1,:],'--',c='darkred',lw=3)

newton_sol = newton_method(x_ini, df, d2f, eps)
plt.figure(figsize=(12, 9))  
plt.plot(x,f(x),lw=3)
traj = trajectory(newton_sol,f)
plt.plot(newton_sol, f(newton_sol), 'o', c="darkred",lw=3, markersize=10)
plt.plot(traj[0,:],traj[1,:],'--',c='darkred',lw=3)
plt.ylim([-0.5,12])

plt.figure(figsize=(12, 9))  
plt.plot(x,f(x),lw=3)
traj = trajectory(newton_sol,f)
plt.plot(newton_sol, f(newton_sol), 'o', c="darkred",lw=3, markersize=10)
plt.plot(traj[0,:],traj[1,:],'--',c='darkred',lw=3)
plt.ylim([-0.5,12])
plt.plot(x,quadratic_approx(x, newton_sol[0], f, df, d2f), "--",c="red",lw=3,label="Quadratic approximation")
for i in range(1,4):
    plt.plot(x,quadratic_approx(x, newton_sol[i], f, df, d2f), "--",c="red",lw=3)
plt.ylim([-0.5,12])
plt.legend(fontsize=20,loc="upper right")
