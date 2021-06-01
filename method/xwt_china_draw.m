function [xwt_t1_plot,xwt_p1_plot,xwt_t2_plot,xwt_p2_plot,xwt_t3_plot,xwt_p3_plot]=...
    xwt_china_draw(x_p1,x_p2,x_p3,x_t1,x_t2,x_t3,A,A_num,p,do)
[~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
A0=p-0.01;
% A(A==0)=nan;
for i=1:max(size(x_p1))
    for j=1:size(p,2)-1
        x_p1_draw{j}(i)=x_p1{i}(j);
        x_t1_draw{j}(i)=x_t1{i}(j);
        x_p2_draw{j}(i)=x_p2{i}(j);
        x_t2_draw{j}(i)=x_t2{i}(j);
        x_p3_draw{j}(i)=x_p3{i}(j);
        x_t3_draw{j}(i)=x_t3{i}(j);
    end
end
if do==1
    delete F:\文章\黑子\data\china\xwt\*.tif
    for i=1:size(p,2)-1
        xwt_t1_plot{i}=double(A);
        xwt_p1_plot{i}=double(A);
        xwt_t2_plot{i}=double(A);
        xwt_p2_plot{i}=double(A);
        xwt_t3_plot{i}=double(A);
        xwt_p3_plot{i}=double(A);
        for j=1:max(size(x_p1))
            xwt_t1_plot{i}(A_num(j))=x_t1_draw{i}(j);
            xwt_p1_plot{i}(A_num(j))=x_p1_draw{i}(j);
            xwt_t2_plot{i}(A_num(j))=x_t2_draw{i}(j);
            xwt_p2_plot{i}(A_num(j))=x_p2_draw{i}(j);
            xwt_t3_plot{i}(A_num(j))=x_t3_draw{i}(j);
            xwt_p3_plot{i}(A_num(j))=x_p3_draw{i}(j);
            %-----SET mini-----%
            xwt_t1_plot{i}(A==0)=A0(i);
            xwt_p1_plot{i}(A==0)=A0(i);
            xwt_t2_plot{i}(A==0)=A0(i);
            xwt_p2_plot{i}(A==0)=A0(i);
            xwt_t3_plot{i}(A==0)=A0(i);
            xwt_p3_plot{i}(A==0)=A0(i);
        end
        name_t1{i}=strcat('F:\文章\黑子\data\china\xwt_gis\xwt_t1_plot',num2str(i),'.tif');
        name_p1{i}=strcat('F:\文章\黑子\data\china\xwt_gis\xwt_p1_plot',num2str(i),'.tif');
        geotiffwrite(name_t1{i},xwt_t1_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p1{i},xwt_p1_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        name_t2{i}=strcat('F:\文章\黑子\data\china\xwt_gis\xwt_t2_plot',num2str(i),'.tif');
        name_p2{i}=strcat('F:\文章\黑子\data\china\xwt_gis\xwt_p2_plot',num2str(i),'.tif');
        geotiffwrite(name_t2{i},xwt_t2_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p2{i},xwt_p2_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        name_t3{i}=strcat('F:\文章\黑子\data\china\xwt_gis\xwt_t3_plot',num2str(i),'.tif');
        name_p3{i}=strcat('F:\文章\黑子\data\china\xwt_gis\xwt_p3_plot',num2str(i),'.tif');
        geotiffwrite(name_t3{i},xwt_t3_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p3{i},xwt_p3_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        %-count
        disp([num2str(i),'/',num2str((size(p,2)-1))]);
    end
elseif do==2
    delete F:\文章\黑子\data\china\xwt1\*.tif
    tex={'0 ~ 5 a','5 ~ 10 a','10 ~ 30 a','30 ~ 60 a','60 ~ 90 a','90 ~ 120 a'};
    for i=1:size(p,2)-1
        xwt_t1_plot{i}=double(A);
        xwt_p1_plot{i}=double(A);
        xwt_t2_plot{i}=double(A);
        xwt_p2_plot{i}=double(A);
        xwt_t3_plot{i}=double(A);
        xwt_p3_plot{i}=double(A);
        for j=1:max(size(x_p1))
            xwt_t1_plot{i}(A_num(j))=x_t1_draw{i}(j);
            xwt_p1_plot{i}(A_num(j))=x_p1_draw{i}(j);
            xwt_t2_plot{i}(A_num(j))=x_t2_draw{i}(j);
            xwt_p2_plot{i}(A_num(j))=x_p2_draw{i}(j);
            xwt_t3_plot{i}(A_num(j))=x_t3_draw{i}(j);
            xwt_p3_plot{i}(A_num(j))=x_p3_draw{i}(j);
            %-----SET mini-----%
            xwt_t1_plot{i}(A==0)=min(min(xwt_t1_plot{i}))-0.01;
            xwt_p1_plot{i}(A==0)=min(min(xwt_p1_plot{i}))-0.01;
            xwt_t2_plot{i}(A==0)=min(min(xwt_t2_plot{i}))-0.01;
            xwt_p2_plot{i}(A==0)=min(min(xwt_p2_plot{i}))-0.01;
            xwt_t3_plot{i}(A==0)=min(min(xwt_t3_plot{i}))-0.01;
            xwt_p3_plot{i}(A==0)=min(min(xwt_p3_plot{i}))-0.01;
        end
        % export
        name_t1{i}=strcat('F:/文章/黑子/data/china/xwt1/xwt_t1_plot',num2str(i),'.tif');
        name_p1{i}=strcat('F:/文章/黑子/data/china/xwt1/xwt_p1_plot',num2str(i),'.tif');
        figure(i);
        hold on
        a1=imshow(xwt_t1_plot{i},'Colormap',autumn);
        caxis([p(i),p(i+1)]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
%         text('Position',[15 7],'String',strcat('SN - T : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_t1{i})
        close(figure(i));
       
        figure(i);
        hold on
        a1=imshow(xwt_p1_plot{i},'Colormap',winter);
        caxis([p(i),p(i+1)]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
%         text('Position',[15 7],'String',strcat('SN - P : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_p1{i})
        close(figure(i));
        %---
        name_t2{i}=strcat('F:/文章/黑子/data/china/xwt1/xwt_t2_plot',num2str(i),'.tif');
        name_p2{i}=strcat('F:/文章/黑子/data/china/xwt1/xwt_p2_plot',num2str(i),'.tif');
        figure(i);
        hold on
        a1=imshow(xwt_t2_plot{i},'Colormap',autumn);
        caxis([p(i),p(i+1)]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
%         text('Position',[15 7],'String',strcat('SOI - T : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_t2{i})
        close(figure(i));
       
        figure(i);
        hold on
        a1=imshow(xwt_p2_plot{i},'Colormap',winter);
        caxis([p(i),p(i+1)]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
%         text('Position',[15 7],'String',strcat('SOI - P : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_p2{i})
        close(figure(i));
        %-----        
        name_t3{i}=strcat('F:/文章/黑子/data/china/xwt1/xwt_t3_plot',num2str(i),'.tif');
        name_p3{i}=strcat('F:/文章/黑子/data/china/xwt1/xwt_p3_plot',num2str(i),'.tif');
        figure(i);
        hold on
        a1=imshow(xwt_t3_plot{i},'Colormap',autumn);
        caxis([p(i),p(i+1)]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
%         text('Position',[15 7],'String',strcat('SST - T : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_t3{i})
        close(figure(i));
       
        figure(i);
        hold on
        a1=imshow(xwt_p3_plot{i},'Colormap',winter);
        caxis([p(i),p(i+1)]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
%         text('Position',[15 7],strcat('SST - P : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_p3{i})
        close(figure(i));
        %-count
        disp([num2str(i),'/',num2str((size(p,2)-1))]);
    end
end

