%% 1. Parameters to be entered by the user

% General data information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Path where we have our data stored 
param.PathData = '/media/miplab-nas2/Data2/Movies_Emo/Michael/DATA/fmri_tcs/';
% param.PathData = '/Volumes/Data2/Movies_Emo/Preprocessed_data/';
 
 
% TR of the data
param.TR = 1.3;
 
 
% Links towards the data of all subjects to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% List of subjects on which to run total activation (must be a cell array
% with all group/subject names). This is where the TA folder will be
% created (or looked for) for each subject
param.ID = {'S01'};%'S01'}%,'S02','S03', missing 3 ses 4
  
param.Ses = {'1','2','3','4','5'};%,},'1','2','3',

param.Subjects = {'/sub-S13/ses-1/pp_sub-S13_ses-1_AfterTheRain.feat/', '/sub-S13/ses-1/pp_sub-S13_ses-1_Sintel.feat/', '/sub-S13/ses-2/pp_sub-S13_ses-2_Payload.feat/', '/sub-S13/ses-2/pp_sub-S13_ses-2_BigBuckBunny.feat/', '/sub-S13/ses-2/pp_sub-S13_ses-2_TearsOfSteel.feat/', '/sub-S13/ses-3/pp_sub-S13_ses-3_ToClaireFromSonny.feat/', '/sub-S13/ses-3/pp_sub-S13_ses-3_BetweenViewings.feat/', '/sub-S13/ses-4/pp_sub-S13_ses-4_FirstBite.feat/', '/sub-S13/ses-1/pp_sub-S13_ses-1_Rest.feat/', '/sub-S13/ses-3/pp_sub-S13_ses-3_Spaceman.feat/', '/sub-S13/ses-3/pp_sub-S13_ses-3_Chatter.feat/', '/sub-S13/ses-4/pp_sub-S13_ses-4_Superhero.feat/', '/sub-S13/ses-1/pp_sub-S13_ses-1_YouAgain.feat/', '/sub-S13/ses-4/pp_sub-S13_ses-4_TheSecretNumber.feat/', '/sub-S13/ses-1/pp_sub-S13_ses-1_LessonLearned.feat/'} 
% param.Subjects = {'sub-S05/ses-1/pp_sub-S05_ses-1_BigBuckBunny.feat/' ,  'sub-S05/ses-1/pp_sub-S05_ses-1_Rest.feat'}

% param.Subjects = {'/sub-S02/ses-1/pp_sub-S02_ses-1_Rest.feat/', '/sub-S02/ses-2/pp_sub-S02_ses-2_Chatter.feat/', '/sub-S02/ses-1/pp_sub-S02_ses-1_YouAgain.feat/', '/sub-S02/ses-2/pp_sub-S02_ses-2_BigBuckBunny.feat/', '/sub-S02/ses-3/pp_sub-S02_ses-3_LessonLearned.feat/', '/sub-S02/ses-2/pp_sub-S02_ses-2_TheSecretNumber.feat/', '/sub-S02/ses-3/pp_sub-S02_ses-3_BetweenViewings.feat/', '/sub-S02/ses-1/pp_sub-S02_ses-1_TearsOfSteel.feat/', '/sub-S02/ses-4/pp_sub-S02_ses-4_Spaceman.feat/', '/sub-S02/ses-4/pp_sub-S02_ses-4_Sintel.feat/', '/sub-S02/ses-1/pp_sub-S02_ses-1_AfterTheRain.feat/', '/sub-S02/ses-4/pp_sub-S02_ses-4_FirstBite.feat/', '/sub-S02/ses-4/pp_sub-S02_ses-4_ToClaireFromSonny.feat/', '/sub-S02/ses-3/pp_sub-S02_ses-3_Payload.feat/', '/sub-S02/ses-2/pp_sub-S02_ses-2_Superhero.feat/'}

% param.Subjects = {'/sub-S03/ses-3/pp_sub-S03_ses-3_Sintel.feat/', '/sub-S03/ses-2/pp_sub-S03_ses-2_BetweenViewings.feat/', '/sub-S03/ses-1/pp_sub-S03_ses-1_Payload.feat/', '/sub-S03/ses-2/pp_sub-S03_ses-2_TheSecretNumber.feat/', '/sub-S03/ses-1/pp_sub-S03_ses-1_Rest.feat/', '/sub-S03/ses-2/pp_sub-S03_ses-2_Superhero.feat/', '/sub-S03/ses-3/pp_sub-S03_ses-3_TearsOfSteel.feat/', '/sub-S03/ses-4/pp_sub-S03_ses-4_ToClaireFromSonny.feat/', '/sub-S03/ses-4/pp_sub-S03_ses-4_BigBuckBunny.feat/', '/sub-S03/ses-3/pp_sub-S03_ses-3_AfterTheRain.feat/', '/sub-S03/ses-2/pp_sub-S03_ses-2_LessonLearned.feat/', '/sub-S03/ses-1/pp_sub-S03_ses-1_Spaceman.feat/', '/sub-S03/ses-4/pp_sub-S03_ses-4_Chatter.feat/', '/sub-S03/ses-3/pp_sub-S03_ses-3_FirstBite.feat/', '/sub-S03/ses-4/pp_sub-S03_ses-4_YouAgain.feat/'}


% param.Subjects = {'/sub-S04/ses-2/pp_sub-S04_ses-2_Spaceman.feat/', '/sub-S04/ses-3/pp_sub-S04_ses-3_LessonLearned.feat/', '/sub-S04/ses-3/pp_sub-S04_ses-3_AfterTheRain.feat/', '/sub-S04/ses-4/pp_sub-S04_ses-4_FirstBite.feat/', '/sub-S04/ses-1/pp_sub-S04_ses-1_Rest.feat/', '/sub-S04/ses-3/pp_sub-S04_ses-3_Chatter.feat/', '/sub-S04/ses-2/pp_sub-S04_ses-2_YouAgain.feat/', '/sub-S04/ses-2/pp_sub-S04_ses-2_ToClaireFromSonny.feat/', '/sub-S04/ses-1/pp_sub-S04_ses-1_TearsOfSteel.feat/', '/sub-S04/ses-2/pp_sub-S04_ses-2_Sintel.feat/', '/sub-S04/ses-4/pp_sub-S04_ses-4_Superhero.feat/', '/sub-S04/ses-4/pp_sub-S04_ses-4_Payload.feat/', '/sub-S04/ses-3/pp_sub-S04_ses-3_BigBuckBunny.feat/', '/sub-S04/ses-1/pp_sub-S04_ses-1_TheSecretNumber.feat/', '/sub-S04/ses-1/pp_sub-S04_ses-1_BetweenViewings.feat/'}


% Number of subjects considered
param.n_subjects = length(param.Subjects);

% Title that we wish to give to this specific run of the scripts for saving
% data, or that was used previously for first steps and that we wish to
% build on now
param.title = 'iCAPS_Emo';

% name of the iCAPs output for this data
% if only a subset of subjects should be included in the clustering, this
% can be useful to save those different runs in different folders
param.data_title = [param.title '_Movies_sub-S13'];


% information about which TA data should be used for clustering:
% thresholding information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Alpha-level at which to look for significance of innovation signal frames
% (first element is the percentile of the lower threshold - negative
% innovations - and second element the upper threshold one - positive
% innovations)
param.alpha = [5 95];

% Fraction of voxels from the ones entering total activation for a given 
% subject that should show an innovation at the same time point, so that
% the corresponding frame is retained for iCAPs clustering
param.f_voxels = 5/100;

% Title used to create the folder where thresholding data will be saved
param.thresh_title = ['Alpha_',strrep(num2str(param.alpha(1)),'.','DOT'),'_',...
    strrep(num2str(param.alpha(2)),'.','DOT'),'_Fraction_',...
    strrep(num2str(param.f_voxels),'.','DOT')];


