function [ T ] = make_tree( n )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
ADJ=sparse(n,n);
NODES=ones(1,n);
NODES(1)=0;
current_node=1;
rng('shuffle');
while(~isequal(NODES,zeros(1,n)))    
new_node=randi(n);
if new_node>current_node
    ADJ(new_node,current_node)=1;
end
if new_node<current_node
    ADJ(current_node,new_node)=1;
end
NODES(new_node)=0;
current_node=new_node;
end
%Track non-zero indices in ADJ
edge_indices=find(ADJ);
%Choose edges costs from discrete uniform[0,5] distribution.
for i=1:length(edge_indices)
    COST(i)=rand(1);
end
A=ADJ;
A=A+A';
[i j p]=find(A);
p=1./p;
Ainv=sparse(i, j, p,size(A,1),size(A,2));
[STinv,pred] = graphminspantree(Ainv);
[k l m]=find(STinv);
m=1./m;
ST=sparse(k, l, m,size(A,1),size(A,2));
T=ST+ST';
end

