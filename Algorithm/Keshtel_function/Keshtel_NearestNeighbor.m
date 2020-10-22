function y=Keshtel_NearestNeighbor(LuckyKeshtel,Keshtel)

       N=numel(Keshtel);
       d=zeros(1,N);
       
       for j=1:N
           d(j)=sum(abs(LuckyKeshtel-Keshtel(j).Position));
       end
       
       [e,r]=min(d);
       y=Keshtel(r);
       
end