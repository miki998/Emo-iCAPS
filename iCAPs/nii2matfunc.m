

function [fData_2D, param] = nii2matfunc(fPath1, fPath2, folderPath)
% Gunzip the nii.gz into nii files
gunzip(fPath1, folderPath);

% Load the functional volumes in nii formats
Vh = spm_vol(fPath2);
fHeader = Vh(1);
n_vol = length(Vh);

for i =1:n_vol
	fData(:,:,:,i) = spm_read_vols(Vh(i));
end

% Load the GM mask nii.gz  and generate a specific mask with it
gmpath = 'reg/standard_pve_1_mask.nii'
pHeader = spm_vol(gmpath);
pData = spm_read_vols(pHeader);

% Generate according GM Mask
param.T_gm = 0.3;
param.GM_map = pData;

[param.mask,param.mask_3D] = CreateMask(param);

% Apply the mask then flatten in the way it was done for TA
fData_2D = nan(n_vol,sum(param.mask));
for t = 1:n_vol
	tmp = squeeze(fData(:,:,:,t));
	fData_2D(t,:) = tmp(param.mask);
end

end
