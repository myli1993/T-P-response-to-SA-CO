function [total_t,total_p]=reg_china_clu(reg_t,reg_p,p,A_num,A,max_lagt,max_lagp,group,hangle,dis_t5,dis_p5,do)
[sn_soi,sn_sst]=reg_solar_cli(p);
for j=1:max(size(reg_t))
    t1(j,:)=reg_t{1,j};
    p1(j,:)=reg_p{1,j};
    t2(j,:)=reg_t{2,j};
    p2(j,:)=reg_p{2,j};
    t3(j,:)=reg_t{3,j};
    p3(j,:)=reg_p{3,j};
    t4(j,:)=reg_t{4,j};
    p4(j,:)=reg_p{4,j};
    t5(j,:)=reg_t{5,j};
    p5(j,:)=reg_p{5,j};
    t6(j,:)=reg_t{6,j};
    p6(j,:)=reg_p{6,j};  
end

% -------------------------- remap -------------------------------------- %
[x_t,~,~]=kmeans(dis_t5,group);
[x_p,~,~]=kmeans(dis_p5,group);
g=(1:group);
% -------------------------------------
if do==1
    [~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
    info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
    geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
    group_t=double(A);
    group_p=double(A);
    for i=1:max(size(A_num))
        group_t(A_num(i))=x_t(i);
        group_p(A_num(i))=x_p(i);
    end
    group_t(A==0)=0.99;
    group_p(A==0)=0.99;
    geotiffwrite('F:\文章\黑子\data\china\result_gis\group_t.tif',group_t,R,'GeoKeyDirectoryTag',geoTags);
    geotiffwrite('F:\文章\黑子\data\china\result_gis\group_p.tif',group_p,R,'GeoKeyDirectoryTag',geoTags);
    
elseif do==2
    delete F:\文章\黑子\data\china\group\*.tif
    
    group_t=A;
    group_p=A;
    for i=1:max(size(A_num))
        group_t(A_num(i))=x_t(i);
        group_p(A_num(i))=x_p(i);
    end
    group_t(A==0)=NaN;
    group_p(A==0)=NaN;
    name_t=strcat('F:/文章/黑子/data/china/group/group_t_plot.tif');
    name_p=strcat('F:/文章/黑子/data/china/group/group_p_plot.tif');
    
    figure(1);
    hold on
    a1=imshow(group_t,'Colormap',autumn);
    caxis([1,6]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.66 0.47 0.025 0.13],'FontName', 'times new roman','FontSize',14,'Ticks',[1 2 3 4 5 6]);
    text('Position',[119 33],'String','Group','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_t)
    close(figure(1));
    
    figure(2);
    hold on
    a1=imshow(group_p,'Colormap',winter);
    caxis([1,6]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.66 0.47 0.025 0.13],'FontName', 'times new roman','FontSize',14,'Ticks',[1 2 3 4 5 6]);
    text('Position',[119 33],'String','Group','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_p)
    close(figure(2));
end
% -------------Hangle --------------%
ang=mean(hangle,3);
angl=ang(A==1);

% ---------------------------- Regression ------------------------------- %
for i=1:max(size(p))-1
    s_soi{i}=ones(max(size(t1)),1)*sn_soi(i);
    s_sst{i}=ones(max(size(t1)),1)*sn_sst(i);
end
cell_t{1}=t1;cell_t{2}=t2;cell_t{3}=t3;cell_t{4}=t4;cell_t{5}=t5;cell_t{6}=t6;
cell_p{1}=p1;cell_p{2}=p2;cell_p{3}=p3;cell_p{4}=p4;cell_p{5}=p5;cell_p{6}=p6;
for i=1:max(size(p))-1
    total_t{i}=[(max_lagt')./12 cell_t{i}(:,4) cell_t{i}(:,1) (cell_t{i}(:,5)+ cell_t{i}(:,6))/2 ...
        (cell_t{i}(:,2)+ cell_t{i}(:,3))/2 (s_soi{i}+s_sst{i})/2 ...
        cell_t{i}(:,7:end) x_t angl];
    total_p{i}=[(max_lagp')./12 cell_p{i}(:,4) cell_p{i}(:,1) (cell_p{i}(:,5)+ cell_p{i}(:,6))/2 ...
        (cell_p{i}(:,2)+ cell_p{i}(:,3))/2 (s_soi{i}+s_sst{i})/2 ...
        cell_p{i}(:,7:end) x_p angl];
end
