function [temp2,prec2]=fix_t_p(temp1,prec1,A)
[x,y,t]=size(temp1);
for i=1:t
    for j=1:x
        for k=1:y
            if A(j,k)==0
                temp2(j,k,i)=0;
                prec2(j,k,i)=0;
            else
                temp2(j,k,i)=temp1(j,k,i);
                prec2(j,k,i)=prec1(j,k,i);
            end
        end
    end
end
b=[-1,-1;0,-1;1,-1;-1,0;1,0;-1,1;0,1;1,1];
for i=1:t
    for j=1:x
        for k=1:y
            c=ones(8,1);
            sum_t=[];
            sum_p=[];
            %t
            if temp2(j,k,i)<-100
                for l=1:8
                    if temp2(j+b(l,1),k+b(l,2),i)<-100 || temp2(j+b(l,1),k+b(l,2),i)==0 || isnan(temp2(j+b(l,1),k+b(l,2),i))
                        c(l,1)=0;
                    end
                    c_index=find(c==1);
                end
                for m=1:length(c_index)
                    sum_t(m)=temp2(j+b(c_index(m),1),k+b(c_index(m),2),i);
                end
                temp2(j,k,i)=mean(sum_t);
            end
            %p
            if prec2(j,k,i)<-100
                for l=1:8
                    if prec2(j+b(l,1),k+b(l,2),i)<-100 || prec2(j+b(l,1),k+b(l,2),i)==0 || isnan(prec2(j+b(l,1),k+b(l,2),i))
                        c(l,1)=0;
                    end
                    c_index=find(c==1);
                end
                for m=1:length(c_index)
                    sum_p(m)=prec2(j+b(c_index(m),1),k+b(c_index(m),2),i);
                end
                prec2(j,k,i)=mean(sum_p);
            end
        end
    end
end

% for i=1:t
%     for j=1:x
%         for k=1:y
%             if temp2(j,k,i)<-100 || prec2(j,k,i)<-100
%                 bb(j,k)=1;
%             end
%         end
%     end
% end



