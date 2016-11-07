function [ SDJ ] = make_local( ADJ,target )
%Creates neighborhood adjacency matrix
SDJ=spones(ADJ);
SDJ=SDJ-diag(diag(SDJ));
dist=graphshortestpath(SDJ,target);
far=find(dist>1);
SDJ(far,:)=0;
SDJ(:,far)=0;
end

