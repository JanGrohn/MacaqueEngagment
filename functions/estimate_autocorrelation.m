function vec = estimate_autocorrelation(dt,yName,n)

vec = nan(length(unique(dt.ID)),n);

cID = 1;
for ID = unique(dt.ID)'
    IDvec = nan(length(unique(dt.session(dt.ID==ID))),n);
    cSess = 1;
    for sess = unique(dt.session(dt.ID==ID))'
        IDvec(cSess,:) = acf(dt.(yName)(dt.ID==ID&dt.session==sess&~isnan(dt.(yName))),n);
        cSess  = cSess + 1;
    end
    vec(cID,:) = nanmean(IDvec);
    cID = cID + 1;
end

