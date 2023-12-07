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

param.Subjects = {'/sub-S32/ses-1/pp_sub-S32_ses-1_YouAgain.feat/', '/sub-S32/ses-3/pp_sub-S32_ses-3_Payload.feat/', '/sub-S32/ses-1/pp_sub-S32_ses-1_Rest.feat/', '/sub-S32/ses-2/pp_sub-S32_ses-2_Spaceman.feat/', '/sub-S32/ses-1/pp_sub-S32_ses-1_BetweenViewings.feat/', '/sub-S32/ses-1/pp_sub-S32_ses-1_ToClaireFromSonny.feat/', '/sub-S32/ses-3/pp_sub-S32_ses-3_LessonLearned.feat/', '/sub-S32/ses-3/pp_sub-S32_ses-3_Chatter.feat/', '/sub-S32/ses-4/pp_sub-S32_ses-4_Superhero.feat/', '/sub-S32/ses-4/pp_sub-S32_ses-4_TheSecretNumber.feat/', '/sub-S32/ses-2/pp_sub-S32_ses-2_FirstBite.feat/', '/sub-S32/ses-4/pp_sub-S32_ses-4_BigBuckBunny.feat/', '/sub-S32/ses-3/pp_sub-S32_ses-3_Sintel.feat/', '/sub-S32/ses-2/pp_sub-S32_ses-2_AfterTheRain.feat/', '/sub-S32/ses-2/pp_sub-S32_ses-2_TearsOfSteel.feat/'}

% param.Subjects = {'/sub-S30/ses-1/pp_sub-S30_ses-1_Superhero.feat/', '/sub-S30/ses-4/pp_sub-S30_ses-4_Payload.feat/', '/sub-S30/ses-2/pp_sub-S30_ses-2_FirstBite.feat/', '/sub-S30/ses-2/pp_sub-S30_ses-2_BigBuckBunny.feat/', '/sub-S30/ses-1/pp_sub-S30_ses-1_LessonLearned.feat/', '/sub-S30/ses-1/pp_sub-S30_ses-1_Rest.feat/', '/sub-S30/ses-2/pp_sub-S30_ses-2_Chatter.feat/', '/sub-S30/ses-4/pp_sub-S30_ses-4_TearsOfSteel.feat/', '/sub-S30/ses-4/pp_sub-S30_ses-4_ToClaireFromSonny.feat/', '/sub-S30/ses-3/pp_sub-S30_ses-3_Spaceman.feat/', '/sub-S30/ses-3/pp_sub-S30_ses-3_YouAgain.feat/', '/sub-S30/ses-2/pp_sub-S30_ses-2_BetweenViewings.feat/', '/sub-S30/ses-4/pp_sub-S30_ses-4_TheSecretNumber.feat/', '/sub-S30/ses-3/pp_sub-S30_ses-3_Sintel.feat/', '/sub-S30/ses-2/pp_sub-S30_ses-2_AfterTheRain.feat/'}

% param.Subjects = {'/sub-S28/ses-2/pp_sub-S28_ses-2_LessonLearned.feat/', '/sub-S28/ses-4/pp_sub-S28_ses-4_ToClaireFromSonny.feat/', '/sub-S28/ses-2/pp_sub-S28_ses-2_Sintel.feat/', '/sub-S28/ses-3/pp_sub-S28_ses-3_YouAgain.feat/', '/sub-S28/ses-4/pp_sub-S28_ses-4_TheSecretNumber.feat/', '/sub-S28/ses-3/pp_sub-S28_ses-3_BigBuckBunny.feat/', '/sub-S28/ses-3/pp_sub-S28_ses-3_AfterTheRain.feat/', '/sub-S28/ses-2/pp_sub-S28_ses-2_Payload.feat/', '/sub-S28/ses-1/pp_sub-S28_ses-1_Rest.feat/', '/sub-S28/ses-5/pp_sub-S28_ses-5_Superhero.feat/', '/sub-S28/ses-3/pp_sub-S28_ses-3_TearsOfSteel.feat/', '/sub-S28/ses-2/pp_sub-S28_ses-2_Chatter.feat/', '/sub-S28/ses-1/pp_sub-S28_ses-1_Spaceman.feat/', '/sub-S28/ses-1/pp_sub-S28_ses-1_FirstBite.feat/', '/sub-S28/ses-1/pp_sub-S28_ses-1_BetweenViewings.feat/'}

% param.Subjects = {'/sub-S27/ses-1/pp_sub-S27_ses-1_LessonLearned.feat/', '/sub-S27/ses-4/pp_sub-S27_ses-4_AfterTheRain.feat/', '/sub-S27/ses-2/pp_sub-S27_ses-2_TearsOfSteel.feat/', '/sub-S27/ses-3/pp_sub-S27_ses-3_BetweenViewings.feat/', '/sub-S27/ses-1/pp_sub-S27_ses-1_Rest.feat/', '/sub-S27/ses-4/pp_sub-S27_ses-4_Payload.feat/', '/sub-S27/ses-2/pp_sub-S27_ses-2_Sintel.feat/', '/sub-S27/ses-4/pp_sub-S27_ses-4_Spaceman.feat/', '/sub-S27/ses-3/pp_sub-S27_ses-3_YouAgain.feat/', '/sub-S27/ses-1/pp_sub-S27_ses-1_ToClaireFromSonny.feat/', '/sub-S27/ses-2/pp_sub-S27_ses-2_Superhero.feat/', '/sub-S27/ses-2/pp_sub-S27_ses-2_Chatter.feat/', '/sub-S27/ses-1/pp_sub-S27_ses-1_FirstBite.feat/', '/sub-S27/ses-4/pp_sub-S27_ses-4_BigBuckBunny.feat/', '/sub-S27/ses-3/pp_sub-S27_ses-3_TheSecretNumber.feat/'}

% param.Subjects = {'/sub-S25/ses-4/pp_sub-S25_ses-4_LessonLearned.feat/', '/sub-S25/ses-1/pp_sub-S25_ses-1_Payload.feat/', '/sub-S25/ses-2/pp_sub-S25_ses-2_Spaceman.feat/', '/sub-S25/ses-3/pp_sub-S25_ses-3_Sintel.feat/', '/sub-S25/ses-4/pp_sub-S25_ses-4_Superhero.feat/', '/sub-S25/ses-3/pp_sub-S25_ses-3_ToClaireFromSonny.feat/', '/sub-S25/ses-3/pp_sub-S25_ses-3_BetweenViewings.feat/', '/sub-S25/ses-1/pp_sub-S25_ses-1_YouAgain.feat/', '/sub-S25/ses-1/pp_sub-S25_ses-1_Rest.feat/', '/sub-S25/ses-2/pp_sub-S25_ses-2_BigBuckBunny.feat/', '/sub-S25/ses-4/pp_sub-S25_ses-4_FirstBite.feat/', '/sub-S25/ses-4/pp_sub-S25_ses-4_AfterTheRain.feat/', '/sub-S25/ses-2/pp_sub-S25_ses-2_TheSecretNumber.feat/', '/sub-S25/ses-2/pp_sub-S25_ses-2_TearsOfSteel.feat/', '/sub-S25/ses-3/pp_sub-S25_ses-3_Chatter.feat/'}


% param.Subjects = {'/sub-S22/ses-2/pp_sub-S22_ses-2_Chatter.feat/', '/sub-S22/ses-1/pp_sub-S22_ses-1_Superhero.feat/', '/sub-S22/ses-1/pp_sub-S22_ses-1_Rest.feat/', '/sub-S22/ses-3/pp_sub-S22_ses-3_TearsOfSteel.feat/', '/sub-S22/ses-4/pp_sub-S22_ses-4_Payload.feat/', '/sub-S22/ses-4/pp_sub-S22_ses-4_AfterTheRain.feat/', '/sub-S22/ses-3/pp_sub-S22_ses-3_YouAgain.feat/', '/sub-S22/ses-2/pp_sub-S22_ses-2_BetweenViewings.feat/', '/sub-S22/ses-3/pp_sub-S22_ses-3_Sintel.feat/', '/sub-S22/ses-2/pp_sub-S22_ses-2_LessonLearned.feat/', '/sub-S22/ses-3/pp_sub-S22_ses-3_FirstBite.feat/', '/sub-S22/ses-4/pp_sub-S22_ses-4_BigBuckBunny.feat/', '/sub-S22/ses-1/pp_sub-S22_ses-1_Spaceman.feat/', '/sub-S22/ses-4/pp_sub-S22_ses-4_TheSecretNumber.feat/', '/sub-S22/ses-1/pp_sub-S22_ses-1_ToClaireFromSonny.feat/'}
% param.Subjects = {'/sub-S21/ses-4/pp_sub-S21_ses-4_Sintel.feat/', '/sub-S21/ses-2/pp_sub-S21_ses-2_ToClaireFromSonny.feat/', '/sub-S21/ses-1/pp_sub-S21_ses-1_Rest.feat/', '/sub-S21/ses-2/pp_sub-S21_ses-2_TearsOfSteel.feat/', '/sub-S21/ses-2/pp_sub-S21_ses-2_Chatter.feat/', '/sub-S21/ses-3/pp_sub-S21_ses-3_TheSecretNumber.feat/', '/sub-S21/ses-3/pp_sub-S21_ses-3_Spaceman.feat/', '/sub-S21/ses-4/pp_sub-S21_ses-4_FirstBite.feat/', '/sub-S21/ses-1/pp_sub-S21_ses-1_Superhero.feat/', '/sub-S21/ses-3/pp_sub-S21_ses-3_BetweenViewings.feat/', '/sub-S21/ses-4/pp_sub-S21_ses-4_BigBuckBunny.feat/', '/sub-S21/ses-1/pp_sub-S21_ses-1_YouAgain.feat/', '/sub-S21/ses-4/pp_sub-S21_ses-4_Payload.feat/', '/sub-S21/ses-2/pp_sub-S21_ses-2_LessonLearned.feat/', '/sub-S21/ses-2/pp_sub-S21_ses-2_AfterTheRain.feat/'}


% param.Subjects = {'/sub-S17/ses-2/pp_sub-S17_ses-2_LessonLearned.feat/', '/sub-S17/ses-4/pp_sub-S17_ses-4_Sintel.feat/', '/sub-S17/ses-2/pp_sub-S17_ses-2_TheSecretNumber.feat/', '/sub-S17/ses-1/pp_sub-S17_ses-1_Spaceman.feat/', '/sub-S17/ses-4/pp_sub-S17_ses-4_ToClaireFromSonny.feat/', '/sub-S17/ses-3/pp_sub-S17_ses-3_Superhero.feat/', '/sub-S17/ses-4/pp_sub-S17_ses-4_Payload.feat/', '/sub-S17/ses-2/pp_sub-S17_ses-2_AfterTheRain.feat/', '/sub-S17/ses-1/pp_sub-S17_ses-1_Chatter.feat/', '/sub-S17/ses-1/pp_sub-S17_ses-1_Rest.feat/', '/sub-S17/ses-3/pp_sub-S17_ses-3_FirstBite.feat/', '/sub-S17/ses-1/pp_sub-S17_ses-1_YouAgain.feat/', '/sub-S17/ses-4/pp_sub-S17_ses-4_BigBuckBunny.feat/', '/sub-S17/ses-2/pp_sub-S17_ses-2_TearsOfSteel.feat/', '/sub-S17/ses-3/pp_sub-S17_ses-3_BetweenViewings.feat/'}

% Number of subjects considered
param.n_subjects = length(param.Subjects);

% Title that we wish to give to this specific run of the scripts for saving
% data, or that was used previously for first steps and that we wish to
% build on now
param.title = 'iCAPS_Emo';

% name of the iCAPs output for this data
% if only a subset of subjects should be included in the clustering, this
% can be useful to save those different runs in different folders
param.data_title = [param.title '_Movies_sub-S32'];


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


