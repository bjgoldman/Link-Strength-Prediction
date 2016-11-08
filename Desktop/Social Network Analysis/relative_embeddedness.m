%p(i) is the number of friendships between mutual friends of friends(i) and
%target.

clearvars -except ADJ ADJ1
target=311;
friends=find(ADJ(target,:));
for i=1:length(friends)
p(i)=sum(sum(make_local(ADJ,target).*make_local(ADJ,friends(i))))/2;
i
end
friends1=find(p);
t=p(friends1);
for i=1:length(friends1)
s(i)=nnz(ADJ(friends(friends1(i)),:));
end
x=tiedrank(-s);
y=tiedrank(-t);
c=log(x)-log(y);
prediction=tiedrank(-c);
actual=tiedrank(-ADJ1(target,find(ADJ(target,:))));
actual(friends1(find(prediction<10.5)))
nnz(find(prediction<10.5))
nnz(find(actual<10.5))
nnz(find(ADJ(target,:)))