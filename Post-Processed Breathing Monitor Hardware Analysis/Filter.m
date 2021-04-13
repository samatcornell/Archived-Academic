%Data Filtration, unmodulates
%Needs: kernal filtration, 5000 base. No unmod kernal = 1, data = 'data
%name'
%returns average inhale time interval and exhale time interval 
function [t,filtered,mindata,peakdata] = Filter(kernal,data,title_)
%Convert data type
close all
table_structure=load(data);
table=struct2table(table_structure);
array=table2array(table);
array=table2array(array);
position =array(:,2);

%Make into a row vector, extract time, t and voltage, v
t = array(:,1);
V = array(:,2);

% %View Current Data
% figure(1)
% hold on
% plot(t,V,"blue")
% 
% xlabel("Time")
% ylabel("Voltage")
% title("Niki's Unfiltered Standing Breathing Rate")

%Niki's code, get rid of modulation
mov_avg_filt_kernel=ones(1,kernal)/kernal;
moving_avg=conv(position,mov_avg_filt_kernel,'same');
%plot(t,moving_avg) 

%Shape Integrity is fully present
unmodData = V-moving_avg;

%Shape Integrity present, processed
filtered = movmean(movmean(unmodData, [0 50]), [0 50]);

figure(1) 
hold on
plot(t,unmodData,'r') %unmodulated, unfiltered
plot(t,filtered, 'b') %unmodulated, filtered
% plot(t,V,'k') %raw data
xlabel("Time")
ylabel("Voltage")
title(title_)
legend('Unmodulated', 'Filtered/ Unmodulated', 'Filtered/Modulated','Inverted Extrema')


%plot(t,-1.*filtered)
hold off


%Identifying raw peak data
[peakval,index,widths,p] = findpeaks(filtered);

%Filter out outlier peaks using min peak width within a std

meanw = mean(widths)
sd = meanw*.01

thresh = (meanw - sd)

[peakval, index, widths, p] = findpeaks(filtered, 'MinPeakWidth',(thresh))


peakdata = zeros(length(index),1);
%vector of peak indices with corresponding time
for i = 1:length(index)
    %time in col
    peakdata(i,1) = t(index(i));
    
end

%Identifying peak data
[pv,ind,w,po] = findpeaks(-1.*filtered, 'MinPeakWidth',(thresh)); %this makes the minima the maxima for easy identification

mindata = zeros(length(ind),1);
%vector of peak indices with corresponding time
for i = 1:length(ind)
    %time in col 1
    mindata(i,1) = t(ind(i));   
end

hold on 

figure(2)
plot(filtered)
findpeaks(filtered,'MinPeakWidth',(thresh))
title('Max peak accuracy')
hold off

hold on
figure(3)
plot(-1.*filtered)
findpeaks(-1.*filtered,'MinPeakWidth',(thresh))
title('Min peak accuracy')
hold off


end