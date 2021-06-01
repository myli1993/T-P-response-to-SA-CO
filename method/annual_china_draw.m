function annual_china_draw(ar_t_plot,ar_p_plot,p,A,art_lat,arp_lat,art_lon,arp_lon)
    delete F:\文章\黑子\data\china\ar\*.tif;
    [~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
    info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
    geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
for i=1:6
    % export
    name_t{i}=strcat('F:/文章/黑子/data/china/ar/art1_plot',num2str(i),'.tif');
    name_p{i}=strcat('F:/文章/黑子/data/china/ar/arp1_plot',num2str(i),'.tif');
    
    figure(i);
    hold on
    a1=imshow(ar_t_plot{i},'Colormap',autumn);
    caxis([p(i),p(i+1)]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
    text('Position',[115 34],'String','Year (a)','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_t{i})
    close(figure(i));
    
    figure(i);
    hold on
    a1=imshow(ar_p_plot{i},'Colormap',winter);
    caxis([p(i),p(i+1)]);
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    colorbar('position',[0.65 0.5 0.025 0.1],'FontName', 'times new roman','FontSize',14,'Ticks',[p(i) (p(i)+p(i+1))/2 p(i+1)]);
    text('Position',[115 34],'String','Year (a)','FontName', 'times new roman','FontSize',16);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_p{i})
    close(figure(i));
    
end

%%
for i=1:6
    name_t1{i}=strcat('F:/文章/黑子/data/china/ar_gis/art1_plot',num2str(i),'.tif');
    name_p1{i}=strcat('F:/文章/黑子/data/china/ar_gis/arp1_plot',num2str(i),'.tif');
    geotiffwrite(name_t1{i},ar_t_plot{i},R,'GeoKeyDirectoryTag',geoTags);
    geotiffwrite(name_p1{i},ar_p_plot{i},R,'GeoKeyDirectoryTag',geoTags);
end