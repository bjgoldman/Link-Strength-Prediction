function [ importa ] = overall_import( ADJ )
%Make neighborhood adjacency matrix column stochastic
ADJ=spones(ADJ);
z=sparse(1,length(ADJ));
for i=1:length(ADJ)
z(i)=i;
end
col=1./sum(ADJ);
scaler=sparse(z,z,col);
ADJ=ADJ*scaler;
importa=z;
for i=1:length(ADJ)
importa(i)=1;
end
importa=transpose(importa);
%Multiply ones vector by column stochastic matrix repeatedly
for i=1:50
    importa=ADJ1*importa;
end
end



