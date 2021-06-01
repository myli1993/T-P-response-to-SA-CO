function [temp_d,prec_d]=python_nan_remove(temp_d,prec_d,SN)
for j=1:max(size(temp_d))
    for i=1:length(SN)
        if isnan(temp_d{j}(i,1))
            if i<3
                temp_d{j}(i,1)=0;
            else
                temp_d{j}(i,1)=temp_d{j}(i-1,1)-(temp_d{j}(i-2,1)-temp_d{j}(i-1,1));
            end
        end
        if isnan(prec_d{j}(i,1))
            if i<3
                prec_d{j}(i,1)=0;
            else
                prec_d{j}(i,1)=abs(prec_d{j}(i-1,1)-abs(prec_d{j}(i-2,1)-prec_d{j}(i-1,1)));
            end
        end
    end
end