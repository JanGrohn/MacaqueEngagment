function plot_kernel(alpha,t)
weights = alpha*(1-alpha).^t;
weights(1) = nan;
weights = weights/2;
plot([fliplr(-t(1:end-1)),0,t(1:end-1)],[fliplr(weights(2:end)),weights],'linewidth',3)
