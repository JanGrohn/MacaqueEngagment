function [y,yb,yf] = exp_smoothing(x,alpha,l)

weights = alpha*(1-alpha).^(0:length(x)-1);

y = nan(length(x),1);
yb = nan(length(x),1);
yf = nan(length(x),1);

for trial = 1:length(x)
    
    % forward and backward together
    if sum(isnan(x))<1 % outlier
        weights_back = weights(l:trial-1);
        weights_for = weights(l:length(x)-trial);

        norm_factor = sum(weights_back)+sum(weights_for);
        
        weights_back = weights_back / norm_factor;
        weights_for = weights_for / norm_factor;

        y(trial) = weights_back * x(trial-l:-1:1) + weights_for * x(trial+l:end);
    else 
        %find prior and future nan
        pnan = find(isnan(x(1:trial-1)));
        fnan = find(isnan(x(trial+1:end)));
        if isempty(pnan)
            pnan = 0;
        else
            pnan = pnan(end);
        end
        if isempty(fnan)
            fnan = length(x)+1;
        else
            fnan = fnan(1)+trial;
        end
        
        weights_back = weights(l:trial-pnan-1);
        weights_for = weights(l:fnan-trial-1);
        
        norm_factor = sum(weights_back)+sum(weights_for);

        weights_back = weights_back / norm_factor;
        weights_for = weights_for / norm_factor;
        
        if isempty(weights_back) && isempty(weights_for)
            y(trial) = nan;
        else
            y(trial) = weights_back * x(trial-l:-1:pnan+1) + weights_for * x(trial+l:fnan-1);
        end        
    end
    
    % forward and backward seperately
    if sum(isnan(x))<1 % outlier
        weights_back = weights(l:trial-1);
        weights_for = weights(l:length(x)-trial);
        
        weights_back = weights_back / sum(weights_back);
        weights_for = weights_for / sum(weights_for);

        yb(trial) = weights_back * x(trial-l:-1:1);
        yf(trial) = weights_for * x(trial+l:end);
    else 
        pnan = find(isnan(x(1:trial-1)));
        fnan = find(isnan(x(trial+1:end)));
        if isempty(pnan)
            pnan = 0;
        else
            pnan = pnan(end);
        end
        if isempty(fnan)
            fnan = length(x)+1;
        else
            fnan = fnan(1)+trial;
        end
        
        weights_back = weights(l:trial-pnan-1);
        weights_for = weights(l:fnan-trial-1);
        
        weights_back = weights_back / sum(weights_back);
        weights_for = weights_for / sum(weights_for);
        
        if isempty(weights_back)
            yb(trial) = nan;
        else
            yb(trial) = weights_back * x(trial-l:-1:pnan+1);
        end 
        
        if isempty(weights_for)
            yf(trial) = nan;
        else
            yf(trial) = weights_for * x(trial+l:fnan-1);
        end     
    end
end

