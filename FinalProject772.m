function FinalProject772 


for i=[1:1:8] % will change i accrodingly
   
    Name = strcat('a0',num2str(i),'.dat');
    
    [ECGsignal, fs, t]= rdsamp(Name,1);
    [ProcessedSignal]= filtering(t,ECGsignal);

%     saveNameMat = strcat('a0',num2str(i),'.mat');
%     
%     save(saveNameMat,'ProcessedSignal','-double');

    [ANN]= labeling(i);
    [avgHR, PSEfinal]=featureExtration (ProcessedSignal);
    featureTable(avgHR, PSEfinal, ANN, i);
 
    

end

end





