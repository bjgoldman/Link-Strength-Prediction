function [ T ] = sim_rank( ADJ )
%This version of sim_rank only calculates iterates for node pairs that form
%an edge.  If we wanted node pairs within distance n, we'd let indices=find(ADJ^n-diag(diag(ADJ^n)));
ADJ=spones(ADJ);
indices=find(ADJ);
R=speye(length(ADJ));
T=R;
%Recalculate R(i,j), where we use modular arithmetic on indices to recover
%i and j.
for p=1:8
for h=1:length(indices)
k=indices(h);
i=mod(k,length(ADJ));
if i==0
i=length(ADJ);
end
j=floor((k-1)/length(ADJ))+1;
base=nnz(ADJ(i,:))*nnz(ADJ(j,:));
if base>0
T(k)=sum(sum(R(find(ADJ(i,:)),find(ADJ(j,:)))))/base;
end
end
R=T;
T=speye(length(ADJ));
p
end
end

