%Please refer to: Katsikis, Vasilios N and Pappas,
%Dimitrios. "Fast computing of the Moore-Penrose inverse matrix" for
%further details.

function ginv = ginv(X)
    %Returns the Moore-Penrose inverse of the argument
    if isempty(X)
        quick return
        ginv = zeros(size(X'),class(X));
        return
    end

    [n,m]=size(X);
    if rank(X) < min(n,m);
        error('matrix must be of full rank');
    else
        if n > m,
            C = X'*X ;
            ginv = C\X';
        else
            C = X*X';
            G = C\X;
            ginv = G';
        end
    
end
