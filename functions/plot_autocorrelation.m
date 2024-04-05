function plot_autocorrelation(traces)
figure('position',[1000 100 200 200]); hold on

plot([0 20],[0 0],'k')
hold on
n = size(traces,2);
c = get(gca,'colororder');
shadedErrorBar(1:n,mean(traces),std(traces)/sqrt(n),{'color',c(2,:),'linewidth',2},1);
xlabel('lag')
ylabel('correlation')
set(gca,'FontSize', 18)
axis([2 n 0 inf])

xticks(2:2:10)
