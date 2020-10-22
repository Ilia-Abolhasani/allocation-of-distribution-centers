function Ans = MEPFM(input,Table)
%Main effects plot for means
[m n]=size(Table);
Ans.parameter=[];
Anses=repmat(Ans,1,n);
for i=1:n
    Number=max(Table(:,i));
    Anses(i).parameter=zeros(Number,1);
    for j=1:Number
        Find=find(Table(:,i)==j);
        Anses(i).parameter(j)=(mean(input(Find)));
    end    
    Anses(i).parameter
    subplot(2,ceil(sqrt(n)),i);    
    plot(Anses(i).parameter,'-bs');
    title(['parametr ( ' num2str(i) ' )']);    
end
Ans=zeros(1,n);
for i=1:n
    [temp Ans(i)]=min(Anses(i).parameter);
end
end

