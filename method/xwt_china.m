function [x_t1,x_p1,x_t2,x_p2,x_t3,x_p3]=xwt_china(SN,SOI,SST,temp_d,prec_d,p,t)
%[Wxy,period,scale,coi,sig95]=xwt(SN1,temp_d,'maxscale',150,'MakeFigure',1);
SN1=[t' boxpdf(SN)];
SOI1=[t' boxpdf(SOI)];
SST1=[t' boxpdf(SST)];
temp_d1=[t' boxpdf(temp_d)];
prec_d1=[t' boxpdf(prec_d)];
for i=1:length(SN)
    if isnan(temp_d1(i,2))
        if i<3
            temp_d1(i,2)=0;
        else
            temp_d1(i,2)=temp_d1(i-1,2)-(temp_d1(i-2,2)-temp_d1(i-1,2));
        end
    end
    if isnan(prec_d1(i,2))
        if i<3
            prec_d1(i,2)=0;
        else
            prec_d1(i,2)=abs(prec_d1(i-1,2)-abs(prec_d1(i-2,2)-prec_d1(i-1,2)));
        end
    end
end
[~,period_t1,~,~,~,logpow_t1]=xwt(SN1,temp_d1,'maxscale',150);
[~,period_p1,~,~,~,logpow_p1]=xwt(SN1,prec_d1,'maxscale',150);
[~,period_t2,~,~,~,logpow_t2]=xwt(SOI1,temp_d1,'maxscale',150);
[~,period_p2,~,~,~,logpow_p2]=xwt(SOI1,prec_d1,'maxscale',150);
[~,period_t3,~,~,~,logpow_t3]=xwt(SST1,temp_d1,'maxscale',150);
[~,period_p3,~,~,~,logpow_p3]=xwt(SST1,prec_d1,'maxscale',150);
pp(1)=1;
for i=1:size(p,2)-1
    pp(i+1)=find((period_t1<=p(i+1))==1, 1, 'last' );
end
pp(end)=pp(end)+1;
for i=1:size(p,2)-1
    %--SN & T
    [~,b_t1]=max(logpow_t1(pp(i):pp(i+1),:));
    powmax_t1(i)=round(median(b_t1+pp(i)-1));
    x_t1(i)=period_t1(powmax_t1(i));
    %--SN & P
    [~,b_p1]=max(logpow_p1(pp(i):pp(i+1),:));
    powmax_p1(i)=round(median(b_p1+pp(i)-1));
    x_p1(i)=period_p1(powmax_p1(i));
    %--SOI & T
    [~,b_t2]=max(logpow_t2(pp(i):pp(i+1),:));
    powmax_t2(i)=round(median(b_t2+pp(i)-1));
    x_t2(i)=period_t2(powmax_t2(i));        
    %--SOI & P
    [~,b_p2]=max(logpow_p2(pp(i):pp(i+1),:));
    powmax_p2(i)=round(median(b_p2+pp(i)-1));
    x_p2(i)=period_p2(powmax_p2(i));        
    %--SST & T
    [~,b_t3]=max(logpow_t3(pp(i):pp(i+1),:));
    powmax_t3(i)=round(median(b_t3+pp(i)-1));
    x_t3(i)=period_t3(powmax_t3(i)); 
    %--SST & P
    [~,b_p3]=max(logpow_p3(pp(i):pp(i+1),:));
    powmax_p3(i)=round(median(b_p3+pp(i)-1));
    x_p3(i)=period_p3(powmax_p3(i));
end
