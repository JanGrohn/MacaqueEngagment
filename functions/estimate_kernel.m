function [dt,alpha] = estimate_kernel(dt,yName,outName,l)

alpha = nan(max(dt.ID),1);

options = optimset('MaxFunEvals',100000,'TolFun', 1e-12);
R2full = nan(max(dt.ID),1);
R2small = nan(max(dt.ID),1);

min_fun = @(x) kernel_SSE(x(1),dt,yName,l);
sigmoid = @(x) 1./(1+exp(-x));
out=fminsearch(min_fun,-0.8473,options);
alpha = sigmoid(out(1));    


dt.(outName) = nan(height(dt),1);
dt.([outName,'_back']) = nan(height(dt),1);
dt.([outName,'_forward']) = nan(height(dt),1);

for ID = unique(dt.ID)'
    for sess = unique(dt.session(dt.ID==ID))'
        sess_data = dt.(yName)(dt.ID==ID&dt.session==sess&dt.invalidDisengagment==0);
        if strcmp(yName,'CE')
            sess_data(isnan(sess_data)) = [];
            [~,yb,yf] = exp_smoothing(sess_data,alpha,l);
            yb(1) = nan;
            yf(end) = nan;
            dt.([outName,'_back'])(dt.ID==ID&dt.session==sess&~isnan(dt.(yName))&dt.invalidDisengagment==0) = yb;
            dt.([outName,'_forward'])(dt.ID==ID&dt.session==sess&~isnan(dt.(yName))&dt.invalidDisengagment==0) = yf; 
            dt.(outName)(dt.ID==ID&dt.session==sess&~isnan(dt.(yName))&dt.invalidDisengagment==0) = yb+yf;
        else
            [~,yb,yf] = exp_smoothing(sess_data,alpha,l);
            yb(1) = nan;
            yf(end) = nan;
            dt.([outName,'_back'])(dt.ID==ID&dt.session==sess&dt.invalidDisengagment==0) = yb;
            dt.([outName,'_forward'])(dt.ID==ID&dt.session==sess&dt.invalidDisengagment==0) = yf; 
            dt.(outName)(dt.ID==ID&dt.session==sess&dt.invalidDisengagment==0) = yb+yf;
        end
        
    end
end


