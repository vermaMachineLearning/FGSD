function [fL,Tn,Tn_1]=fgsd_chebyshev_polynomials(L,order)

    if order==0
        N=length(L);
        fL= eye(N,N);
        Tn=[];
        Tn_1=[];
        return
    elseif order==1
        fL= L;
        N=length(L);
        Tn=eye(N,N);
        Tn_1=[];
        return
    else
        [Tn,Tn_1,]=fgsd_chebyshev_polynomials(L,order-1);
        fL= 2*L*Tn-Tn_1;
        return
    end
    

end