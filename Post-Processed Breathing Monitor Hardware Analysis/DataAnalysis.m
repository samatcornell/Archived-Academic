clear all
close all
%Analyzing Data
%default kernal k  = 5000

% %% Name: Pos:
% data = '';
% kernal = ;
% [t,filtered] = Filter(kernal,data)
% [inhaleAvg,exhaleAvg] = getInhaleExhale(startT,endT,t,filtered);
% standInhaleAvg = inhaleAvg;
% standExhaleAvg = exhaleAvg;
% pause

%% Name:Niki, Pos:Stand
% data = 'nikiStand';
% kernal = 5000;
% title = "Niki's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

%% Name:Niki, Pos:Sit
% data = 'nikiSit1';
% kernal = 5000;
% title = "Niki's Sitting Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg
 %% Name:Niki, Pos:back
% data = 'nikiBack';
% kernal = 5000;
% title = "Niki's Laying Down Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

%% Name:Yashi, Pos:Stand ***used diff interval
data = 'standYashi';
kernal = 5000;
title = "Yashi's Standing Data"
[t,filtered,mindata,peakdata] = Filter(kernal,data,title)
startT = input('Start Time');
endT = input('End Time');

[inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
inhaleAvg
exhaleAvg
rateAvg

 %% Name:Yashi, Pos: sit 
% data = 'sityashi';
% kernal = 5000;
% title = "Niki's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

 %% Name:Yashi, Pos:back
% data = 'layingYashi';
% kernal = 16000;
% title = "Niki's Laying Down Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

%% Name:Schaeffer, Pos:Stand 
% data = 'standschaeffer';
% kernal = 5000;
% title = "Yashi's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

 %% Name:Schaeffer Pos: sit 
% data = 'sitschaeffer';
% kernal = 10000000;
% title = "Niki's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% %filtered = movemean(filtered, [0 100])
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

 %% Name:Schaeffer, Pos:back
% data = 'layingschaeffer';
% kernal = 5000;
% title = "Niki's Laying Down Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

%% Name:SamP, Pos:Stand 
% data = 'standsam';
% kernal = 10000;
% title = "Yashi's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

 %% Name:SamP Pos: sit 
% data = 'sitsam';
% kernal = 10000;
% title = "Niki's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% %filtered = movemean(filtered, [0 100])
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

 %% Name:SamP, Pos:back
% data = 'laying downsam';
% kernal = 10000;
% title = "Niki's Laying Down Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg

%% Name:Schaeffer, Pos:Stand 
% data = 'standschaeffer';
% kernal = 5000;
% title = "Schaeffer's Standing Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg
% exhaleAvg
% rateAvg
% 
  %% Name:Schaeffer Pos: sit 
% data = 'sitschaeffer';
% kernal = 10000;
% title = "Schaffer's Sitting Down Data"
% [t,filtered,mindata,peakdata] = Filter(kernal,data,title)
% startT = input('Start Time');
% endT = input('End Time');
% 
% %filtered = movemean(filtered, [0 100])
% [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
% inhaleAvg

% exhaleAvg
% rateAvg

 %% Name:Schaeffer, Pos:back
data = 'layingschaeffer';
kernal = 5000;
title = "Schaffer's Laying Down Data"
[t,filtered,mindata,peakdata] = Filter(kernal,data,title);
startT = input('Start Time');
endT = input('End Time');

[inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata);
inhaleAvg
exhaleAvg
rateAvg




