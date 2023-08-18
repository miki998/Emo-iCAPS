%% 1. Parameters to be entered by the user
% General data information
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Path where we have our data stored 
param.PathData = '/media/miplab-nas2/Data2/Movies_Emo/Preprocessed_data/';
%param.PathData = '/Volumes/Data2/Movies_Emo/Preprocessed_data/';
 
 
% TR of the data
param.TR = 1.3;
 
 
% Links towards the data of all subjects to analyze
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% List of subjects on which to run total activation (must be a cell array
% with all group/subject names). This is where the TA folder will be
% created (or looked for) for each subject
param.ID = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S13','S14','S15','S16',...
            'S17','S19','S20','S21','S22','S23','S24','S25','S26','S27','S28','S29','S30','S31','S32'};
  
param.Ses = {'1','2','3','4','5'}; %,'2','3','4'};%,},
  
for i = 1:(length(param.ID))
    for j = 1:(length(param.Ses))
        if i == 1 && j == 1    
            param.Subjects = glob(strcat(param.PathData,'sub-',param.ID{i},'/ses-', param.Ses{j},'/*.feat/'));
        else 
            param.Subjects = [param.Subjects;glob(strcat(param.PathData,'sub-',param.ID{i},'/ses-', param.Ses{j},'/*.feat/'))];
        end
    end
    
end
 

% Number of subjects considered
param.n_subjects = length(param.Subjects);
 
% Title that we wish to give to this specific run of the scripts for saving
% data, or that was used previously for first steps and that we wish to
% build on now
param.title = 'TA_Sep22';
