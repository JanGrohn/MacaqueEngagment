function [betas,tstat,names] = fit_tc(dt,modelstring,regions,nregs,experiment)

betas = {};
tstat = {};
names = {};

n = length(regions);

parfor region = 1:n
    display(['fitting region ',num2str(region),'/',num2str(n)]);
    [betas{region},tstat{region},names{region}] = fit_tc_sessions(dt,regions{region},modelstring,nregs,experiment);
end


end
