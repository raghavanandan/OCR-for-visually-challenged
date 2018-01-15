function [G,res] =fcm(im)
rand('state',2);
expo = 2;
mi = 100;
epsilon = 5e-4;
cluster_n = 3;

im = double(im);
[r1 c1] = size(im);
data = im(:);
datan = size(data, 1);
inn = size(data, 2); 
obj = zeros(mi, 1);
infostr = '';
kernel_b = 150;
U = rand(cluster_n, datan);%initial objective functoin with rancom numbers
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :);
index = randperm(datan);
center_old = data(index(1:cluster_n),:);
for i = 1:mi
    feature_n = size(data,2);  
    mf = U.^expo;       
    dist = zeros(size(center_old, 1), size(data, 1));
    for k = 1:size(center_old, 1),
        dist(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center_old(k,:)).^2)',1));
    end
    KernelMat = exp(-dist.^2/kernel_b^2);
    num = mf.*KernelMat * data;  
    den = sum(mf.*KernelMat,2);   
    center = num./(den*ones(1,feature_n)); 
    cluster_n = size(center, 1);
    data_n = size(data, 1);
    kdist = zeros(cluster_n, data_n);
    for j = 1:cluster_n 
        vi = center(j,:);
        dist1 = zeros(size(vi, 1), size(data, 1));
        for k = 1:size(vi, 1),

            dist1(k, :) = sqrt(sum(((data-ones(size(data,1),1)*vi(k,:)).^2)',1));
        end
        kdist(j,:) = 2-2*exp(-dist1.^2/kernel_b^2);                
    end
    obj(i) = sum(sum((kdist.^2).*mf)); 
    tmp = kdist.^(-1/(expo-1));     
    U = tmp./(ones(cluster_n, 1)*sum(tmp));           

    center_old = center;            
    if i > 1
        if abs(obj(i) - obj(i-1)) < epsilon,
            break; 
        end
    end
end
iter_n = i;
obj(iter_n+1:mi) = [];    


maxU = max(U);
data = data';


for k = 1:cluster_n
    indk = (U(k,:) == maxU);
    Ik = indk.*data;
    Ik = reshape(Ik,r1,c1);
    res{k} = Ik;
    G(indk) = k-1;
end

G = reshape(G,r1,c1);
res{end+1} = G;    

