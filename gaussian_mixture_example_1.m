% Produce random numbers by Gaussian mixture and try to retrieve the
% parameters.
% Currently only works with 2 mixtures

% Means
mu      = [10 20 30];
sigma   = [2 2 2];
c       = [0.5 0.3 0.2];
% normalize c
c/=sum(c);

% Realization
T=1000000; % number of samples 
% make array to easily compute mixture indicators
c_cumsum=cumsum(c);
c_ary=zeros(1,T);
n=1;
k=1;
for c_=c_cumsum
    idx=n:length(c_ary)*c_;
    l_=length(idx)
    c_ary(idx)=k.*ones(1,l_);
    n+=l_;
    k+=1;
end
% permute randomly
c_ary(randperm(length(c_ary)))=c_ary;
c_ary=c_ary(:);
% realize N processes
x=randn(T,length(mu)).*sqrt(sigma).+mu;
% realize mixture coefficients
m=repmat(1:length(c),[length(c_ary) 1]) == c_ary;
x=sum(x.*m,2);

figure(1)
hist(x,1000)
