function [ importa ] = relative_import( ADJ,target )
%Finds neighborhood around target
ADJ1=make_local(spones(ADJ), target);
%Make neighborhood adjacency matrix column stochastic
z=sparse(1,length(ADJ1));
for i=1:length(ADJ1)
z(i)=i;
end
col=1./sum(ADJ1);
scaler=sparse(z,z,col);
ADJ1=ADJ1*scaler;
importa=z;
for i=1:length(ADJ1)
importa(i)=1;
end
importa=transpose(importa);
%Multiply ones vector by column stochastic matrix repeatedly
for i=1:50
    importa=ADJ1*importa;
end
end

