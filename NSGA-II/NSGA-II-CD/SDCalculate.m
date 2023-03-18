%% Delta:度量解集的广泛性
function SD = SDCalculate(ObtainedPF,TruePF)

if size(ObtainedPF,2) ~= size(TruePF,2)
    SD    = nan;
else
    Dis1  = pdist2(ObtainedPF,ObtainedPF);
    Dis1(logical(eye(size(Dis1,1)))) = inf;
    [~,E] = max(TruePF,[],1);
    Dis2  = pdist2(TruePF(E,:),ObtainedPF);
    d1    = sum(min(Dis2,[],2));
    d2    = mean(min(Dis1,[],2));
    SD    = (d1+sum(abs(min(Dis1,[],2)-d2))) / (d1+(size(ObtainedPF,1)-size(ObtainedPF,2))*d2);
end

end