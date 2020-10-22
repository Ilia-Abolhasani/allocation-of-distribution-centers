function Ans=RPD(Input,flag)
%1=Based on the Row
%2=Based on the Column
%robust parameter design
Ans=Input;
if(flag==1)
    for i=1 :size(Input,2)
        row=Input(:,i);
        Min=min(row);
        for j=1:size(Input,1)
            Ans(j,i)=(Input(j,i)-Min)/Min;
        end
    end
else
    for i=1 :size(Input,1)
        Column=Input(i,:);
        Min=min(Column);
        for j=1:size(Input,2)
            Ans(i,j)=(Input(i,j)-Min)/Min;
        end
    end
end
end