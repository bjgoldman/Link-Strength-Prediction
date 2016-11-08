function [ y ] = ti2aux( index , matsize, dim )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
length=matsize^(1/dim);
coord_vector=zeros(1,dim);
%{
for(i = 0:dim-1)
    coord_vector(i+1)=mod(floor((index-1)/(length^i)),length);
end
%}
coord_vector1=mod(floor((index-1)/(length^0)),length)+1;
coord_vector2=mod(floor((index-1)/(length^1)),length)+1;
y=[coord_vector1 coord_vector2];