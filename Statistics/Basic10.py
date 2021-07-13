# -*- coding: utf-8 -*-
"""
"""
import os.path
import math
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import axes3d
import numpy as np
plt.close("all")


def projected_gradient_descent(x_ini, f, grad, step, eps, proj, n_iter):
### INSERT CODE HERE ###


def projection_positive(x):
### INSERT CODE HERE ###


def projection_l2(x):
### INSERT CODE HERE ###

A = np.array([[1.,0.5],[0.5,3.]])/10.
c = np.array([-2.,-2.])
def quad(A, x):
    return A[0,0]*((x[0]-c[0]) ** 2)/2 + A[0,1]*((x[0]-c[0]) *(x[1]-c[1])) + A[1,1]*((x[1]-c[1]) ** 2)/2
    
def quad_grad(A, x):
    return np.dot(A,x-c)
    
f =lambda y: quad(A,y)
df =lambda y: quad_grad(A,y)
d2f =lambda y: A

eps = 1e-2
xmesh, ymesh = np.mgrid[-4:4:50j,-4:4:50j]
fmesh_pos = quad(A, np.array([xmesh, ymesh]))

step = 1
n_iter= 10
x_ini = np.array([3.,3.])
sol_grad_proj_pos = projected_gradient_descent(x_ini, f, df, step, eps,projection_positive, n_iter)
x_ini = np.array([0.5,0.5])
sol_grad_l2 = projected_gradient_descent(x_ini, f, df, step, eps, projection_l2, n_iter)

plt.figure()
ax = plt.axes()
plt.axis("equal")
plt.contour(xmesh, ymesh, fmesh_pos, 50)
plt.plot([0,0], [0,4],lw=2 ,c='red')
plt.plot([0,4], [0,0],lw=2 ,c='red')
plt.plot(sol_grad_proj_pos[:,0], sol_grad_proj_pos[:,1], "--o",c='darkred', lw=2,markersize=10)

plt.figure()
ax = plt.axes()
plt.axis("equal")
plt.contour(xmesh, ymesh, fmesh_pos, 50)
plt.plot(np.cos(np.arange(0,10,1e-2)),np.sin(np.arange(0,10,1e-2)),lw=2 ,c='red')
plt.plot(sol_grad_l2[:,0], sol_grad_l2[:,1], "--o",c='darkred', lw=2,markersize=10)


