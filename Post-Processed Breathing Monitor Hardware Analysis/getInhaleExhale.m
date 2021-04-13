function [inhaleAvg,exhaleAvg,rateAvg] = getInhaleExhale(startT,endT,t,filtered,mindata,peakdata)
%average time interval for inhalation and exhale
%truncate data set to targeted
startminI = find(mindata >=  startT); %start and end indices
startminI = startminI((1));
endminI = find(mindata <= endT);
endminI = endminI(length(endminI));

startpeakI = find(peakdata >=  startT); %start and end indices
startpeakI = startpeakI((1));
endpeakI = find(peakdata <= endT);
endpeakI = endpeakI(length(endpeakI));


%creates condition that every peak has a predessor
if peakdata(startpeakI) < mindata(startminI)
   startpeakI = startpeakI + 1;
end

%creates condition that every peak has a successor
if peakdata(endpeakI) > mindata(endminI)
    endminI = endminI + 1;
end

%truncated data
samplePeaktime = peakdata(startpeakI:endpeakI);
sampleMintime = mindata(startminI:endminI);

% sub = zeros(length(samplePeaktime)-1,1);
% 
% %rateAvg: find the number of peaks between the given time interval
% timeInt = 
% for i = 2:length(samplePeaktime)
%     sub(i-1,1) = abs(samplePeaktime(i,1)- samplePeaktime(i-1,1));
% end
% rateAvg = mean()


keyTimes = -1.*ones(length(samplePeaktime),3);   %default

%create a matrix (before and after) [before peak after] times
for i = 1:length(samplePeaktime)%each row 
    
    keyTimes(i,1) = sampleMintime(i);
    keyTimes(i,2) = samplePeaktime(i);
    if ~(i == length(sampleMintime))
        keyTimes(i,3) = sampleMintime(i+1);
    end
    
end


inhaleT = abs(keyTimes(:,1)-keyTimes(:,2));
exhaleT = abs(keyTimes(:,2)-keyTimes(:,3));

inhaleAvg = mean(inhaleT)
exhaleAvg = mean(exhaleT)


%rateAvg: find the number of peaks between the given time interval
timeInt = endT-startT;
rateAvg = mean(length(samplePeaktime)/timeInt);
disp(rateAvg) %a check

end




