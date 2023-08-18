clc;clear all;close all;


load('./costmatrices/costmatS01-S05.mat');
display(who)
[assignment, cost] = munkres(cmat);
save('results/assignmentS01-S05.mat', 'assignment','-v7.3');
save('results/costS01-S05.mat', 'cost', '-v7.3');


