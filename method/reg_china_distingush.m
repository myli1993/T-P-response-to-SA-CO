function [dis_t5,dis_p5]=reg_china_distingush(reg_t,reg_p,p,A_num,A)
for i=1:max(size(A_num))
    dis_t1{i}=[reg_t{1,i} reg_t{2,i} reg_t{3,i} reg_t{4,i} reg_t{5,i} reg_t{6,i}];
    dis_p1{i}=[reg_p{1,i} reg_p{2,i} reg_p{3,i} reg_p{4,i} reg_p{5,i} reg_p{6,i}];
    dis_t2{i}=real(non_EntropyWeight(dis_t1{i}));
    dis_p2{i}=real(non_EntropyWeight(dis_p1{i}));
    dis_t3{i}=[dis_t2{i}(1) (dis_t2{i}(2)+dis_t2{i}(3))/2 sum(dis_t2{i}(4:6))/3];
    dis_p3{i}=[dis_p2{i}(1) (dis_p2{i}(2)+dis_p2{i}(3))/2 sum(dis_p2{i}(4:6))/3];
    dis_t4{i}=[dis_t3{i}(1)/sum(dis_t3{i}(1:3)) dis_t3{i}(2)/sum(dis_t3{i}(1:3)) dis_t3{i}(3)/sum(dis_t3{i}(1:3))];
    dis_p4{i}=[dis_p3{i}(1)/sum(dis_p3{i}(1:3)) dis_p3{i}(2)/sum(dis_p3{i}(1:3)) dis_p3{i}(3)/sum(dis_p3{i}(1:3))];
    dis_t5(i,1)=dis_t4{i}(1);
    dis_t5(i,2)=dis_t4{i}(3);
    dis_t5(i,3)=dis_t4{i}(2);
    dis_p5(i,1)=dis_p4{i}(1);
    dis_p5(i,2)=dis_p4{i}(3);
    dis_p5(i,3)=dis_p4{i}(2);
end
%% ---- Max & Min ---- %%
t_rmax=max(max(dis_t5(:,1)));
t_gmax=max(max(dis_t5(:,2)));
t_bmax=max(max(dis_t5(:,3)));
p_rmax=max(max(dis_p5(:,1)));
p_gmax=max(max(dis_p5(:,2)));
p_bmax=max(max(dis_p5(:,3)));
t_rmin=min(min(dis_t5(:,1)));
t_gmin=min(min(dis_t5(:,2)));
t_bmin=min(min(dis_t5(:,3)));
p_rmin=min(min(dis_p5(:,1)));
p_gmin=min(min(dis_p5(:,2)));
p_bmin=min(min(dis_p5(:,3)));
for i=1:max(size(A_num))
    dis_t7(i,1)=255*(dis_t5(i,1)-t_rmin)/t_rmax;
    dis_t7(i,2)=255*(dis_t5(i,2)-t_gmin)/t_gmax;
    dis_t7(i,3)=255*(dis_t5(i,3)-t_bmin)/t_bmax;
    dis_p7(i,1)=255*(dis_p5(i,1)-p_rmin)/p_rmax;
    dis_p7(i,2)=255*(dis_p5(i,2)-p_gmin)/p_gmax;
    dis_p7(i,3)=255*(dis_p5(i,3)-p_bmin)/p_bmax;
end
dis_t11_plot=double(A);
dis_t12_plot=double(A);
dis_t13_plot=double(A);
dis_p11_plot=double(A);
dis_p12_plot=double(A);
dis_p13_plot=double(A);
for i=1:max(size(A_num))
    dis_t11_plot(A_num(i))=dis_t7(i,1);
    dis_t12_plot(A_num(i))=dis_t7(i,2);
    dis_t13_plot(A_num(i))=dis_t7(i,3);
    dis_p11_plot(A_num(i))=dis_p7(i,1);
    dis_p12_plot(A_num(i))=dis_p7(i,2);
    dis_p13_plot(A_num(i))=dis_p7(i,3);
end
dis_t_plot(:,:,1)=dis_t11_plot;
dis_t_plot(:,:,2)=dis_t12_plot;
dis_t_plot(:,:,3)=dis_t13_plot;
dis_p_plot(:,:,1)=dis_p11_plot;
dis_p_plot(:,:,2)=dis_p12_plot;
dis_p_plot(:,:,3)=dis_p13_plot;

rgb_tr=dis_t_plot(:,:,1);
rgb_tg=dis_t_plot(:,:,2);
rgb_tb=dis_t_plot(:,:,3);
rgb_tr=dis_p_plot(:,:,1);
rgb_pg=dis_p_plot(:,:,2);
rgb_pb=dis_p_plot(:,:,3);
%%
delete F:\文章\黑子\data\china\distingush\*.tif
    % export
    name_t=strcat('F:/文章/黑子/data/china/distingush/distingush_t_plot.tif');
    name_p=strcat('F:/文章/黑子/data/china/distingush/distingush_p_plot.tif');
    figure(1);
    hold on
    a1=imshow(uint8(dis_t_plot));
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_t)
    close(figure(1));
    
    figure(2);
    hold on
    a1=imshow(uint8(dis_p_plot));
    set(a1,'AlphaData', ~(A==0));
    set(gcf,'Color','w','Position',[0,0,1200,800]);
    hold off
    export_fig(gcf,'-tif','-r300','-painters',name_p)
    close(figure(2));
%%
[~,R]=geotiffread('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
info = geotiffinfo('F:\文章\黑子\gis\dem\ori\chinaarea.tif');
geoTags = info.GeoTIFFTags.GeoKeyDirectoryTag;
name_t=strcat('F:\文章\黑子\data\china\ew_gis\ew_t_plot.tif');
name_p=strcat('F:\文章\黑子\data\china\ew_gis\ew_p_plot.tif');
geotiffwrite(name_t,dis_t_plot,R,'GeoKeyDirectoryTag',geoTags);
geotiffwrite(name_p,dis_p_plot,R,'GeoKeyDirectoryTag',geoTags);
   
    
    
%%
% tr_pic=zeros(200,173,3);
% h=100;
% for i=1:200
%     for j=1:173
%         tr_pic(i,j,1)=sqrt(i^2+j^2)/173.2*h;
%     end
% end
% for i=1:200
%     for j=1:173
%         tr_pic(i,j,2)=sqrt((i-100)^2+(j-173)^2)/173.2*h;
%     end
% end
% for i=1:200
%     for j=1:173
%         tr_pic(i,j,3)=sqrt((i-200)^2+j^2)/173.2*h;
%     end
% end
% pic=tr_pic;
% pic0=pic;
% value=(max(max(pic)));
% pic0(:,:,1)=pic(:,:,1)*255/value(:,:,1);
% pic0(:,:,2)=pic(:,:,2)*255/value(:,:,2);
% pic0(:,:,3)=pic(:,:,3)*255/value(:,:,3);
%  
% pic00=pic0;
% pic00(:,:,2)=pic00(:,:,2);
% pic000=pic00;
% pic1=uint8(pic00);
% for i=1:200
%     for j=1:173
%         if((j>1.732*i )||(j>(173.2*2-1.732*i)))
%             for n=1:3
%                 pic1(i,j,n)=255; 
%                 pic000(i,j,n)=NaN;
%             end
%         end
%     end
% end
% imshow(pic1)
% axis off
% set(gcf,'Color','w','Position',[0,0,1200,800]);