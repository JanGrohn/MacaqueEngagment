function error = kernel_SSE(alpha,dt,var,l)

sigmoid = @(x) 1./(1+exp(-x));
alpha = sigmoid(alpha);

error = 0;

if alpha < 0 || alpha > 1 
    error = Inf;
else    
    for ID = unique(dt.ID)'
        for sess = unique(dt.session(dt.ID==ID))'
            sess_data = dt.(var)(dt.ID==ID&dt.session==sess&dt.invalidDisengagment==0);
%             if strcmp(var,'resOutlier') | strcmp(var,'validOutliernan')
%                 sess_data(isnan(sess_data)) = [];            
%             end
            smoothed = exp_smoothing(sess_data,alpha,l);
            error = error + nansum((sess_data-smoothed).^2);
        end    
    end
end
% error = error/sum(~isnan(dt.(var)(dt.ID==ID)));

disp(['alpha = ',num2str(alpha),' error = ',num2str(error)])
