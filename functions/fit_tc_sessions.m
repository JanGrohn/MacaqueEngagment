function [betas,tstat,names] = fit_tc_sessions(dt,region,modelstring,nregs,experiment)

warning('off','stats:LinearModel:RankDefDesignMat');
epochs = load(['ROI_data/',experiment,'/',region,'/epochs.mat']);

dt.decEpochs = epochs.epochs;

betas = nan(size(dt.decEpochs,2),max(dt.ID),13,nregs);
tstat = nan(size(dt.decEpochs,2),max(dt.ID),13,nregs);

for Asub = unique(dt.ID)'
    AsubData = dt(dt.ID==Asub,:);
    for sess = unique(AsubData.session)'
        SessData = AsubData(AsubData.session==sess,:);
        for epoch = 1:size(SessData.decEpochs,2)
            SessData.epochDec = SessData.decEpochs(:,epoch);

            
            SessData.trialVigor = nanzscore(SessData.trialVigor);
            SessData.trialVigor(isnan(SessData.trialVigor)) = 0;
            SessData.stateVigor = nanzscore(SessData.stateVigor);
            SessData.stateVigor(isnan(SessData.stateVigor)) = 0;
            SessData.CE = nanzscore(SessData.CE);
            SessData.GE = nanzscore(SessData.GE);
            
            fit = fitlm(SessData,modelstring);
            betas(epoch,Asub,sess,:) = table2array(fit.Coefficients(:,1));
            tstat(epoch,Asub,sess,:) = table2array(fit.Coefficients(:,3));
            names(Asub,sess,:) = string(fit.CoefficientNames);
        end
        
    end
end
% 



