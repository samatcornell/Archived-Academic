clear all
close all

%Convert data type
table_structure=load('nikiStand');
table=struct2table(table_structure);
array=table2array(table);
array=table2array(array);
niki_stand=array(:,2);

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
mov_avg_filt_kernel=ones(1,5000)/5000;
moving_avg=conv(niki_stand,mov_avg_filt_kernel,'same');
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
title("Niki's Filtered Standing Breathing Rate")
hold off

%Identifying extractable data
[peakval,index,w,p] = findpeaks(filtered)

% figure(2)
% findpeaks(filtered)

peakdata = zeros(length(index),2);
%do peak 2 peak instead
%vector of peak indices with corresponding time
for i = 1:length(index)
    
    %time in col 1, voltage in col 2
    peakdata(i,1) = filtered(index(i));
    peakdata(i,2) = t(index(i));
    
end


%recopy peak locations for peak widths not within the standard deviation

% m = mean(w) %This was a high value compared to really low scale detected peaks
% s = std(w) %This was a standard deviation that exceeded the mean
% location = zeros(0,1)
% 
% 
% count = 0;
% %assign an index for location
% for i = 1:length(w) %may adjust this depending on the time interval range
%     if (w(i) <= (m + s/2) && w(i)>= (m - s/2)) %if width is within 1 std deviation of the average
%         count = count +1
%         location(count) = w(i)
%     end
% end
% location

hold off



% %High pass filter, we noticed noise on the, ____ frequency level
% %filt_function = 
% 
% data = fftshift(fft(fftshift(filtered_niki_stand)))%* filter
% 
% F = linspace(-1000,1000, length(t));
% figure(3) = plot(F,abs(data));
% 
% data = fftshift(ifft(fftshift(data)))
