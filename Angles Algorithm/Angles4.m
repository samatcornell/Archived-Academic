close all
clear all

%Data: 1094 frames, 30 frames per second
x=load('coordinates.mat');
frames = input('Input the number of frames: ');
framerate = input('Input frame rate: ');
timeTot = frames/framerate;

framecount = 0; %add 1 at the end of code, each fram starts from 0
%if index does not equal frame number plus 1, estimate frame with a
%repetitive value

%Extract Data
tab=struct2table(x);
table2=table2array(tab);
array=table2array(table2);

%[x y frame]
kneeCoord= double(array(:,[1 2 3]));
waistCoord = double(array(:,[17 18 19]));
heelCoord = double(array(:,[13 14 15]));
toeCoord = double(array(:,[9 10 11]));
hipCoord = double(array(:,[5 6 7]));

%For missing frame, an average of x, y position was added for the 80th
%frame for frame 80 of "TOE"
avgx = (297 + 242)/2;
avgy = (984 + 983)/2;
%missing 183 frames (774 - 956)
av1 = transpose(linspace(275,730,183));
av2 = transpose(linspace(949,941,183));
frame = transpose(774:956);
missing = [av1 av2 frame];
%average of element before and after used for xy 
toe = vertcat(toeCoord(1:80,:), [avgx,avgy,80],toeCoord(81:773,:), missing, toeCoord(774:length(toeCoord),:));
toeCoord = toe;

%find the shortest vector length/ least frames
w= length(waistCoord);
hi=length(hipCoord);
k=length(kneeCoord);
h=length(heelCoord);
t=length(toeCoord);
lim = min(min(min(min(w,h),hi),t),k);


%hipangle -- use waist and knee (and hip as vertex) 
    %computing v1 -- (xywaist - hip)
    v1 = waistCoord(1:lim,[1 2]) - hipCoord(1:lim,[1 2]);
    %computing v2 -- (xyknee - hip)
    v2 = kneeCoord(1:lim,[1 2]) - hipCoord(1:lim,[1 2]);
%knee angle -- use hip and heel (and knee as vertex)
    %computing v1 -- (xyhip - knee)
    v3= hipCoord(1:lim,[1 2]) - kneeCoord(1:lim,[1 2]);
    %computing v2 -- (xyheel - knee)
    v4 = heelCoord(1:lim,[1 2]) - kneeCoord(1:lim,[1 2]);
%ankle angle -- use knee and toe (and ankle as vertex)
    %computing v1 -- (xyknee - ankle)
    v5 = kneeCoord(1:lim,[1 2]) - heelCoord(1:lim,[1 2]);
    %computing v2 -- (xytoe - ankle)
    v6 = toeCoord(1:lim,[1 2]) - heelCoord(1:lim,[1 2]);
    
    lim
    timeTot
    %Make the time 
    t = linspace(0,round(timeTot),lim);
    norm1 = zeros(length(v1),1);
    
    hipAng = norm1;
    kneeAng = norm1;
    ankleAng = norm1;
    
    for i = 1:length(v1)
       %do dot products and divide by the norm
       hipAng(i,:) = (v1(i,1)*v2(i,1)+v1(i,2)*v2(i,2))/(norm(v1(i,:))*norm(v2(i,:)));
       kneeAng(i,:) = (v3(i,1)*v4(i,1)+v3(i,2)*v4(i,2))/(norm(v3(i,:))*norm(v4(i,:)));
       ankleAng(i,:) = (v5(i,1)*v6(i,1)+v5(i,2)*v6(i,2))/(norm(v5(i,:))*norm(v6(i,:)));
    end

    %find angles
    hipAng = acos(hipAng)*180/pi;
    kneeAng = acos(kneeAng)*180/pi;
    ankleAng = acos(ankleAng)*180/pi;
    
    %plot angles
    figure(1)
    hold on
    subplot(1,3,1)
    plot(t,hipAng)
    xlabel('Time(s)')
    ylabel('Angle(degrees)')
    ylim([0 360])
    title('Hip Angle over Time')
    
    subplot(1,3,2)
    plot(t,kneeAng)
    xlabel('Time(s)')
    ylabel('Angle(degrees)')
    ylim([0 360])
    title('Knee Angle over Time')
    
    subplot(1,3,3)
    plot(t,ankleAng)
    xlabel('Time(s)')
    ylabel('Angle(degrees)')
    ylim([0 360])
    title('Ankle Angle over Time')
    hold off
    
    figure(2)
    hold on
    plot(t,hipAng,'r')
    plot(t,kneeAng,'b')
    plot(t,ankleAng,'k')
    xlabel('Time(s)')
    ylabel('Angle(degrees)')
    title('Angle over Time')
    ylim([0 360])
    legend('Hip', 'Knee', 'Ankle')
    hold off
    
    figure(3)
    hold on
    plot(t,movmean(hipAng,[0 05]),'r')
    plot(t,movmean(kneeAng, [0 5]),'b')
    plot(t,movmean(ankleAng, [0 5]),'k')
    xlabel('Time(s)')
    ylabel('Angle(degrees)')
    title('Angle over Time')
    ylim([0 360])
    legend('Hip', 'Knee', 'Ankle')
    hold off
    
    
    
%% 

% use a moving mean to smooth out the data
meanhipAng = movmean(hipAng, 4);
meankneeAng = movmean(kneeAng, 3);
meanankleAng = movmean(ankleAng, 4);

% use find peaks to find the peaks and locations of the peaks
[hippks, hiplocs, hipwidths] = findpeaks(meanhipAng, t, 'MinPeakDistance',0.75);
[kneepks, kneelocs, kneewidths] = findpeaks(meankneeAng, t, 'MinPeakDistance',0.75);
[anklepks, anklelocs, anklewidths] = findpeaks(meanankleAng, t, 'MinPeakDistance',0.75);
 

% use location of peaks to find the indices to reference when graphing
% for hip angles
hipindices = zeros(length(hiplocs),1);  % just presetting the length of the indices vector

for k = 1:length(hiplocs)
    hipindices(k) = find(t == hiplocs(k));   % find the position in the time vector where each of the peak locations occur (will use these positions for graphing parameters)
end    

% for knee angles
kneeindices = zeros(length(kneelocs),1);

for j = 1:length(kneelocs)
    kneeindices(j) = find(t == kneelocs(j));    
end

% for ankle angles
ankleindices = zeros(length(anklelocs),1);

for i = 1:length(anklelocs)
    ankleindices(i) = find(t == anklelocs(i));    
end

% graphing all the traces of hip angles
hip_traces_matrix=zeros(33,length(hiplocs)-1);
figure
hold on
for l = 1:length(hiplocs)-1
    hip_to_plot=meanhipAng(hipindices(l)-20:hipindices(l+1)-15);
    plot(meanhipAng(hipindices(l)-20:hipindices(l+1)-15), 'r') % parameters from where peaks occur, the -20 is to align the graph in time with the other angle graphs
    for n=1:length(hip_to_plot)
        hip_traces_matrix(n,l)=hip_to_plot(n);
    end
end 

sq_hip=zeros(33,length(hiplocs)-1);

for w=1:33
    for j=1:36
        sq_hip(w,j)=(hip_traces_matrix(w,j))^2;
    end
end

mean_hip_vec=zeros(33,1);
for z=1:33
    mean_hip_vec(z)=mean(sq_hip(z,:));
end

final_hip_vec=zeros(33,1);
for v=1:33
    final_hip_vec(v)=sqrt(mean_hip_vec(v));
end

% % an attempt at graphing the average-didn't work
% fs = 30;  % this is supposed to be the sampling rate but it appears too low and just makes a line
% ta = tsa(meanhipAng(1:1000), fs, hiplocs);



plot(final_hip_vec, 'k', 'LineWidth', 3)
title('Hip Angle')   
xlabel('Percent of Gait Cycle')
ylabel('Angle(Degrees)')
xticks([1 4.2 7.4 10.6 13.8 17 20.2 23.4 26.6 29.8 33])
xticklabels({'0', '10','20', '30', '40', '50', '60', '70', '80', '90', '100'})

% plotting the traces of knee angles
knee_traces_matrix=zeros(31,length(kneelocs)-1);
figure
hold on
for m = 1:length(kneelocs)-1
    plot(meankneeAng(kneeindices(m)-2:kneeindices(m+1)), 'r')
    knee_to_plot=meankneeAng(kneeindices(m)-2:kneeindices(m+1));
    for b=1:length(knee_to_plot)
        knee_traces_matrix(b,m)=knee_to_plot(b);
    end
end     
% avgknee = tsa(meankneeAng, fs, kneelocs);

sq_knee=zeros(31,length(kneelocs)-1);

for w=1:31
    for j=1:36
        sq_knee(w,j)=(knee_traces_matrix(w,j))^2;
    end
end

mean_knee_vec=zeros(31,1);
for z=1:31
    mean_knee_vec(z)=mean(sq_knee(z,:));
end

final_knee_vec=zeros(31,1);
for v=1:31
    final_knee_vec(v)=sqrt(mean_knee_vec(v));
end

plot(final_knee_vec, 'k', 'LineWidth', 3)
title('Knee Angle')    
xlabel('Percent of Gait Cycle')
ylabel('Angle(Degrees)')
xticks([1 4 7 10 13 16 19 22 25 28 31])
xticklabels({'0', '10','20', '30', '40', '50', '60', '70', '80', '90', '100'})



% plotting the traces of the ankle angles
ankle_traces_matrix=zeros(42,length(anklelocs)-1);
figure
hold on
xlim([0 30])
ylim([50 80])
for n = 1:length(anklelocs)-10
    plot(meanankleAng(ankleindices(n)-1:ankleindices(n+1)-1), 'r') 
    ankle_to_plot=meanankleAng(ankleindices(n)-1:ankleindices(n+1)-1);
    for g=1:length(ankle_to_plot)
        ankle_traces_matrix(g,n)=ankle_to_plot(g);
    end
end 

sq_ankle=zeros(42,length(anklelocs)-12);

for w=1:42
    for j=1:24
        sq_ankle(w,j)=(ankle_traces_matrix(w,j))^2;
    end
end

mean_ankle_vec=zeros(42,1);
for z=1:42
    mean_ankle_vec(z)=mean(sq_ankle(z,:));
end

final_ankle_vec=zeros(42,1);
for v=1:42
    final_ankle_vec(v)=sqrt(mean_ankle_vec(v));
end


% avgankle = tsa(meanankleAng(1:700), fs, anklelocs);

plot(final_ankle_vec, 'k', 'LineWidth', 3)
title('Ankle Angle')
xlabel('Percent of Gait Cycle')
ylabel('Angle(Degrees)')
xticks([1 3.9 6.8 9.7 12.6 15.5 18.4 21.3 24.2 27.1 30])
xticklabels({'0', '10','20', '30', '40', '50', '60', '70', '80', '90', '100'})
