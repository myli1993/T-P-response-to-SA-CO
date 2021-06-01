function [reg_t,reg_p]=reg_china_pre(xwt_t1_plot,xwt_p1_plot,xwt_t2_plot,xwt_p2_plot,xwt_t3_plot,xwt_p3_plot,...
    wtc_t1_plot,wtc_p1_plot,wtc_t2_plot,wtc_p2_plot,wtc_t3_plot,wtc_p3_plot,p,A,A_num)
for i=1:max(size(p))-1
    w_t1{i}=wtc_t1_plot{i}(A==1);
    w_p1{i}=wtc_p1_plot{i}(A==1);
    w_t2{i}=wtc_t2_plot{i}(A==1);
    w_p2{i}=wtc_p2_plot{i}(A==1);
    w_t3{i}=wtc_t3_plot{i}(A==1);
    w_p3{i}=wtc_p3_plot{i}(A==1);
    x_t1{i}=xwt_t1_plot{i}(A==1);
    x_p1{i}=xwt_p1_plot{i}(A==1);
    x_t2{i}=xwt_t2_plot{i}(A==1);
    x_p2{i}=xwt_p2_plot{i}(A==1);
    x_t3{i}=xwt_t3_plot{i}(A==1);
    x_p3{i}=xwt_p3_plot{i}(A==1);
end

[lat,lon]=reg_china_ll(p,A);
[dem]=reg_china_dem(p,A);

for i=1:max(size(A_num))
    for j=1:max(size(p))-1
        reg_t{j,i}=[x_t1{j}(i);x_t2{j}(i);x_t3{j}(i);w_t1{j}(i);w_t2{j}(i);w_t3{j}(i);lat{j}(i);lon{j}(i);dem{j}(i)*0.001];
        reg_p{j,i}=[x_p1{j}(i);x_p2{j}(i);x_p3{j}(i);w_p1{j}(i);w_p2{j}(i);w_p3{j}(i);lat{j}(i);lon{j}(i);dem{j}(i)*0.001];
    end
end
