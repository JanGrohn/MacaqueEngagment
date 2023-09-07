function plot_tstats(region)
c = brewermap(8,'Dark2');

plot([0 5],[0 0],'k')

experiments = ["Grohn", "Khalighinejad", "Jahn", "Bongioanni"];
for e = 1:4
    load(strcat('ROI_data/',experiments(e),'/',region,'/tstats.mat'));

    bar(e-0.2,mean(vec1),0.36,'facecolor','w','edgecolor',c(2,:),'linewidth',2)
    errorbar(e-0.2,mean(vec1),std(vec1)/sqrt(length(vec1)),'k','capsize',0,'linewidth',2)

    for ii = 1:length(ID_vec1)
        scatter(e-0.2+(ii-mean(1:length(ID_vec1)))/30,mean(ID_vec1{ii}),20,'k')
    end
    bar(e+0.2,mean(vec2),0.36,'facecolor','w','edgecolor',c(3,:),'linewidth',2)
    errorbar(e+0.2,mean(vec2),std(vec2)/sqrt(length(vec2)),'k','capsize',0,'linewidth',2)

    for ii = 1:length(ID_vec2)
        scatter(e+0.2+(ii-mean(1:length(ID_vec2)))/30,mean(ID_vec2{ii}),20,'k')
    end

end

xticks(1:4)
xticklabels(["Grohn et al.","Khalighinejad et al.","Jahn et al.","Bongioanni et al."])
xtickangle(45)
ylabel('t-statistic')
set(gca,'fontsize',13)
axis([0.5 4.5 -0.2 1.5])