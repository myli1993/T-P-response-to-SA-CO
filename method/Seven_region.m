function [xwt_t1,xwt_p1,xwt_t2,xwt_p2,xwt_t3,xwt_p3,wtc_t1,wtc_p1,wtc_t2,wtc_p2,wtc_t3,wtc_p3...
    ]=Seven_region(xwt_t1_plot,xwt_p1_plot,xwt_t2_plot,xwt_p2_plot,xwt_t3_plot,xwt_p3_plot,...
    wtc_t1_plot,wtc_p1_plot,wtc_t2_plot,wtc_p2_plot,wtc_t3_plot,wtc_p3_plot,p)
% [A,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
% info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
% geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
% [B,~]=geotiffread('F:\文章\黑子\gis\national shp\tif1.tif');
% C=A(4:73,15:135);
% [p,q]=size(B);
% [x,y]=meshgrid((0:p-1)/(p-1),(0:q-1)/(q-1));
% p1=70;q1=121;
% [x1,y1]=meshgrid((0:p1-1)/(p1-1),(0:q1-1)/(q1-1));
% D=(interp2(x,y,double(B)',x1,y1,'nearest'))';
% for i=1:size(C,1)
%     for j=1:size(C,2)
%         if C(i,j)==0
%             D(i,j)=0;
%         elseif C(i,j)==1 && D(i,j)==0
%             a=D(i-1:i+1,j-1:j+1);
%             D(i,j)=mode(a(a>0));
%         end
%     end
% end
% E=A;
% E(4:73,15:135)=D;
% geotiffwrite('F:\文章\黑子\gis\national shp\Seven_Region1.tif',E,R,'GeoKeyDirectoryTag',geoTags);

[B,~]=geotiffread('F:\文章\黑子\gis\national shp\Seven_Region1.tif');
% geotiffwrite('F:\文章\黑子\gis\national shp\Seven_Region1.tif',B,R,'GeoKeyDirectoryTag',geoTags);

for tp=1:6
    for g=1:7
        xwt_t1(g,tp)=mode(xwt_t1_plot{tp}(B==g));
        xwt_p1(g,tp)=mode(xwt_p1_plot{tp}(B==g));
        xwt_t2(g,tp)=mode(xwt_t2_plot{tp}(B==g));
        xwt_p2(g,tp)=mode(xwt_p2_plot{tp}(B==g));
        xwt_t3(g,tp)=mode(xwt_t3_plot{tp}(B==g));
        xwt_p3(g,tp)=mode(xwt_p3_plot{tp}(B==g));
        wtc_t1(g,tp)=median(wtc_t1_plot{tp}(B==g));
        wtc_p1(g,tp)=median(wtc_p1_plot{tp}(B==g));
        wtc_t2(g,tp)=median(wtc_t2_plot{tp}(B==g));
        wtc_p2(g,tp)=median(wtc_p2_plot{tp}(B==g));
        wtc_t3(g,tp)=median(wtc_t3_plot{tp}(B==g));
        wtc_p3(g,tp)=median(wtc_p3_plot{tp}(B==g));
    end
end
