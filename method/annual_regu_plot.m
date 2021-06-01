function [ar_t_plot,ar_p_plot]=annual_regu_plot(ar_t,ar_p,A,A_num,do,p)
[~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
A(A==0)=nan;
for i=1:max(size(ar_t))
    for j=1:size(p,2)-1
        ar_t_p{j}(i)=ar_t{i}(j);
        ar_p_p{j}(i)=ar_p{i}(j);
    end
end
if do==1
    for i=1:size(p,2)-1
        ar_t_plot{i}=A;
        ar_p_plot{i}=A;
        for j=1:max(size(ar_t))
            ar_t_plot{i}(A_num(j))=ar_t_p{i}(j);
            ar_p_plot{i}(A_num(j))=ar_p_p{i}(j);
        end
        name_t{i}=strcat('F:\文章\黑子\gis\annual_regulation\ar_t_plot',num2str(i),'.tif');
        name_p{i}=strcat('F:\文章\黑子\gis\annual_regulation\ar_p_plot',num2str(i),'.tif');
        geotiffwrite(name_t{i},ar_t_plot{i},R,'GeoKeyDirectoryTag',geoTags);
        geotiffwrite(name_p{i},ar_p_plot{i},R,'GeoKeyDirectoryTag',geoTags);
    end
else
    for i=1:size(p,2)-1
        ar_t_plot{i}=A;
        ar_p_plot{i}=A;
        for j=1:max(size(ar_t))
            ar_t_plot{i}(A_num(j))=ar_t_p{i}(j);
            ar_p_plot{i}(A_num(j))=ar_p_p{i}(j);
        end
    end
end
