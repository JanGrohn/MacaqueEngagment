function plot_tc(betas,reg,ROI,regions,names,firstxlabel,window,c)


expNames = fieldnames(betas);

t = -window:2.28/10:window;



tc = nan(1,length(t));

count = 1;
for exp = 1:length(expNames)

    ROIidx = find(string(regions)==ROI);
    for ID = 1:size(betas.(expNames{exp}){1},2)
        if ~isempty(nanmean(betas.(expNames{exp}){ROIidx}(:,ID,:,names.(expNames{exp}){ROIidx}(ID,1,:)==reg),3)) & ~(sum(nanmean(betas.(expNames{exp}){ROIidx}(:,ID,:,names.(expNames{exp}){ROIidx}(ID,1,:)==reg),3))==0)
            tc(count,:) = nanmean(betas.(expNames{exp}){ROIidx}(:,ID,:,names.(expNames{exp}){ROIidx}(ID,1,:)==reg),3); 
            count = count + 1;
        end
    end

end

plot([-window window],[0 0],'k')
plot([0 0],[((-max(nanmean(tc)))-1) ((-min(nanmean(tc)))+1)],'k')
shadedErrorBar(t,-nanmean(tc),std(tc)/sqrt(size(tc,1)),{'color',c},1)




xlabel('time (s)')
ylabel('t-statistic')

t = -window:15:window;
xticks(t)
t = string(t);
t(ceil(length(t)/2)) = string(firstxlabel);
xticklabels(t)

yticks([-1.2:0.4:1.2]);
axis([-window window -0.4 0.8])

set(gca,'FontSize', 15)
