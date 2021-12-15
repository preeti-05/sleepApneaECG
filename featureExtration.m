function [avgHR, PSEfinal]=featureExtration (signal)

fs= 100;
t = [0:max(size(signal))-1]/fs; % 60 second intervals of each signal

%% Windowing (Segmenting the Signals into 1min segments)
N = length(signal);
nW = floor(N/6000)+1; % number of windows
temp = (nW*6000)-N;
% pad signal with zeros to make it divisble by 6000
signal = [signal ; zeros(temp,1)];
N = length(signal); % new length of padded signal
nW = N/6000; % new windows

signal_r = reshape(signal,[],nW);
t = [0:max(size(signal))-1]/fs; % t of padded signal

%% Feature 1 - Average Heart Rate (avgHR) 
[n,m]= size(signal_r); % we need m
for i=1:m-1 
    signal = signal_r(:,i);
    t = [0:max(size(signal))-1]/fs;
    [pks, locs] = findpeaks(signal(),t,'MinPeakHeight',1,'MinPeakDistance',0.5,'MaxPeakWidth',0.05);
    numBeats = length(pks);
    time = t(6000); % max time (should be about 60 secs per signal)
    avgHR(i) = numBeats/time*60;
        if i==m-1
            i=m; % special case for the last window
            signal = signal_r(:,i);
            signal = signal(1:end-temp);
            t = [0:max(size(signal))-1]/fs;
            [pks, locs] = findpeaks(signal(),t,'MinPeakHeight',1,'MinPeakDistance',0.5,'MaxPeakWidth',0.05);
            numBeats = length(pks);
            time = t(length(t)); % max time in this last window
            avgHR(i) = numBeats/time*60;
        end
end

%% Feature 2 - Power Spectral Entropy (PSE)
% this is the fft(ACF) per window

for i=1:m
    signal = signal_r(:,i);
    N = length(signal);
    freq(i,:) = fs*(0:length(signal)-1)/length(signal);
    ACF = autocorr(signal,length(signal)-1);
    PSD(i,:) = fft(ACF);
end

% PSD_n(f) calculations
upperlim = fs/2;
lowerlim = -fs/2;
for i=1:m
    PSDtemp = PSD(i,:);
    ftemp = freq(i,:);
    if lowerlim<min(ftemp)
        lowerlim = 1;
    end
    PSDtemp2 = PSDtemp(lowerlim:upperlim);
    PSD_n(i,:) = PSDtemp./sum(PSDtemp2);
end

% NOTE: need to do the PSE part now
PSE = PSD_n.*log2(PSD_n);

for i=1:m
    PSEtemp = PSE(i,:);
    PSEtemp = PSEtemp(lowerlim:upperlim);
    PSEfinal(i) = sum(PSEtemp);
end

% final feature vectors are: avgHR and PSEfinal

end

