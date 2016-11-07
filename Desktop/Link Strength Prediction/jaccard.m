%w(i) is the Jaccard index for friends(i) and target
clear w
target=2963;
S=ADJ^2;
friends=find(ADJ(target,:));
for i=1:length(friends)
w(i)=S(target,friends(i))/(S(target,target)+S(friends(i),friends(i))-S(target,friends(i)));
end
prediction=tiedrank(-w);
actual=tiedrank(-ADJ1(target,find(ADJ(target,:))));
actual(find(prediction<10.5))
nnz(find(prediction<10.5))
nnz(find(actual<10.5))
nnz(find(ADJ(target,:)))
