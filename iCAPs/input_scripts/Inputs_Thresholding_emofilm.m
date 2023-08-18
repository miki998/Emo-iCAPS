%% 1. Parameters to be entered by the user
% General data information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Path where we have our data stored 
param.PathData = '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/';
%param.PathData = '/Volumes/Data2/Movies_Emo/Preprocessed_data/';
 
 
% TR of the data
param.TR = 1.3;
 
 
% Links towards the data of all subjects to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% List of subjects on which to run total activation (must be a cell array
% with all group/subject names). This is where the TA folder will be
% created (or looked for) for each subject
param.ID = {'S01'}
  
param.Ses = {'1','2','3','4'}; %,'2','3','4'};%,},
  
param.Subjects = {'/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_BigBuckBunny.feat/' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_Rest.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_FirstBite.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_YouAgain.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_TheSecretNumber.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_AfterTheRain.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_Payload.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_LessonLearned.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_BetweenViewings.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_ToClaireFromSonny.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_Spaceman.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_Chatter.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-4/pp_sub-S01_ses-4_Sintel.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-4/pp_sub-S01_ses-4_TearsOfSteel.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-4/pp_sub-S01_ses-4_Superhero.feat'}

% Number of subjects considered
param.n_subjects = length(param.Subjects);
 
% Title that we wish to give to this specific run of the scripts for saving
% data, or that was used previously for first steps and that we wish to
% build on now
param.title = 'iCAPS_Emo';
