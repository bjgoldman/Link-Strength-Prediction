function [ inverse ] = tree_inverse_plus1( T )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

graph_size=length(T);
inverse=sparse(graph_size,graph_size);
S=spones(T);
S2=S^2;
indices=find(sum(S)==1);
[i,j,s]=find(T(:,indices));
j=indices(j);
check_inverted=zeros(1,graph_size);
check_queue=zeros(1,graph_size);
queue=[];

for k=1:length(i)
    if check_queue(i(k))==0&&check_inverted(i(k))==0
        inverse(j(k),i(k))=1/s(k);
        check_inverted(i(k))=1;
        add=find(S2(:,i(k)));
        for l=1:length(add)
            if check_queue(add(l))==0&&check_inverted(add(l))==0
                queue=[queue add(l)];
                check_queue(add(l))=1;
            end
        end
    end
end

k=1;
len=length(queue);
while k<=len
    neighbors=find(S(:,queue(k)));
    for l=1:length(neighbors)
        neighbors2=find(S(:,neighbors(l)));
        if sum(check_inverted(neighbors2))==length(neighbors2)-1
            inverse(:,queue(k))=-sum(inverse(:,neighbors2)*T(neighbors2,neighbors(l)),2)/T(queue(k),neighbors(l));
            inverse(neighbors(l),queue(k))=inverse(neighbors(l),queue(k))+1/T(queue(k),neighbors(l));

            check_inverted(queue(k))=1;
            add=find(S2(:,queue(k)));
            for p=1:length(add)
                if check_queue(add(p))==0&&check_inverted(add(p))==0
                    queue=[queue add(p)];
                    len=len+1;
                    check_queue(add(p))=1;
                end
            end
            
            break
        end
    end
    check_queue(queue(k))=0;
    
    k=k+1;
end


remaining=find(1-check_inverted);
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

 

