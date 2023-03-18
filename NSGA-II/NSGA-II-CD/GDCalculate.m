%% GD:度量解集的收敛性
function GD = GDCalculate(ObtainedPF,TruePF)

if size(ObtainedPF,2) ~= size(TruePF,2)
    GD = nan;
else
    Distance = min(pdist2(ObtainedPF,TruePF),[],2);
    GD       = norm(Distance)/length(Distance);
end

end