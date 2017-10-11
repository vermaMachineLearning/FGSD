function [pinvL]=fgsd_fast_pseudo_inverse(fL)
    
    %switch off anonying warning signs in case of a disconnected graph.
    warning('off','MATLAB:nearlySingularMatrix');
    warning('off','MATLAB:singularMatrix');

    %Compute B
    L_temp=fL;
    n=size(L_temp,1);
    J=ones(n,1)*ones(n,1)';
    B=eye(n)-J/n;

    %Replace any row and column by zeros and setting diagonal entry at
    %their intersection to one, and replacing corresponding row of B by
    %zeros.
    z=zeros(1,n);
    L_temp(1,:)=z;
    L_temp(:,1)=z;
    L_temp(1,1)=1;
    B(1,:)=z;

    %Compute (non-singular, may be sparse) linear system of solutions. 
    %And don't forget to clear the last warning sign.	
    lastwarn('')
    pinvL=L_temp\B;


    % Handle the case when graph is disconnected. By default, we let the
    % resistance between disconnected components  propotional to their
    % node degrees or could be set to some high (to represent infinity) value.

    [warnmsg, msgid] = lastwarn;   
    if (strcmp(msgid,'MATLAB:nearlySingularMatrix') || strcmp(msgid,'MATLAB:singularMatrix'))
    pinvL=qrginv(fL);
    else
    pinvL = pinvL- repmat(sum(pinvL)/n,n,1);
    end

end