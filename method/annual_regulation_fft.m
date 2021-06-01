function [ar_t,ar_p]=annual_regulation_fft(temp1,prec1,p)
% wave_t=real(fft(temp1(:,2)));
% wave_p=real(fft(prec1(:,2)));
% t1=(0:1/12:1/12*1415)';
% w_t=[t1 wave_t];
% w_p=[t1 wave_p];
% temp1=temp_d{i};
% prec1=prec_d{i};
%%
temp3=fillmissing(temp1,'movmedian',10);
prec3=fillmissing(prec1,'movmedian',10);
t1=0:117;
for i=1:118
   temp2(i)=mean(temp3(1+(i-1)*12:12+(i-1)*12,2)); 
   prec2(i)=mean(prec3(1+(i-1)*12:12+(i-1)*12,2));
end
wave_t=real(fft(temp2));
wave_p=real(fft(prec2));
w_t=[t1' wave_t'];
w_p=[t1' wave_p'];
pp=p+1;
pp(1)=1;
pp(end)=length(t1);
%%
% pp(1)=1;
% for i=1:size(p,2)-1
%     pp(i+1)=find((t1<=p(i+1))==1, 1, 'last' );
% end
% pp(end)=size(t1,1);
for i=1:size(p,2)-1
    dm_t(i)=max(abs(w_t(pp(i)+1:pp(i+1),2)));
    [a,~]=find(dm_t(i)==abs(w_t(pp(i):pp(i+1),2)));
    ar_t(i)=w_t(a(end)+pp(i)-1,1);
    dm_p(i)=max(abs(w_p(pp(i)+1:pp(i+1),2)));
    [b,~]=find(dm_p(i)==abs(w_p(pp(i):pp(i+1),2)));
    ar_p(i)=w_p(b(end)+pp(i)-1,1);
end
