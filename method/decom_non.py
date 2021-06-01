import scipy.io as scio
import pandas as pd
import numpy as np
from statsmodels.tsa.seasonal import seasonal_decompose
path=r'F:\t.mat'
temp=scio.loadmat(path)
a = temp['temp_d'][0]
#print(a)
#print(a.shape)
dates = pd.date_range('19000101','20171231', freq='1M')   
result = []      
for i in a:
#    b = pd.DataFrame(a[0,i])
##    print(b)
#    b1=pd.DataFrame(b.values[:,1])
#    print(i)
#    c = pd.DataFrame(b1,index=dates,columns=list('A'))
    c = pd.DataFrame(i.T[0], index=dates)
    decomposition = seasonal_decompose(c)  #timeseries时间序列数据
#    t_trend = decomposition.trend
#    t_seasonal = decomposition.seasonal
#    t_residual = decomposition.resid
    result.append([decomposition.trend.values,decomposition.seasonal.values,decomposition.resid.values])
    
#result1 = np.array(result).reshape(1727,1416,3)
dataNew = 'F://t_dec.mat' 
scio.savemat(dataNew,{"t_dec":result})


path=r'F:\p.mat'
prec=scio.loadmat(path)
a = prec['prec_d'][0]
dates = pd.date_range('19000101','20171231', freq='1M')   
result = []      
for i in a:
    c = pd.DataFrame(i.T[0], index=dates)
    decomposition = seasonal_decompose(c)  #timeseries时间序列数据
#    t_trend = decomposition.trend
#    t_seasonal = decomposition.seasonal
#    t_residual = decomposition.resid
    result.append([decomposition.trend.values,decomposition.seasonal.values,decomposition.resid.values])
#result1 = np.array(result).reshape(1727,1416,3)
dataNew = 'F://p_dec.mat' 
scio.savemat(dataNew,{"p_dec":result})