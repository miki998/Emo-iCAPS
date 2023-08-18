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
% {'S17','S19','S20','S21','S22','S23','S24','S25','S26','S27','S28','S29','S30','S31','S32'}; %,};
  
param.Ses = {'1','2','3','4'};

param.Subjects = {'/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_BigBuckBunny.feat/'}
% param.Subjects = {'/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_BigBuckBunny.feat/' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_Rest.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_FirstBite.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-1/pp_sub-S01_ses-1_YouAgain.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_TheSecretNumber.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_AfterTheRain.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_Payload.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-2/pp_sub-S01_ses-2_LessonLearned.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_BetweenViewings.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_ToClaireFromSonny.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_Spaceman.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-3/pp_sub-S01_ses-3_Chatter.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-4/pp_sub-S01_ses-4_Sintel.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-4/pp_sub-S01_ses-4_TearsOfSteel.feat' ,  '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/sub-S01/ses-4/pp_sub-S01_ses-4_Superhero.feat'}

% Number of subjects considered
param.n_subjects = length(param.Subjects);
 
% Title that we wish to give to this specific run of the scripts for saving
% data, or that was used previously for first steps and that we wish to
% build on now
param.title = 'iCAPS_Emo';

% Information about the folders where to retrieve functional and structural
% data of relevance for the pipeline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% In all cases, if only one name is given for any variable, the name is
% assumed to be the same across subjects. If there is as many names as
% there is subjects, then the name is assumed to differ across subjects. If
% a [] is provided (e.g. for a folder where to access data), then it is 
% assumed that the data lies within the main path itself without any
% additional subpath


% Name of the folder containing the functional data (if void, will directly
% look into the subject folder itself)
param.Folder_functional = '';
param.TA_func_prefix = 'filtered_func_data_res_';

% Folder where we can find the probabilistic Gray Matter maps for each
% subject
param.Folder_GM = 'reg';
param.TA_gm_prefix = 'highres_pve_1_regfunc';


% Information related to GM mask
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Threshold at which we want to threshold the probabilistic gray matter map
% (values larger than this only will be included in the mask); has to lie
% between 0 and 1
param.T_gm = 0.3;

% select if morphological operations (opening and closure) should be
% run on the GM mask to remove wholes, and if yes, specify the size (in
% voxels) for opening and closing operators
param.is_morpho=0;
param.n_morpho_voxels=2;



% Information related to functional preprocessing (skipping scans,
% scubbing, filtering)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of scans to discard due to T1 equilibration effects
param.skipped_scans = 0;


% select if detrending shovuld be run on the data, if set to 0 the fields
% 'DCT_TS' and 'Covariates' do not need to be set
param.doDetrend=1;
param.doNormalize =1;

% Detrending information: cut-off period for the DCT basis (for example,
% 128 means a cutoff of 1/128 = 0.0078 [Hz], and covariates to add (should
% be provided each as a column of 'Covariates')
param.DCT_TS = 128; 
param.Covariates = [];



% select if scrubbing should be run on the data, if 0 the fields
% 'Folder_motion', 'TA_mot_prefix', 'skipped_scans_motionfile',
% 'FD_method', 'FD_threshold' and 'interType' do not need to be set
param.doScrubbing=1;

% Folder where motion data from SPM realignment is stored, if motion data
% is taken from another programm than SPM, a text file with the 6 motion
% parameters (3 translational in mm + 3 rotational in rad) should be set as
% input here
%%% This has been edited for fsl output of 3 rotational in rad + 3
%%% translational in mm, edit is in AssessMotion.m line 70 (commented)
param.Folder_motion = param.Folder_functional;
param.TA_mot_prefix = 'prefiltered_func_data_mcf';

% Number of lines to ignore at the beginning of the motion file, if empty
% or not set, this will be equal to param.skipped_scans
param.skipped_scans_motionfile = []; 

% Motion information: type of method to use to quantify motion (choose
% between 'Power' and ), and threshold of displacement to use for each
% frame (in [mm])
param.FD_method = 'Power';
param.FD_threshold = 0.5;

% Interpolation method (i.e. 'spline' or 'linear', see interp1 for all 
% possibilities) - default (if []) is 'spline'
param.interType='spline';
