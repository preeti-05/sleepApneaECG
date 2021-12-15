function [ANN]= labeling(i) 
precall = strcat('a0',num2str(i));
    ann=rdann(precall, 'apn', [],[],[],'N');
    N = length(ann);
    annN = zeros(N,2);
    annN(1:N,1) = ann;
     
for j=1:N
    annN(j,2) = 0; % 0 means N
end

ann=rdann(precall, 'apn', [],[],[],'A');
N = length(ann);
annA = zeros(N,2);
annA(1:N,1) = ann;
   
for k=1:N
    annA(k,2) = 1; % 1 means A
end

% merge annotations 
ANNtemp = [annN;annA];

% sort 

ANN = sortrows(ANNtemp);

end