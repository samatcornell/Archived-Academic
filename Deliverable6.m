% Our algorithm replaces the outliers (values outside of 2 std of the mean)
% with the average
close all;

data = table2array(hrvtest1_StatisticalAnalysis);

hr_device = (data(:,1))';
time_device = (data(:,2))';

x = std(hr_device);
mean_hr_device= mean(hr_device);
lower_bound = mean_hr_device-2*x;
upper_bound = mean_hr_device+2*x;
am=find(hr_device<lower_bound);
am=[am, find(hr_device >upper_bound)]; % array of indecies of outliers 
    for i = 1 : length(am)
       
        hr_device(1,abs(am(i)))=mean_hr_device;% could be changed to value before
    end
%movmean might just make sense for future adjustments 
figure()
hold on
plot(time_device,hr_device,'*');
% hr_device_filtered = hr_device;
% plot(time_device, hr_device_filtered,'b');
xlabel('Time (s)');
ylabel('Adjusted Heart Rate');
legend
title('')
hold off

%for export
saveHR = hr_device';
saveT = time_device';

writematrix(saveHR,'HROutlier.csv')




%% Kerry's Code
%interpolate chest strap data for baseline 5 min
hr= Baseline{4:311,6}; %import the data
time= Baseline{4:311,8}; %import the data

window= 5;

xq=0:307/487:307; %sample?

hrinterp= interp1(time, hr,  xq, "spline");

ibi=60./hrinterp;
ibisq= ibi.^2;

sumibisq= movsum(ibisq,[4 0]);

hrv=sqrt(sumibisq./window);

hrv=hrv(window:end);

plot(xq(window:end),hrv,'.-')

 