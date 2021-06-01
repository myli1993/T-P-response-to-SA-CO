function [hangle]=sunshade_china(year,month,day,time,latitude)
monthdays=[31 28 31 30 31 30 31 31 30 31 30 31];
latitude=deg2rad(latitude);
for i=1:month-1
    day=day+monthdays(i);%积日
end
N0=79.6764+0.2422*(year-1985)-floor((year-1985)/4);%floor是向下取整函数
sunangle=2*pi*(day-N0)/365.2422;%日角
degangle=0.3723+23.2567*sin(sunangle)+0.1149*sin(2*sunangle)-0.1712*sin(3*sunangle)-0.758*cos(sunangle)+0.3656*cos(2*sunangle)+0.0201*cos(3*sunangle);%太阳赤纬
degangle=deg2rad(degangle);%角度转弧度
timeangle=deg2rad((time-12)*15);%时角
hangle=asin(sin(latitude)*sin(degangle)+cos(latitude)*cos(degangle)*cos(timeangle));
hangle=rad2deg(hangle);
end