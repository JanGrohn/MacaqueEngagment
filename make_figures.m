files = dir;
folders = files([files.isdir]);
for ii = 4:size(folders,1)
    addpath(genpath(folders(ii).name));
end
clear files folders ii

load('behaviouralData.mat')

%% Fig S2
figure; hold on;
subplot(2,2,1); hold on;
histogram(-Grohn.CE(Grohn.invalidDisengagment==0&Grohn.validDisengagment==0),'normalization','probability','binedges',-1:0.1:1)
histogram(-Grohn.CE(Grohn.invalidDisengagment==0&Grohn.validDisengagment==1),'normalization','probability','binedges',-1:0.1:1)
ylabel('relative density')
xlabel('current engagement')
title('Grohn et al.')
set(gca,'FontSize', 14)

subplot(2,2,2); hold on;
histogram(-Jahn.CE(Jahn.invalidDisengagment==0&Jahn.validDisengagment==0),'normalization','probability','binedges',-1:0.1:1)
histogram(-Jahn.CE(Jahn.invalidDisengagment==0&Jahn.validDisengagment==1),'normalization','probability','binedges',-1:0.1:1)
ylabel('relative density')
xlabel('current engagement')
title('Jahn et al.')
set(gca,'FontSize', 14)

subplot(2,2,3); hold on;
histogram(-Khalighinejad.CE(Khalighinejad.invalidDisengagment==0&Khalighinejad.validDisengagment==0),'normalization','probability','binedges',-1:0.1:1)
histogram(-Khalighinejad.CE(Khalighinejad.invalidDisengagment==0&Khalighinejad.validDisengagment==1),'normalization','probability','binedges',-1:0.1:1)
ylabel('relative density')
xlabel('current engagement')
title('Khalighinejad et al.')
set(gca,'FontSize', 14)

subplot(2,2,4); hold on;
histogram(-Bongioanni.CE(Bongioanni.invalidDisengagment==0&Bongioanni.validDisengagment==0),'normalization','probability','binedges',-1:0.1:1)
histogram(-Bongioanni.CE(Bongioanni.invalidDisengagment==0&Bongioanni.validDisengagment==1),'normalization','probability','binedges',-1:0.1:1)
ylabel('relative density')
xlabel('current engagement')
title('Bongioanni et al.')
set(gca,'FontSize', 14)

%% Fig 1C left
n = 10;
tracesGrohn = estimate_autocorrelation(Grohn,'CE',n);
tracesJahn = estimate_autocorrelation(Jahn,'CE',n);
tracesKhalighinejad = estimate_autocorrelation(Khalighinejad,'CE',n);
tracesBongioanni = estimate_autocorrelation(Bongioanni,'CE',n);

tracesAll = [tracesGrohn;tracesJahn;tracesKhalighinejad;tracesBongioanni];

plot_autocorrelation(tracesAll);

%% Fig 1C right

[Grohn,alphaGrohn] = estimate_kernel(Grohn,'CE','GE',1);
[Jahn,alphaJahn] = estimate_kernel(Jahn,'CE','GE',2);
[Khalighinejad,alphaKhalighinejad] = estimate_kernel(Khalighinejad,'CE','GE',2);
[Bongioanni,alphaBongioanni] = estimate_kernel(Bongioanni,'CE','GE',1);



figure('position',[1000 100 500 300]); hold on
plot_kernel(alphaJahn,1:30)
plot_kernel(alphaGrohn,1:30)
plot_kernel(alphaKhalighinejad,1:30)
plot_kernel(alphaBongioanni,1:30)
xlabel('trials')
ylabel('weight')
set(gca,'FontSize', 18)
axis([-30 30 0 inf])
lgd = legend(["Jahn et al.","Grohn et al.","Khalighinejad et al.","Bongioanni et al."]);
legend boxoff
lgd.Position = [0.65 0.7 0.3 0.25];
lgd.FontSize = 12;

%% Fig 1D
figure('position',[100 100 1500 200]); hold on

ID = 5;
sess = 1;

disengagment = Grohn.validDisengagment(Grohn.session==sess&Grohn.ID==ID);
disengagment(disengagment==0) = nan;
GE = Grohn.GE(Grohn.session==sess&Grohn.ID==ID);
CE = Grohn.CE(Grohn.session==sess&Grohn.ID==ID);

c = brewermap(8,'Dark2');

scatter(1:length(disengagment),disengagment*2,'k','filled')
plot(disengagment*2,'ko','linewidth',1)
plot(nanzscore(-CE),'linewidth',2,'color',c(2,:))
plot(nanzscore(-GE),'linewidth',2,'color',c(3,:))

plot([1 length(GE)],[0 0],'k')
axis([1 160 -3.5 2.5])

xlabel('trials')
yticks([])
xticks([1,20:20:160])
set(gca,'FontSize', 18)

ax = gca;
ax.YAxis.Visible = 'off';

%% Fig S3B

[Grohn,alphaGrohn] = estimate_kernel(Grohn,'trialVigor','stateVigor',1);
[Jahn,alphaJahn] = estimate_kernel(Jahn,'trialVigor','stateVigor',1);
[Khalighinejad,alphaKhalighinejad] = estimate_kernel(Khalighinejad,'trialVigor','stateVigor',1);
[Bongioanni,alphaBongioanni] = estimate_kernel(Bongioanni,'trialVigor','stateVigor',1);

Grohn.stateVigor(Grohn.disengagment==1) = nan;
Grohn.stateVigor_back(Grohn.disengagment==1) = nan;
Grohn.stateVigor_forward(Grohn.disengagment==1) = nan;

Jahn.stateVigor(Jahn.disengagment==1) = nan;
Jahn.stateVigor_back(Jahn.disengagment==1) = nan;
Jahn.stateVigor_forward(Jahn.disengagment==1) = nan;

Khalighinejad.stateVigor(Khalighinejad.disengagment==1) = nan;
Khalighinejad.stateVigor_back(Khalighinejad.disengagment==1) = nan;
Khalighinejad.stateVigor_forward(Khalighinejad.disengagment==1) = nan;

Bongioanni.stateVigor(Bongioanni.disengagment==1) = nan;
Bongioanni.stateVigor_back(Bongioanni.disengagment==1) = nan;
Bongioanni.stateVigor_forward(Bongioanni.disengagment==1) = nan;

figure('position',[1000 100 500 300]); hold on
plot_kernel(alphaJahn,1:30)
plot_kernel(alphaGrohn,1:30)
plot_kernel(alphaBongioanni,1:30)
xlabel('trials')
ylabel('weight')
set(gca,'FontSize', 18)
axis([-30 30 0 inf])
lgd = legend(["Jahn et al.","Grohn et al.","Bongioanni et al."]);
legend boxoff
lgd.Position = [0.65 0.7 0.3 0.25];
lgd.FontSize = 12;

%% Fig 3 fit timecourses
modelstring = 'epochDec~1+CE+GE+trialVigor+stateVigor';
nregs = 5;
regions = {'32','13','Striatum','24'};

[betasGrohn,tstatsGrohn,namesGrohn] = fit_tc(Grohn,modelstring,regions,nregs,'Grohn');
[betasJahn,tstatsJahn,namesJahn] = fit_tc(Jahn,modelstring,regions,nregs,'Jahn');
[betasBongioanni,tstatsBongioanni,namesBongioanni] = fit_tc(Bongioanni,modelstring,regions,nregs,'Bongioanni');
[betasKhalighinejad,tstatsKhalighinejad,namesKhalighinejad] = fit_tc(Khalighinejad,modelstring,regions,nregs,'Khalighinejad');


tstats = {};
tstats.Grohn = tstatsGrohn;
tstats.Jahn = tstatsJahn;
tstats.Bongioanni = tstatsBongioanni;
tstats.Khalighinejad = tstatsKhalighinejad;
names = {};
names.Grohn = namesGrohn;
names.Jahn = namesJahn;
names.Bongioanni = namesBongioanni;
names.Khalighinejad = namesKhalighinejad;
%% Fig 3A

ROI = '32';
firstxlabel = "decision-prompt";

figure; 
subplot(3,1,1);hold on
plot_tc(tstats,'CE',ROI,regions,names,firstxlabel,30,c(2,:))
title('current engagment (CE)')

subplot(3,1,2);hold on
plot_tc(tstats,'GE',ROI,regions,names,firstxlabel,30,c(3,:))
title('general engagement (GE)')

subplot(3,1,3);hold on
plot_tstats(ROI)

%% Fig 3B

ROI = '13';
firstxlabel = "decision-prompt";

figure; 
subplot(3,1,1);hold on
plot_tc(tstats,'CE',ROI,regions,names,firstxlabel,30,c(2,:))
title('current engagment (CE)')

subplot(3,1,2);hold on
plot_tc(tstats,'GE',ROI,regions,names,firstxlabel,30,c(3,:))
title('general engagement (GE)')

subplot(3,1,3);hold on
plot_tstats(ROI)
%% Fig 3C

ROI = 'Striatum';
firstxlabel = "decision-prompt";

figure; 
subplot(3,1,1);hold on
plot_tc(tstats,'CE',ROI,regions,names,firstxlabel,30,c(2,:))
title('current engagment (CE)')

subplot(3,1,2);hold on
plot_tc(tstats,'GE',ROI,regions,names,firstxlabel,30,c(3,:))
title('general engagement (GE)')

subplot(3,1,3);hold on
plot_tstats(ROI)

%% Fig 3D

ROI = '24';
firstxlabel = "decision-prompt";

figure; 
subplot(3,1,1);hold on
plot_tc(tstats,'CE',ROI,regions,names,firstxlabel,30,c(2,:))
title('current engagment (CE)')
axis([-30 30 -1 0.45])

subplot(3,1,2);hold on
plot_tc(tstats,'GE',ROI,regions,names,firstxlabel,30,c(3,:))
title('general engagement (GE)')

subplot(3,1,3);hold on
plot_tstats(ROI)
axis([0.5 4.5 -0.5 1.2])

%% Fig 4B
load('disengagedTime.mat')
figure('position',[100 100 500 450]); hold on
for t = [4,3,1,2]
    plot(cumsum(squeeze(nanmean(time(t,:,:)))),'linewidth',3)
end
legend(["pgACC","BF","sham","POp"],'location','northwest'); legend boxoff
xlabel('time in session (s)')
ylabel('time spent disengaged (s)')
set(gca,'FontSize',20)

%% Fig S6
load('disengagedTime.mat')
figure('position',[100 100 1000 250]); 
for m = 1:4
    if m == 1
        c = 1:5;
    elseif m==2
        c = 6:10;
    elseif m==3
        c = 11:15;
    elseif m==4
        c = 16:20;
    end
    subplot(1,4,m);hold on
    for t = [4,3,1,2]
        plot(cumsum(squeeze(nanmean(time(t,c,:)))),'linewidth',1)
    end
    legend(["pgACC","BF","sham","POp"],'location','northwest'); legend boxoff
    xlabel('time in session (s)')
    ylabel('time spent disengaged (s)')
end

%% Fig 4C
load('disengagedTime.mat')
figure('position',[100 100 600 450])

intervals = [1:1200;1201:2400];
cmap = get(gca,'colororder');
order = [4,3,1,2];

for i = 1:2
    subplot(1,2,i);hold on
    for t = 1:4

        me = sum(nanmean(time(order(t),:,intervals(i,:))));
        se = std(nansum(time(order(t),:,intervals(i,:)),3))/sqrt(20);

        bar(t,me,'facecolor','w','edgecolor',cmap(t,:),'linewidth',2);
        errorbar(t,me,se,'k','capsize',0,'linewidth',2);
    end

    for m = 1:4    
        if m == 1
            c = 1:5;
        elseif m==2
            c = 6:10;
        elseif m==3
            c = 11:15;
        elseif m==4
            c = 16:20;
        end
        me = mean(nansum(time(order,c,intervals(i,:)),3),2);
        plot((1:4)+(m-2.5)/5,me,'-ok','markersize',4,'markerfacecolor','k');    

    end

    xticks(1:4)
    xticklabels(["pgACC","BF","sham","POp"])
    ylabel('time spent disengaged (s)')
    set(gca,'FontSize',20)
    axis([0.2 4.8 0 600])
    xtickangle(45)
end

