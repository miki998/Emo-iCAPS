%% This function computes the time courses of activity for all the assessed iCAPs.
%
% spatio-temporal regression function
% This is an alternative to obtain the time courses, the function uses the 
% information of significant innovations to costruct the design matrix.
%
% Inputs:
%     - iCAPsResults: struct containing the necessary input data
%        .iCAPs - iCAPs maps resluting from k-means clustering (n_iCAPs x n_voxels)
%        .AI -  Activity inducing signals: n_voxels x (n_subj*n_TP) matrix of 
%               concatenated subject activity-inducing data
%        .IDX - clustering information of significant innovations frames (n_significant_innov x 1)
%        .time_labels - timing information of significant innovation frames (n_significant_innov x 1)
%        .subject_labels - subject information of significant innovation frames (n_significant_innov x 1)
%        [.dist_to_centroid] - n_significant_innov X n_iCAPs matrix with 
%               distances from all significant innovation frames to all 
%               cluster centroids (iCAPs)
%      for regression with a soft assignment factor, either
%        .dist_to_centroid, or .iCAPs_folds, or .Data are required
%        [.iCAPs_folds] - information on all clustering folds, will be used to retriev distances to cluster center:
%               .sum_dist - subfield containing the total sum of distances
%                   from all frames to theirs corresponding cluster centers
%               .dist_to_centroid {} - matrix containing distances to all
%                   cluster centers for every frame
%        [.Data] - n_voxels x n_significant_innov matrix containing all 
%               significant innovation frames; required for distance to 
%               cluster computation; requires also that the field 
%               param.dystType is specified
%     - param: structure containing necessary parameters
%        .n_subjects - number of subjects
%        [.softClusterThres] - soft assignment factor, should be larger than
%               one (1.1 to 1.25 seem to be good values, for parameter 
%               optimization run main_getNinnovStats)
%               - if the field does not exist or is empty, hard clustering 
%                 will be used for back-projection
%        [.excludeMotionFrames] - field to select whether motion frames
%               should be excluded from the regression (if scrubbing)
%        [.n_folds] - required if distances should be taken from
%               iCAPsResults.iCAPs_folds (see above)
%
% Outputs:
%     - TC: cell array with time courses for every subject
%     - stats: structure containing model fitting statistics (RSS, BIC, AIC,...)
%
% v2.0 DZ 27.10.2017 - added compatibility with scrubbed data
% v2.0 DZ 29.5.2018 - removed compatibility with scrubbed data and updated
%                   for finalized toolbox
% v3.0 AT & YF 05.05.2020 - added compatibility to very long time-courses 
%                   to reduce memory load (divide data into
%                   partitions). This is highly suggested for faster runs

function [TC,stats] = GenerateTimeCoursesWeighted(clusteringResults,param)

    %% getting variables
    iCAPs=clusteringResults.iCAPs;
    IDX=clusteringResults.IDX;
    AI=clusteringResults.AI';
    if size(AI,1)<size(AI,2)
        warning('fewer voxels than observations, AI matrix might be inverted!');
%         AI=AI';
    end
    AI_subject_labels=clusteringResults.AI_subject_labels;
    subject_labels=clusteringResults.subject_labels;
    time_labels=clusteringResults.time_labels;
    
    %% constants
    nSub = param.n_subjects;
    nClus = size(iCAPs,1);
    nTP_all = size(AI,2);
    for iS=1:nSub
        nTP_sub(iS,1)=nnz(AI_subject_labels==iS);
        vols_AI_iS=AI_subject_labels==iS;
    end
    nVox = size(AI,1);
    
    % get matrix with distances to cluster centroids for all frames
    if isfield(clusteringResults,'dist_to_centroid')
        dist_to_centroid=clusteringResults.dist_to_centroid;
    elseif isfield(clusteringResults,'iCAPs_folds')
        for iFold= 1:param.n_folds
            clusteringResults.iCAPs_folds.total_dist_sum(iFold,1)=sum(clusteringResults.iCAPs_folds.sum_dist{iFold});
        end
        [~,bestID]=min(clusteringResults.iCAPs_folds.total_dist_sum);
        dist_to_centroid=clusteringResults.iCAPs_folds.dist_to_centroid{bestID};
    elseif isfield(clusteringResults,'I_sig')
        dist_to_centroid=pdist2(clusteringResults.I_sig,iCAPs,param.distType);
    else
        error('For spatio-temporal regression with soft assignment factor, either the distances to the centers or the innovation frames (Data) are needed');
    end
        
    [IDX_mat,~,~]=getIDXmat(dist_to_centroid,param.softClusterThres);
    
    clear clusteringResults

    
    % compute real frame indices (without considering positive or negative
    % frames separately)
    for iS=1:nSub
        vols_iS=subject_labels==iS;
        time_labels(vols_iS&time_labels>nTP_sub(iS))=time_labels(vols_iS&time_labels>nTP_sub(iS))-nTP_sub(iS);
    end
    

%         disp('Normalizing activity inducing signals');
%         Activity_inducing_norm=zeros(size(Activity_inducing));
%         for iS=1:nSub
%             % indices of time series from subject iS
%             vols_iS=AI_subject_labels==iS;
% 
%             % divide by standard deviation
%             Activity_inducing_norm(:,vols_iS)=Activity_inducing(:,vols_iS)./...
%                 repmat(sqrt(mean(Activity_inducing(:,vols_iS).^2,2)),[1,nTP_sub]);
% 
%             % remove mean across voxels (global signal regression)
%     %         Activity_inducing_norm(:,vols_iS)=Activity_inducing_norm(:,vols_iS) - repmat(mean(Activity_inducing_norm(:,vols_iS),1),n_vox,1);
%         end
%         Activity_inducing_norm(isnan(Activity_inducing_norm))=0;
%         AI_concatenated=reshape(Activity_inducing_norm,nTP_all,[]);
%         clear Activity_inducing Activity_inducing_norm
        
    
    %% do regression for every subject
    tic
%     numTimes = param.num_partitions;
%     delay = param.delay;
    numTimes = 3;
    delay = 10 ;

    for iS=1:nSub
        vols_AI_iS=AI_subject_labels==iS;
        
        n_AI = nTP_sub(iS);
        limit = round(n_AI/numTimes);
        limits = 0;
        for mm = 1:numTimes-1
            limits = [limits,mm*limit];
        end
        
        limits = [limits, n_AI];
                
        delay_right = [delay*ones(1,numTimes-1) 0];
        delay_left = [0 delay*ones(1,numTimes-1)];

  
        AI_sub = AI(:,vols_AI_iS);
        time_labels_sub = time_labels(subject_labels==iS);
        IDX_mat_sub = IDX_mat(subject_labels==iS,:);

        
        TC_all = [];

        for k = 1:numTimes

            disp(['Running for sub...subject..',num2str(k)])

            % vols_AI_iS_temp = logical([zeros(limits(k),1); vols_AI_iS(limits(k)+1:limits(k+1)) ; zeros(n_AI-limits(k+1),1) ]);
            % nTP_sub_temp = nnz(vols_AI_iS_temp);

            
            limit_right = limits(k+1) + delay_right(k);
            limit_left = limits(k) - delay_left(k);

            
            nTP_sub_temp = limit_right - limit_left;
            range = time_labels_sub >limit_left & time_labels_sub <=limit_right; 


          % concatenate activity inducing signals
            AI_concatenated=reshape(AI_sub(:,limit_left+1:limit_right),nTP_sub_temp*nVox,1); % contains concatenated AI per subject, scrubbed frame selection later



            disp(['subject: ' num2str(iS)])
            disp('Constructing design matrix ...')
            
            temp = subject_labels==iS; temp(temp==0)=[];
            subject_labels_temp =  temp & range;
            
            % number of significant innovations + start and end frame
            nInnov=nnz(subject_labels_temp)+2*nClus;

            S=sparse(nTP_sub_temp*nVox,nInnov);
            B=zeros(nTP_sub_temp,nInnov);
            clusStartID=1;
            for iC=1:nClus
                sub_clus_time_labels{iS,iC,k}=sort(time_labels_sub(subject_labels_temp&IDX_mat_sub(:,iC)==1)- limit*(k-1) + delay_left(k));
                sub_clus_time_labels{iS,iC,k}=[1;sub_clus_time_labels{iS,iC,k};nTP_sub_temp+1];
                sub_clus_time_labels{iS,iC,k}=unique(sub_clus_time_labels{iS,iC,k});

                % number of innovations per iCAP, including the first and
                % last frame
                nInnov_Clus=length(sub_clus_time_labels{iS,iC,k});

                B_k=zeros(nTP_sub_temp,nInnov_Clus-1);
                for iFrame=1:nInnov_Clus-1
                    firstID=sub_clus_time_labels{iS,iC,k}(iFrame);
                    lastID=sub_clus_time_labels{iS,iC,k}(iFrame+1)-1;

                    B_k(firstID:lastID,iFrame)=1;
                end
                S_k=sparse(kron(B_k,iCAPs(iC,:)'));

                S(:,clusStartID:clusStartID+nInnov_Clus-2)=S_k;
                B(:,clusStartID:clusStartID+nInnov_Clus-2)=B_k;

                clustID{iS,k}(clusStartID:clusStartID+nInnov_Clus-2,1)=iC;
                clusStartID=clusStartID+nInnov_Clus-1;
            end
            S(:,~sum(S,1))=[];
            nBeta=size(S,2);
            %nInnov(iS)=nBeta;
            x0 = zeros(nBeta,1);

            disp('Solving OLS ...')
            % sparse implementation of the pseudo-inverse ((X^T X)^(-1) X^T)
            X1=S'*S; % X1=(X^T X);
            tmp=S'*AI_concatenated; % y1 = X^T y
            innovWeights=X1\tmp; % y2 = (X^T X)^(-1) y1
            clear X1 tmp
        
        
            % reconstruct time courses
            for iC=1:nClus
                betaInClusID=find(clustID{iS,k}==iC);
                innov_Clus=sub_clus_time_labels{iS,iC,k};
                nInnov_Clus=length(innov_Clus);
                if nInnov_Clus~=length(betaInClusID)+1
                    error('there should be as many betas as piecewise constant activity sequences');
                end
                for iFrame=1:nInnov_Clus-1
                    firstID=innov_Clus(iFrame);
                    lastID=innov_Clus(iFrame+1)-1;
                    TC_temp(iC,firstID:lastID)=innovWeights(betaInClusID(iFrame));
                end
            end

            TC_all = [TC_all TC_temp(:,1+delay_left(k):end-delay_right(k))];


            % saving mean residuals and other quality criteria (BIC, AIC,
            % ...)
            stats_temp.RSS(k)=sum((S*innovWeights-AI_concatenated).^2); % residual sum of squares
            stats_temp.n(k)=size(S,1); % number of observations (voxels*frames)
            stats_temp.k(k)=size(S,2); % number of regressors (amplitude segments to estimate)
            stats_temp.bic(k)=stats_temp.n(k)*log(stats_temp.RSS(k)/stats_temp.n(k)) + stats_temp.k(k)*log(stats_temp.n(k));
            stats_temp.aic(k)=stats_temp.n(k)*log(stats_temp.RSS(k)/stats_temp.n(k)) + stats_temp.k(k)*2;

            clear innovWeights TC_temp
        end

        TC{iS} = TC_all;
        stats.RSS(iS,1) = sum(stats_temp.RSS);
        stats.n(iS,1)= sum(stats_temp.n);
        stats.k(iS,1) = sum(stats_temp.k);
        stats.bic(iS,1) = sum(stats_temp.bic);
        stats.aic(iS,1) = sum(stats_temp.aic);

        clear TC_all stats_temp

    toc
    end
end
