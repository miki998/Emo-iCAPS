clc;clear all;close all;

ids = {'S02', 'S03', 'S04', 'S05', 'S06', 'S07', 'S08', 'S09', 'S10', 'S11', 'S13', 'S14', 'S15', 'S16'}
for c = 1:length(ids);

	load(strcat('./costmatrices/costmatS01-', ids{c}, '.mat'));


	[assignment, cost] = munkres(cmat);
	save(strcat('./results/assignmentS01-', ids{c},'.mat'), 'assignment','-v7.3');
	save(strcat('./results/costS01-', ids{c},'.mat'), 'cost', '-v7.3');
end;

