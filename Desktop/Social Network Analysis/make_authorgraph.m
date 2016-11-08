%Create Authorship Adjacency Matrix:

%A is paperlist.
%For each pair of authors j,k in paper i, we set X(l)=j and Y(l)=k for some
%l.
A=importdata(output.txt);
l=1;
for i=1:length(A)
    D=A(i,:);
    if nnz(D)<4
    D=unique(D,'stable');
for j=1:nnz(D)
for k=j+1:nnz(D)
X(l)=D(j);
Y(l)=D(k);
ONES(l)=1;
l=l+1;
X(l)=D(k);
Y(l)=D(j);
ONES(l)=1;
l=l+1;
end
end
    end
end
%Create weighted adjancecy matrix using vectors X,Y as lists of coordinate
%pairs.
ADJ1= sparse(X,Y,ONES, 34740 , 34740 ,length(ONES));
ADJ=spones(ADJ1);