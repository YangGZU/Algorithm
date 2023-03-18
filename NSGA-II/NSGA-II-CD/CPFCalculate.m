%% CPF:度量解集的均匀性和延展性
function CPF = CPFCalculate(ObtainedPF,TruePF)

% 计算CPF
if size(ObtainedPF,2) ~= size(TruePF,2)
    CPF = nan;
elseif size(TruePF,1) > 1
    % Normalization
    fmin        = min(TruePF,[],1);
    fmax        = max(TruePF,[],1);
    ObtainedPF  = (ObtainedPF-repmat(fmin,size(ObtainedPF,1),1))./repmat(fmax-fmin,size(ObtainedPF,1),1);
    TruePF      = (TruePF-repmat(fmin,size(TruePF,1),1))./repmat(fmax-fmin,size(TruePF,1),1);
    % Map to the Pareto front
    [~,Close]   = min(pdist2(ObtainedPF,TruePF),[],2);
    ObtainedPF  = TruePF(Close,:);
    % Calculate the indicator value
    VPF   = Coverage(map(TruePF,TruePF),inf);
    V     = Coverage(map(ObtainedPF,TruePF),VPF/size(ObtainedPF,1));
    CPF = V./VPF;
else
    fmin       = min(ObtainedPF,[],1);
    fmax       = max(ObtainedPF,[],1);
    ObtainedPF = (ObtainedPF-repmat(fmin,size(ObtainedPF,1),1))./repmat(fmax-fmin,size(ObtainedPF,1),1);
    CPF        = Coverage(map(ObtainedPF,ObtainedPF),1/size(ObtainedPF,1));
end

end

function y = map(x,PF)
% Project the points in an (M-1)-d manifold to an (M-1)-d unit hypercube

[N,M] = size(x);
x  = x - repmat((sum(x,2)-1)/M,1,M);
PF = PF - repmat((sum(PF,2)-1)/M,1,M);
x  = x - repmat(min(PF,[],1),size(x,1),1);
x  = x./repmat(sum(x,2),1,M);
x  = max(1e-6,x);
y  = zeros(N,M-1);
for i = 1 : N
    c = ones(1,M);
    k = find(x(i,:)~=0,1);
    for j = k+1 : M
        temp     = x(i,j)/x(i,k)*prod(c(M-j+2:M-k));
        c(M-j+1) = 1/(temp+1);
    end
    y(i,:) = c(1:M-1);
end
y = y.^repmat(M-1:-1:1,N,1);
end

function V = Coverage(P,maxv)
% Calculate the hypervolume of each point's monopolized hypercube

[N,M] = size(P);
L = zeros(N,1);
for x = 1 : N
    P1      = P;
    P1(x,:) = inf;
    L(x)    = min(max(abs(P1-repmat(P(x,:),N,1)),[],2));
end
L     = min(L,maxv.^(1/M));
Lower = max(0,P-repmat(L/2,1,M));
Upper = min(1,P+repmat(L/2,1,M));
V     = sum(prod(Upper-Lower,2));
end