function [ProcessedSignal]= filtering(t,ECGsignal)
%[ECGsignal] = golay (ECGsignal, 2, 2, 4);

%% notch filtering
b_notch =[0.99 1.604 0.307]; % this accounts for the DC gain calculation from the prelab as well 
a_notch = [1];

% % Output of the notch filter %
notchFiltOut=filter(b_notch,a_notch,ECGsignal); %val instead of ECGsignal for .mat file

%% butterworth bandpass filter with a 0.5 Hz to 15 Hz  100 Hz sampling rate
[b,a] = butter(2,[0.5 15]/50);
% d = designfilt('bandpassiir','FilterOrder',4, ...
%     'HalfPowerFrequency1',0.5,'HalfPowerFrequency2',15, ... 'SampleRate',100);
% 
% sos = ss2sos(A,B,C,D);
% fvt = fvtool(sos,d,'Fs',100);
% legend(fvt,'butter','designfilt')

bpbutter = filter(b, a, ECGsignal);

% figure;
% subplot(3,1,1);
% plot(t,ECGsignal)
% title('Original ECG from database');
% xlabel('Time (s)');
% ylabel('ECG Amplitude');
% subplot(3,1,2);
% plot(t,notchFiltOut)
% title('Plot of ECG After Notch Filter');
% xlabel('Time (s)');
% ylabel('ECG Amplitude');
% subplot(3,1,3);
% plot(t,bpbutter)
% title('Plot of ECG Butterworth BP Filter');
% xlabel('Time (s)');
% ylabel('ECG Amplitude');

%% golay

[ProcessedSignal]=golay (bpbutter, 2, 2, 4);



end