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
av1 = transpose(linspace(275,730,183))
av2 = transpose(linspace(949,941,183))
frame = transpose(774:956)
missing = [av1 av2 frame]
%average of element before and after used for xy 
toe = vertcat(toeCoord(1:80,:), [avgx,avgy,80],toeCoord(81:773,:), missing, toeCoord(774:length(toeCoord),:));
toeCoord = toe;

%find the shortest vector length/ least frames
w= length(waistCoord)
hi=length(hipCoord)
k=length(kneeCoord)
h=length(heelCoord)
t=length(toeCoord)
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
    