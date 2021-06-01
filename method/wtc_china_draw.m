function [wtc_t1_plot,wtc_p1_plot,wtc_t2_plot,wtc_p2_plot,wtc_t3_plot,wtc_p3_plot...
    ]=wtc_china_draw(x_t1,x_p1,x_t2,x_p2,x_t3,x_p3,a_t1,a_p1,a_t2,a_p2,a_t3,a_p3,p,A,A_num,do)
[~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\studyarea_Re.tif');
info = geotiffinfo('F:\文章\黑子\gis\dem\ori\studyarea_Re.tif');
geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
A0=p-0.01;
for i=1:max(size(x_p1))
    for j=1:size(p,2)-1
        x_p1_draw{j}(i)=x_p1{i}(j);
        x_t1_draw{j}(i)=x_t1{i}(j);
        x_p2_draw{j}(i)=x_p2{i}(j);
        x_t2_draw{j}(i)=x_t2{i}(j);
        x_p3_draw{j}(i)=x_p3{i}(j);
        x_t3_draw{j}(i)=x_t3{i}(j);
        a_p1_draw{j}(i)=a_p1{i}(j);
        a_t1_draw{j}(i)=a_t1{i}(j);
        a_p2_draw{j}(i)=a_p2{i}(j);
        a_t2_draw{j}(i)=a_t2{i}(j);
        a_p3_draw{j}(i)=a_p3{i}(j);
        a_t3_draw{j}(i)=a_t3{i}(j);
        ah_p1_draw{j}(i)=phase_non(a_p1_draw{j}(i));
        ah_t1_draw{j}(i)=phase_non(a_t1_draw{j}(i));
        ah_p2_draw{j}(i)=phase_non(a_p2_draw{j}(i));
        ah_t2_draw{j}(i)=phase_non(a_t2_draw{j}(i));
        ah_p3_draw{j}(i)=phase_non(a_p3_draw{j}(i));
        ah_t3_draw{j}(i)=phase_non(a_t3_draw{j}(i));       
    end
    if i/10==fix(i/10)
        disp(['------ WTC ARROW Step Completed ',num2str(round(i/size(A_num,1)*1000)/10),'% ','(',num2str(i),'/',num2str(size(A_num,1)),') ------']);
    elseif i==size(A_num,1)
        disp('------ WTC ARROW Step Completed ------');
    end
end
disp('----- START MAKING FIGURES -----');
%%
for i=1:size(p,2)-1
    wtc_t1_plot{i}=double(A);
    wtc_p1_plot{i}=double(A);
    wtc_t2_plot{i}=double(A);
    wtc_p2_plot{i}=double(A);
    wtc_t3_plot{i}=double(A);
    wtc_p3_plot{i}=double(A);
    for j=1:max(size(x_p1))
        wtc_t1_plot{i}(A_num(j))=ah_t1_draw{i}(j)/360*x_t1_draw{i}(j);
        wtc_p1_plot{i}(A_num(j))=ah_p1_draw{i}(j)/360*x_p1_draw{i}(j);
        wtc_t2_plot{i}(A_num(j))=ah_t2_draw{i}(j)/360*x_t2_draw{i}(j);
        wtc_p2_plot{i}(A_num(j))=ah_p2_draw{i}(j)/360*x_p2_draw{i}(j);
        wtc_t3_plot{i}(A_num(j))=ah_t3_draw{i}(j)/360*x_t3_draw{i}(j);
        wtc_p3_plot{i}(A_num(j))=ah_p3_draw{i}(j)/360*x_p3_draw{i}(j);
        %-----SET mini-----%
        wtc_t1_plot{i}(A==0)=nan;
        wtc_p1_plot{i}(A==0)=nan;
        wtc_t2_plot{i}(A==0)=nan;
        wtc_p2_plot{i}(A==0)=nan;
        wtc_t3_plot{i}(A==0)=nan;
        wtc_p3_plot{i}(A==0)=nan;
        min_t1{i}=floor(min(min(wtc_t1_plot{i}))*100)/100;
        max_t1{i}=floor(max(max(wtc_t1_plot{i}))*100)/100;
        min_p1{i}=floor(min(min(wtc_p1_plot{i}))*100)/100;
        max_p1{i}=floor(max(max(wtc_p1_plot{i}))*100)/100;
        min_t2{i}=floor(min(min(wtc_t2_plot{i}))*100)/100;
        max_t2{i}=floor(max(max(wtc_t2_plot{i}))*100)/100;
        min_p2{i}=floor(min(min(wtc_p2_plot{i}))*100)/100;
        max_p2{i}=floor(max(max(wtc_p2_plot{i}))*100)/100;
        min_t3{i}=floor(min(min(wtc_t3_plot{i}))*100)/100;
        max_t3{i}=floor(max(max(wtc_t3_plot{i}))*100)/100;
        min_p3{i}=floor(min(min(wtc_p3_plot{i}))*100)/100;
        max_p3{i}=floor(max(max(wtc_p3_plot{i}))*100)/100;
    end
end
%%
if do==2
    delete F:\文章\黑子\data\china\wtc\*.tif
    for i=1:size(p,2)-1
        % export
        name_t1{i}=strcat('F:/文章/黑子/data/china/wtc/wtc_t1_plot',num2str(i),'.tif');
        name_p1{i}=strcat('F:/文章/黑子/data/china/wtc/wtc_p1_plot',num2str(i),'.tif');
        figure(i);
        hold on
        a1=imshow(wtc_t1_plot{i},'Colormap',autumn);
        caxis([min_t1{i},max_t1{i}]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[min_t1{i} max_t1{i}]);
        %         ,text('Position',[15 7],'String',strcat('SN vs. T : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_t1{i})
        close(figure(i));
        
        figure(i);
        hold on
        a1=imshow(wtc_p1_plot{i},'Colormap',winter);
        caxis([min_p1{i},max_p1{i}]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[min_p1{i} max_p1{i}]);
        %         text('Position',[15 7],'String',strcat('SN - P : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_p1{i})
        close(figure(i));
        %---
        name_t2{i}=strcat('F:/文章/黑子/data/china/wtc/wtc_t2_plot',num2str(i),'.tif');
        name_p2{i}=strcat('F:/文章/黑子/data/china/wtc/wtc_p2_plot',num2str(i),'.tif');
        figure(i);
        hold on
        a1=imshow(wtc_t2_plot{i},'Colormap',autumn);
        caxis([min_t2{i},max_t2{i}]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,...
            'Ticks',[min_t2{i} max_t2{i}]);
        %         text('Position',[15 7],'String',strcat('SOI - T : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_t2{i})
        close(figure(i));
        
        figure(i);
        hold on
        a1=imshow(wtc_p2_plot{i},'Colormap',winter);
        caxis([min_p2{i},max_p2{i}]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,...
            'Ticks',[min_p2{i} max_p2{i}]);
        %         text('Position',[15 7],'String',strcat('SOI - P : ',tex{i}),'FontName', 'times new roman','FontSize',16,);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_p2{i})
        close(figure(i));
        %-----
        name_t3{i}=strcat('F:/文章/黑子/data/china/wtc/wtc_t3_plot',num2str(i),'.tif');
        name_p3{i}=strcat('F:/文章/黑子/data/china/wtc/wtc_p3_plot',num2str(i),'.tif');
        figure(i);
        hold on
        a1=imshow(wtc_t3_plot{i},'Colormap',autumn);
        caxis([min_t3{i},max_t3{i}]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,...
            'Ticks',[min_t3{i} max_t3{i}]);
        %         text('Position',[15 7],'String',strcat('SST - T : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_t3{i})
        close(figure(i));
        
        figure(i);
        hold on
        a1=imshow(wtc_p3_plot{i},'Colormap',winter);
        caxis([min_p3{i},max_p3{i}]);
        set(a1,'AlphaData', ~(A==0));
        set(gcf,'Color','w','Position',[0,0,1200,800]);
        colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,...
            'Ticks',[min_p3{i} max_p3{i}]);
        %         text('Position',[15 7],strcat('SST - P : ',tex{i}),'FontName', 'times new roman','FontSize',16);
        text('Position',[119 33],'String','Year (a)','FontName', 'times new roman','FontSize',16);
        hold off
        export_fig(gcf,'-tif','-r300','-painters',name_p3{i})
        close(figure(i));
        %-count
        disp([num2str(i),'/',num2str((size(p,2)-1))]);
    end
    
    %%
elseif do==1
    for i=1:size(p,2)-1
        wtc_t1_plot{i}=double(A);
        wtc_p1_plot{i}=double(A);
        wtc_t2_plot{i}=double(A);
        wtc_p2_plot{i}=double(A);
        wtc_t3_plot{i}=double(A);
        wtc_p3_plot{i}=double(A);
        for j=1:max(size(x_p1))
            wtc_t1_plot{i}(A_num(j))=x_t1_draw{i}(j);
            wtc_p1_plot{i}(A_num(j))=x_p1_draw{i}(j);
            wtc_t2_plot{i}(A_num(j))=x_t2_draw{i}(j);
            wtc_p2_plot{i}(A_num(j))=x_p2_draw{i}(j);
            wtc_t3_plot{i}(A_num(j))=x_t3_draw{i}(j);
            wtc_p3_plot{i}(A_num(j))=x_p3_draw{i}(j);
            %-----SET mini-----%
            wtc_t1_plot{i}(A==0)=A0(i);
            wtc_p1_plot{i}(A==0)=A0(i);
            wtc_t2_plot{i}(A==0)=A0(i);
            wtc_p2_plot{i}(A==0)=A0(i);
            wtc_t3_plot{i}(A==0)=A0(i);
            wtc_p3_plot{i}(A==0)=A0(i);
        end
        name_t1{i}=strcat('F:\文章\黑子\data\china\wtc_gis\wtc_t1_plot',num2str(i),'.tif');
        name_p1{i}=strcat('F:\文章\黑子\data\china\wtc_gis\wtc_p1_plot',num2str(i),'.tif');
        geotiffwrite(name_t1{i},wtc_t1_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p1{i},wtc_p1_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        name_t2{i}=strcat('F:\文章\黑子\data\china\wtc_gis\wtc_t2_plot',num2str(i),'.tif');
        name_p2{i}=strcat('F:\文章\黑子\data\china\wtc_gis\wtc_p2_plot',num2str(i),'.tif');
        geotiffwrite(name_t2{i},wtc_t2_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p2{i},wtc_p2_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        name_t3{i}=strcat('F:\文章\黑子\data\china\wtc_gis\wtc_t3_plot',num2str(i),'.tif');
        name_p3{i}=strcat('F:\文章\黑子\data\china\wtc_gis\wtc_p3_plot',num2str(i),'.tif');
        geotiffwrite(name_t3{i},wtc_t3_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p3{i},wtc_p3_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        %-count
        disp([num2str(i),'/',num2str((size(p,2)-1))]);
        
        
    end
end
