import os.path
import math
import matplotlib.pyplot as plt
import numpy as np

plt.close("all")
plt.rcParams['xtick.major.pad']='8'
plt.rcParams['ytick.major.pad']='8'

### CHANGE PATH TO WHEREVER YOU SAVE THE DATA FILES ### 
dataset = np.loadtxt(".../oxford_temperatures.txt")
max_temp = np.array(dataset[:,2])
min_temp = np.array(dataset[:,3])
year = np.array(dataset[:,0])
n = len(max_temp)
### INSERT CODE HERE ### 
# Suggestion: Use np.linalg.lstsq to solve the least-squares problem.
reconstruction_max =
reconstruction_min = 
trend_max =  
trend_min =  

ini_ticks = (1860 - 1853) * 12
end_ticks = (2014 - 1853) * 12
step_ticks = 20 * 12
label_ticks = range(1860,2020,20)

ind_1900 = (1900 - 1853) * 12
ind_1960 = (1960 - 1853) * 12
dur = 5
indices_1900 = range(ind_1900,ind_1900+dur*12+1)
indices_1960 = range(ind_1960,ind_1960+dur*12+1)

plt.figure(figsize=(12, 9))  
plt.plot(max_temp,"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(reconstruction_max,color='darkred',label='Model')
plt.xticks(np.arange(ini_ticks, end_ticks, step_ticks),label_ticks, rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.xlim([-50,n+50])
plt.ylim([-4,30])
plt.savefig("temp_data_model_max.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(max_temp,"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.xticks(np.arange(ini_ticks, end_ticks, step_ticks),label_ticks, rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.xlim([-50,n+50])
plt.ylim([-4,30])
plt.savefig("temp_data_max.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(max_temp[indices_1900],"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(reconstruction_max[indices_1900],color='darkred',label='Model')
plt.xticks(range(0, dur*12+1, 12),np.arange(1900, 1900+dur+1, 1), rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.savefig("temp_data_model_max_1900.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(max_temp[indices_1900],"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.xticks(range(0, dur*12+1, 12),np.arange(1900, 1900+dur+1, 1), rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.savefig("temp_data_max_1900.pdf")


plt.figure(figsize=(12, 9))  
plt.plot(max_temp[indices_1960],"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(reconstruction_max[indices_1960],color='darkred',label='Model')
plt.xticks(range(0, dur*12+1, 12),np.arange(1960, 1960+dur+1, 1), rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.savefig("temp_data_model_max_1960.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(max_temp,"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(trend_max,color='darkred',label='Trend')
plt.xticks(np.arange(ini_ticks, end_ticks, step_ticks),label_ticks, rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.xlim([-50,n+50])
plt.ylim([-4,30])
plt.savefig("temp_data_trend_max.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(min_temp,"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(reconstruction_min,'darkred',label='Model')
plt.xticks(np.arange(ini_ticks, end_ticks, step_ticks),label_ticks, rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.xlim([-50,n+50])
plt.savefig("temp_data_model_min.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(min_temp[indices_1900],"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(reconstruction_min[indices_1900],color='darkred',label='Model')
plt.xticks(range(0, dur*12+1, 12),np.arange(1900, 1900+dur+1, 1), rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.savefig("temp_data_model_min_1900.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(min_temp[indices_1960],"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(reconstruction_min[indices_1960],color='darkred',label='Model')
plt.xticks(range(0, dur*12+1, 12),np.arange(1960, 1960+dur+1, 1), rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.savefig("temp_data_model_min_1960.pdf")

plt.figure(figsize=(12, 9))  
plt.plot(min_temp,"--o",color='skyblue',markeredgecolor='skyblue',label='Data')
plt.plot(trend_min,color='darkred',label='Trend')
plt.xticks(np.arange(ini_ticks, end_ticks, step_ticks),label_ticks, rotation='horizontal')
plt.ylabel("Temperature (Celsius)", fontsize=20)  
plt.legend(fontsize=20,loc='lower right')
plt.xticks(fontsize=20) 
plt.yticks(fontsize=20) 
plt.xlim([-50,n+50])
plt.savefig("temp_data_trend_min.pdf")
