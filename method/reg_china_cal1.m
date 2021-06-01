function output=reg_china_cal1(total_t,total_p,group,period)
para=[1;1;1;1;1;1;1;1;1;1];
options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
for i=1:period
    t1=total_t{i};
    p1=total_p{i};
    for j=1:group
        t2{i,j}=t1(t1(:,10)==j,:);
        p2{i,j}=p1(p1(:,10)==j,:);
        y_t{i,j}=t2{i,j}(:,2);
        x_t{i,j}=t2{i,j};
        y_p{i,j}=p2{i,j}(:,2);
        x_p{i,j}=p2{i,j};
        y1=y_t{i,j};x1=x_t{i,j};
        y2=y_p{i,j};x2=x_p{i,j};
        
        funt = @(para)para(1)*x1(:,1)+para(2)*x1(:,6).*tan(x1(:,11))+...
            para(3)*x1(:,3)+para(4)*x1(:,4)+para(5)*x1(:,5)+para(6)*x1(:,7)+para(7)*x1(:,8)+para(8)*x1(:,9)+para(9)-y1;
        
        [par_t{i,j},~,~,~,~] = lsqnonlin(funt,para,[],[],options);
        
        y1_p{i,j}=par_t{i,j}(1)*x1(:,1)+par_t{i,j}(2)*x1(:,6).*tan(x1(:,11))+...
            par_t{i,j}(3)*x1(:,3)+par_t{i,j}(4)*x1(:,4)+par_t{i,j}(5)*x1(:,5)+...
            par_t{i,j}(6)*x1(:,7)+par_t{i,j}(7)*x1(:,8)+par_t{i,j}(8)*x1(:,9)+par_t{i,j}(9);
        
        r_t{i,j}=min(min(corrcoef(y1,y1_p{i,j})));
        % --------------------------------------------------------------- %
        funp = @(para)para(1)*x2(:,1)+para(2)*x2(:,6).*tan(x2(:,11))+...
            para(3)*x2(:,3)+para(4)*x2(:,4)+para(5)*x2(:,5)+para(6)*x2(:,7)+para(7)*x2(:,8)+para(8)*x2(:,9)+para(9)-y2;
        
        [par_p{i,j},~,~,~,~] = lsqnonlin(funp,para,[],[],options);
        
        y2_p{i,j}=par_p{i,j}(1)*x2(:,1)+par_p{i,j}(2)*x2(:,6).*tan(x2(:,11))+...
            par_p{i,j}(3)*x2(:,3)+par_p{i,j}(4)*x2(:,4)+par_p{i,j}(5)*x2(:,5)+...
            par_p{i,j}(6)*x2(:,7)+par_p{i,j}(7)*x2(:,8)+par_p{i,j}(8)*x2(:,9)+par_p{i,j}(9);
        
        r_p{i,j}=min(min(corrcoef(y2,y2_p{i,j})));
    end  
end

for i=1:period
        for j=1:group
            yt{i,j}=[y_t{i,j} y1_p{i,j}];
            yp{i,j}=[y_p{i,j} y2_p{i,j}];
        end
end
output.yt=yt;output.yp=yp;
output.r_t=r_t;output.r_p=r_p;
output.par_t=par_t;output.par_p=par_p;