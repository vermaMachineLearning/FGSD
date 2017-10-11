%Please refer to: Katsikis, Vasilios N and Pappas,
%Dimitrios and Petralias, Athanassios. "An improved method for the computation of the Moore-Penrose inverse matrix"
%https://arxiv.org/abs/1102.1845 for further details.
function qrginv = qrginv(B) 
    
    [N,M] = size(B); 
    [Q,R,P] = qr(B);
    r=sum(any(abs(R)>1e-5,2)); 
    R1 = R(1:r,:); 
    R2 = ginv(R1); R3 = [R2 zeros(M,N-r)]; 
    A = P*R3*Q'; 
    qrginv = A;

end
