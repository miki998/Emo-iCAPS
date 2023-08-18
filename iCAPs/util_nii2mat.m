clc;clear all;close all;

AddPaths();
addpath('');

% Paths defining

% Path for SignInnov files and mask_nonan
% paths = {'/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-4/pp_sub-S13_ses-4_Superhero.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-2/pp_sub-S13_ses-2_Payload.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_BetweenViewings.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_LessonLearned.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-4/pp_sub-S13_ses-4_FirstBite.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_Chatter.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-4/pp_sub-S13_ses-4_TheSecretNumber.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_ToClaireFromSonny.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-2/pp_sub-S13_ses-2_TearsOfSteel.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-2/pp_sub-S13_ses-2_BigBuckBunny.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_Rest.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_Sintel.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_AfterTheRain.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_Spaceman.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_YouAgain.feat/TA_results/iCAPS_Emo/Thresholding/Alpha_5_95_Fraction_0DOT05'}

% Path for Activity_inducing.nii
% paths = {'/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_Rest.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-2/pp_sub-S13_ses-2_Payload.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_Spaceman.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_YouAgain.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_Chatter.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-2/pp_sub-S13_ses-2_TearsOfSteel.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-4/pp_sub-S13_ses-4_Superhero.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_BetweenViewings.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-2/pp_sub-S13_ses-2_BigBuckBunny.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_LessonLearned.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-4/pp_sub-S13_ses-4_FirstBite.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-4/pp_sub-S13_ses-4_TheSecretNumber.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_AfterTheRain.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_Sintel.feat/TA_results/iCAPS_Emo/TotalActivation/', '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-3/pp_sub-S13_ses-3_ToClaireFromSonny.feat/TA_results/iCAPS_Emo/TotalActivation/'}
paths = {'/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S13/ses-1/pp_sub-S13_ses-1_Rest.feat/TA_results/iCAPS_Emo/TotalActivation/'}
n_fold = length(paths);

modality = 'Activity_inducing';

for k=1:n_fold
	folderPath = paths{k};
	fPath1 = fullfile(folderPath, strcat(modality, '_MNI.nii.gz'));
	fPath2 = fullfile(folderPath, strcat(modality, '_MNI.nii'));
	outPath = fullfile(folderPath, strcat(modality, '_MNI'));
	[Activity_inducing, tmp_param] = nii2matfunc(fPath1, fPath2, folderPath);
	
	% paramPath = fullfile(folderPath, 'param.mat');
	% newparamPath = fullfile(folderPath, 'param_MNI.mat');
 	% load(paramPath);
	% param.mask = logical(tmp_param.mask)';
	% b = tmp_param.mask;
	% b(isnan(b)) = 0;
	% b = fillmissing(tmp_param.mask, 'constant', 0)
	% param.mask_nonan = logical(b);
	% param.mask2_nonan = mask_nonan;	
	% load(fullfile(folderPath, 'SignInnov_MNI.mat'));
	% tmp = SignInnov;
	% n_vol = size(tmp,1);
	% SignInnov = nan(n_vol,sum(param.mask_nonan));
	% for t = 1:n_vol
	% 	SignInnov(t,:) = tmp(t,param.mask_nonan);
	% end
	% save(fullfile(folderPath, 'SignInnov_MNI.mat'), 'SignInnov', '-v7.3');
	% save(newparamPath, 'param', '-v7.3');
	
	save(outPath, 'Activity_inducing','-v7.3');
	% save(outPath, 'SignInnov', '-v7.3');
end


