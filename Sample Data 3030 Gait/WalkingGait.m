table_structure=load('gait_data_20181031-force_sensors.mat');
table=struct2table(table_structure);
array=table2array(table);
array=table2array(array);
position =array(:,4);

%Make into a row vector, extract time, t and channels, and cam
t = array(:,1);
ch0 = array(:,2);
ch1 = array(:,3);
cam = array(:,4);

% %View Current Data
% figure(1)
% hold on
% plot(t,V,"blue")
% 
% xlabel("Time")
% ylabel("Voltage")
% title("Niki's Unfiltered Standing Breathing Rate")
