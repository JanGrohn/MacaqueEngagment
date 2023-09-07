function x = nanzscore(X)
if any(isnan(X(:)))
    xmu=nanmean(X);
    xsigma=nanstd(X);
    x=(X-repmat(xmu,length(X),1))./repmat(xsigma,length(X),1);
else
    [x,xmu,xsigma]=zscore(X);
end