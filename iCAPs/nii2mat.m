%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION
% this is an example script if TA has been run in subject space and data
% need to be normalized to MNI before continuing with the clustering part
% of the pipeline
%
% In this script, normalization will be applied using the SPM y*
% deformation fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear all;close all;
%PathData = '/Volumes/Data/EllieMo/ACT2_fsl/';
PathData = '/media/miplab-nas2/Data/EllieMo/ACT2_fsl/';
para.ID = { '001HH','002SD','003ZI','004ZS','005RC','006HE','007TB','008FP', ...
     '009RG','010AK','012CO','013JS','014SA','015TJ','016EH','017MM','018ZA', ...
     '019HB','020TW','021JA','023SS','024SJ','025TF','026SH','027JE','028GM', ...
     '030ES','031SB','032MC'};

%DONE 
para.Sess = {'NF1','NF2','NF3','NF4'}; %{'RS1','RS2'}; %

for i = 1:(length(para.ID))
    for j = 1:(length(para.Sess))
        if i == 1 && j == 1      
            para.Subjects{1} = strcat(para.ID{i},'_', para.Sess{j}, '.feat');
        else 
            para.Subjects{length(para.Subjects)+1} = strcat(para.ID{i},'_',para.Sess{j}, '.feat');
        end
    end
    
end

thresh_title = 'Alpha_5_95_Fraction_0DOT05'; % 'Alpha_2DOT5_97DOT5_Fraction_0DOT1';  %
para.title = 'TA_NF'; % 'TA_RS'; %

%% save a new param file for Thresholding and Acitivity inducing with updated information
for iS=1:length(para.Subjects)
 
    %% set paths
    subj_paths=fullfile(PathData,para.Subjects{iS})
    subj_thres_paths=fullfile(subj_paths,'TA_results',para.title,'Thresholding',thresh_title);
    subj_TA_paths=fullfile(subj_paths,'TA_results',para.title,'TotalActivation');
    subj_input_paths=fullfile(subj_paths,'TA_results',para.title,'inputData');

    out_thres=fullfile(subj_paths,'TA_results',para.title,'Thresholding',thresh_title);
    out_TA=fullfile(subj_paths,'TA_results',para.title,'TotalActivation');

    
    gunzip(fullfile(out_thres,'SignInnov_MNI.nii.gz'));
    gunzip(fullfile(out_thres,'mask_nonan_MNI.nii.gz'));
    gunzip(fullfile(out_TA,'Activity_inducing_MNI.nii.gz'));
    gunzip(fullfile(subj_input_paths,'mask_MNI.nii.gz'));
    
    fHdr=cbiReadNiftiHeader(fullfile(out_thres,'SignInnov_MNI.nii'));
    SignInnov_4D=cbiReadNifti(fullfile(out_thres,'SignInnov_MNI.nii'));
    mask_nonan_3D=cbiReadNifti(fullfile(out_thres,'mask_nonan_MNI.nii'));
    mask_nonan_3D=~isnan(mask_nonan_3D)&mask_nonan_3D~=0;
    mask_3D=cbiReadNifti(fullfile(subj_input_paths,'mask_MNI.nii'));
    mask_3D=~isnan(mask_3D)&mask_3D~=0;
    AI_4D=cbiReadNifti(fullfile(out_TA,'Activity_inducing_MNI.nii'));
    
    
    % saving modified param and SignInnov (Thresholding)
    try
        subj_thres_paths = subj_thres_paths{1};
    end
    
    load(fullfile(subj_thres_paths,'param.mat'));
    
    param.mask=reshape(mask_3D,[],1);
    param.Dimension(1)=size(mask_3D,1);
    param.Dimension(2)=size(mask_3D,2);
    param.Dimension(3)=size(mask_3D,3);
    
    param.mask_nonan=reshape(mask_nonan_3D,[],1);
    
    % these are fields that are specific for thresholding in subject space
    % and won't be required further by the pipeline
    %%%param=rmfield(param,{'PC','mask_threshold1'});
    
    
    % getting 2D innovations in MNI
    SignInnov=reshape(SignInnov_4D,[],size(SignInnov_4D,4));
    SignInnov=SignInnov(param.mask_nonan,:)';
    
    % masking normalized data
    SignInnov_4D(~repmat(mask_nonan_3D,1,1,1,size(SignInnov_4D,4)))=nan;
    
    % saving MNI data
    try 
        out_thres = out_thres{1};
    end
    
    save(fullfile(out_thres,'param.mat'),'param','-v7.3');
    save(fullfile(out_thres,'SignInnov_MNI.mat'),'SignInnov','-v7.3');
    
    hdr=cbiReadNiftiHeader(fullfile(out_thres,'SignInnov_MNI.nii'));
    cbiWriteNifti(fullfile(out_thres,'SignInnov_MNI.nii'),SignInnov_4D,hdr,'float32');
    
    try
        subj_TA_paths = subj_TA_paths{1};
    end
    
    %% saving modified param (Total Activation)
    load(fullfile(subj_TA_paths,'param.mat'));
    
    param.mask=reshape(mask_3D,[],1);
    param.mask_3D=mask_3D;
    param.Dimension(1)=size(mask_3D,1);
    param.Dimension(2)=size(mask_3D,2);
    param.Dimension(3)=size(mask_3D,3);
    param.IND=find(mask_3D);
    param.VoxelIdx=[];
    [param.VoxelIdx(:,1),param.VoxelIdx(:,2),param.VoxelIdx(:,3)]=ind2sub(size(mask_3D),param.IND);
    param.NbrVoxels=length(param.IND);
    
    % these are fields that are specific for TA in subject space
    % and won't be required further by the pipeline
    %%%param=rmfield(param,{'GM_map','fHeader',...
    %%%    'LambdaTemp','LambdaTempFin','NoiseEstimateFin'});
    
    % getting 2D innovations in MNI
    Activity_inducing=reshape(AI_4D,[],size(AI_4D,4));
    Activity_inducing=Activity_inducing(param.mask,:)';
    
    % masking normalized data
    AI_4D(~repmat(mask_3D,1,1,1,size(AI_4D,4)))=nan;
    
    % saving MNI data
    try 
        out_TA = out_TA{1};
    end
    save(fullfile(out_TA,'param.mat'),'param','-v7.3');
    save(fullfile(out_TA,'Activity_inducing_MNI.mat'),'Activity_inducing','-v7.3');
    
    hdr=cbiReadNiftiHeader(fullfile(out_TA,'Activity_inducing_MNI.nii'));
    cbiWriteNifti(fullfile(out_TA,'Activity_inducing_MNI.nii'),AI_4D,hdr,'float32');
end

