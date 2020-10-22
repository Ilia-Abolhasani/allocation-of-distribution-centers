function y=Keshtel_Swirl(LuckyKeshtel,Nearest,S,Smax)

D=LuckyKeshtel.Position- Nearest.Position;

if(mod(S,2)==0) 
    y=Nearest.Position+floor(S/2)*(D/Smax);
    
else    
    y=(Nearest.Position+2*D)-floor(S/2)*(D/Smax);    
end

end
