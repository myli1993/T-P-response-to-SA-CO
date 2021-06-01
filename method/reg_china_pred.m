function [Rt_plot,Rp_plot,Et_plot,Ep_plot]=reg_china_pred(total_t,total_p,output,A_num,A,group,period,p,do)

for i=1:period
    t1=total_t{i};
    p1=total_p{i};
    t1(:,end+1)=A_num;
    p1(:,end+1)=A_num;
    for j=1:group
        t2{i,j}=t1(t1(:,10)==j,end);
        p2{i,j}=p1(p1(:,10)==j,end);
        yt{i,j}=output.yt{i,j}(:,:);
        yp{i,j}=output.yp{i,j}(:,:);
        yt{i,j}(:,end+1)=t2{i,j};
        yp{i,j}(:,end+1)=p2{i,j};
    end
    yt1{i}=[yt{i,1};yt{i,2};yt{i,3};yt{i,4};yt{i,5};yt{i,6}];
    yp1{i}=[yp{i,1};yp{i,2};yp{i,3};yp{i,4};yp{i,5};yp{i,6}];
    [~,idx_t{i}]=sort(yt1{i}(:,3));
    yt2{i}=yt1{i}(idx_t{i},:);
    [~,idx_p{i}]=sort(yp1{i}(:,3));
    yp2{i}=yp1{i}(idx_p{i},:);
end
for i=1:period
    for j=1:group
        yt3(:,(j-1)*2+1:(j-1)*2+2)=yt2{j}(:,1:2);
        yp3(:,(j-1)*2+1:(j-1)*2+2)=yp2{j}(:,1:2);
    end
    yt3(:,period*2+1)=yt2{i}(:,3);
    yp3(:,period*2+1)=yp2{i}(:,3);
end
for i=1:max(size(yt3))
    for j=1:period
        ob_t{i}(j)=yt3(i,(j-1)*2+1);
        ob_p{i}(j)=yp3(i,(j-1)*2+1);
        si_t{i}(j)=yt3(i,(j-1)*2+2);
        si_p{i}(j)=yt3(i,(j-1)*2+2);
    end
    yr_t(i,1)=min(min(corrcoef(ob_t{i},si_t{i})))^2;
    yr_p(i,1)=min(min(corrcoef(ob_p{i},si_p{i})))^2;
    ye_t(i,1)=sqrt(mean((si_t{i}-ob_t{i}).^2));
    ye_p(i,1)=sqrt(mean((si_p{i}-ob_p{i}).^2));
end

% ---- Draw ----%
Rt_plot=double(A);
Rp_plot=double(A);
Et_plot=double(A);
Ep_plot=double(A);
for j=1:max(size(A_num))
    Rt_plot(A_num(j))=yr_t(j,1);
    Rp_plot(A_num(j))=yr_p(j,1);
    Et_plot(A_num(j))=ye_t(j,1);
    Ep_plot(A_num(j))=ye_p(j,1);
    %-----SET mini-----%
    Rt_plot(A==0)=NaN;
    Rp_plot(A==0)=NaN;
    Et_plot(A==0)=NaN;
    Ep_plot(A==0)=NaN;
end

%%
% delete F:\文章\黑子\data\china\lagpredict\*.tif
% tex={'0 ~ 5 a','5 ~ 10 a','10 ~ 30 a','30 ~ 60 a','60 ~ 90 a','90 ~ 120 a'};

%---Min & Max---%
min_rt=ceil(min(min(Rt_plot))*100)/10;
max_rt=ceil(max(max(Rt_plot))*100)/100;
min_rp=ceil(min(min(Rp_plot))*100)/10;
max_rp=ceil(max(max(Rp_plot))*100)/100;
min_et=floor(min(min(Et_plot))*100)/100;
max_et=floor(max(max(Et_plot))*100)/100;
min_ep=floor(min(min(Ep_plot))*100)/100;
max_ep=floor(max(max(Ep_plot))*100)/100;
%---Name---%
name_rt=strcat('F:/文章/黑子/data/china/lagpredict/rt_plot.tif');
name_rp=strcat('F:/文章/黑子/data/china/lagpredict/rp_plot.tif');
name_et=strcat('F:/文章/黑子/data/china/lagpredict/et_plot.tif');
name_ep=strcat('F:/文章/黑子/data/china/lagpredict/ep_plot.tif');
%---Plot---%
if do==1
    [~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
    info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
    geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
    Rt_plot(A==0)=-0.01;
    Rp_plot(A==0)=-0.01;
    Et_plot(A==0)=-0.01;
    Ep_plot(A==0)=-0.01; 
    geotiffwrite('F:\文章\黑子\data\china\result_gis\Rt.tif',Rt_plot,R,'GeoKeyDirectoryTag',geoTags);
    geotiffwrite('F:\文章\黑子\data\china\result_gis\Rp.tif',Rp_plot,R,'GeoKeyDirectoryTag',geoTags);
    geotiffwrite('F:\文章\黑子\data\china\result_gis\Et.tif',Et_plot,R,'GeoKeyDirectoryTag',geoTags);
    geotiffwrite('F:\文章\黑子\data\china\result_gis\Ep.tif',Ep_plot,R,'GeoKeyDirectoryTag',geoTags);

elseif do==2
    figure(1);
    hold on
    a1=imshow(Rt_plot,'Colormap',autumn);
    caxis([min_rt,max_rt]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[min_rt (min_rt+max_rt)/2 max_rt]);
    text('Position',[121 33],'String','\itR^2','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_rt)
    close(figure(1));
    
    figure(2);
    hold on
    a1=imshow(Rp_plot,'Colormap',winter);
    caxis([min_rp,max_rp]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[min_rp (min_rp+max_rp)/2 max_rp]);
    text('Position',[121 33],'String','\itR^2','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_rp)
    close(figure(2));
    
    figure(3);
    hold on
    a1=imshow(Et_plot,'Colormap',spring);
    caxis([min_et,max_et]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[min_et (min_et+max_et)/2 max_et]);
    text('Position',[117 33],'String','RMSE (a)','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_et)
    close(figure(3));
    
    figure(4);
    hold on
    a1=imshow(Ep_plot,'Colormap',flipud(cool));
    caxis([min_ep,max_ep]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',...
        [min_ep floor((min_ep+max_ep)/2*100)/100 max_ep]);
    text('Position',[117 33],'String','RMSE (a)','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_ep)
    close(figure(4));
end

