%Load mat file containg cell of graphs adjacency matrices.


load('G_mutag.mat');
N=length(G);

%Set histogram parameters.
nbins=140000;   
binwidth=0.0001;

%Create empty (sparse) feature matrix;
X=zeros(N,nbins); %or X=sparse(N,nbins) for memory efficiency.

for i=1:N
    
    %Load adjacency matrix.
    A=G{i};
    
    %Compute graph Laplacian L (or Lnorm or Lrw).
    L=diag(sum(A,2))-A;
    
    %Compute f(L).
    fL=fast_compute_fgsd(L,'polyharmonic',1);
    
    %Create all-one column vector.
    ones_vector=ones(length(A),1);
    
    %Compute FGSD matrix.
    S=diag(fL)*ones_vector'+ones_vector*diag(fL)'-2*fL;
    
    %Compute (sparse) feature matrix.
    X(i,:)= histcounts(S(:),nbins,'Binwidth',binwidth,'BinLimits',[0,nbins*binwidth]); %Note that MATLAB histcounts function can limit the maximum nbins that are allowed. You can increase the limit by editing the histcounts.m file.
        
end

%Remove all zeros-column from feature matrix.
X(:,~any(X,1)) = [];

save X_mutag.mat X %or save X_mutag.mat X -v7.3 (for large N)
