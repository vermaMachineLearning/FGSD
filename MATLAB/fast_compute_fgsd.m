function fL=fast_compute_fgsd(L,type,varargin)
    
%Compute Chebyshev Polynomials Apporiximation of f(L) for a given order
%fL=fast_compute_fgsd(L,'approx')
%fL=fast_compute_fgsd(L,'approx',order)

%Compute Poylharmonic Distances for a given p
%fL=fast_compute_fgsd(L,'polyharmonic')
%fL=fast_compute_fgsd(L,'polyharmonic',p)

%Compute given moore penrose pseudo inverse for already computed f(L)
%fL=fast_compute_fgsd(f(L),'exact')




    welcome_to_FGSD
    
    % Check inputs
    if nargin < 2
        error('FGSD requires at least two inputs.');
    end
    
        
    if strcmp(type,'Approx') || strcmp(type,'approx')
        if ~isempty(varargin)
            order=varargin{1};
            str=strcat('Computing FGSD Chebyshev Polynomials of order= ',num2str(order));
            disp(str);
            fL=fgsd_chebyshev_polynomials(L,order);
        else
            str=strcat('Computing FGSD Chebyshev Polynomials of order= 3');
            disp(str);
            fL=fgsd_chebyshev_polynomials(L,3);          
        end
    elseif strcmp(type,'Polyharmonic') || strcmp(type,'polyharmonic')
        if ~isempty(varargin)
            p=varargin{1};
            str=strcat('Computing polyharmonic of p= ',num2str(p));
            Lp=L^p;
            disp(str);
            fL=fgsd_fast_pseudo_inverse(Lp);
        else
            str=strcat('Computing polyharmonic of p= 1');
            disp(str);
            fL=fgsd_fast_pseudo_inverse(L);           
        end
    elseif strcmp(type,'Exact') || strcmp(type,'exact')

        str=strcat('Computing Moore Penrose Pseudo Inverse of a given f(L)');
        disp(str);
        fL=fgsd_fast_pseudo_inverse(L);
    else
        disp('Unknown type of FGSD computation method');
         
    end
    
    
    
end