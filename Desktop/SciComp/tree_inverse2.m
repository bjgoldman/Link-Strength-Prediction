function [ inverse ] = tree_inverse2( T )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
graph_size=length(T);
inverse=sparse(graph_size,graph_size);
S=spones(T);
degree=sum(S);
d=degree;
cd=cumsum(d);
coords1=find(T);
coords2=ti2aux(coords1,graph_size^2,2);
inverted=S;
indices=find(sum(S)==1);
[i,j,s]=find(T(:,indices));
j=indices(j);
check_inverted=ones(1,graph_size);
check_queue=ones(1,graph_size);
queue=zeros(graph_size,2);
add_index=1;

for k=1:length(i)
    if check_queue(i(k))==1&&check_inverted(i(k))==1
        inverse(j(k),i(k))=1/s(k);
        neighbors=coords2(cd(i(k))-d(i(k))+1:cd(i(k)),1);
        inverted(i(k),neighbors)=0;
        check_inverted(i(k))=0;
        degree(neighbors)=degree(neighbors)-1;
        links=neighbors(degree(neighbors)==1);
        [add,sublinks,garbage]=find(inverted(:,links));
        for l=1:length(add)
            if check_queue(add(l))==1&&check_inverted(add(l))==1
                queue(add_index,:)=[add(l) links(sublinks(l))];
                add_index=add_index+1;
                check_queue(add(l))=0;
                
            end
        end
        
        
    end
end

k=1;
len=nnz(queue)/2;
while k<=len
    target=queue(k,1);
    neighbor=queue(k,2);
    neighbors2=coords2(cd(neighbor)-d(neighbor)+1:cd(neighbor),1);
    inverse(:,target)=-sum(inverse(:,neighbors2)*T(neighbors2,neighbor),2)/T(target,neighbor);
    inverse(neighbor,target)=inverse(neighbor,target)+1/T(target,neighbor);
    
    check_inverted(target)=0;
    neighbors=find(S(target,:));
    inverted(target,neighbors)=0;
    degree(neighbors)=degree(neighbors)-1;
    links=neighbors(degree(neighbors)==1);
    [add,sublinks,garbage1]=find(inverted(:,links));
    for l=1:length(add)
        if check_queue(add(l))==1&&check_inverted(add(l))==1
            queue(add_index,:)=[add(l) links(sublinks(l))];
            add_index=add_index+1;
            check_queue(add(l))=0;
            len=len+1;
            
        end
    end
    

check_queue(target)=1;

k=k+1;
end

remaining=find(check_inverted);
for p=1:length(remaining)
    neighbors=find(S(remaining(p),:));
    benefits=T(remaining(p),neighbors);
    costs=zeros(1,length(neighbors));
    for l=1:length(neighbors)
        cost_vector=T(:,neighbors(l));
        cost_vector(remaining(p))=0;
        costs(l)=norm(cost_vector);
    end
    coeff=sum((benefits.^2)./(costs.^2));
    t=1/(1+coeff);
    for l=1:length(neighbors)
        inverse(neighbors(l),remaining(p))=(benefits(l)*t)/(costs(l)^2);
    end
end



