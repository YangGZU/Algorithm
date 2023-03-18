%% IGD: 度量解集的收敛性和多样性
function IGD = IGDCalculate(ObtainedPF,TruePF)

if size(ObtainedPF,2) ~= size(TruePF,2)
    IGD = nan;
else
    IGD = mean(min(pdist2(TruePF,ObtainedPF),[],2));
end

end