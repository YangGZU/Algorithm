%% SP:度量解集的均匀性
function SP = SPCalculate(ObtainedPF,~)

%% 计算SP
if isempty(ObtainedPF)
    SP       = nan;
else
    Distance = pdist2(ObtainedPF,ObtainedPF,'cityblock');
    Distance(logical(eye(size(Distance,1)))) = inf;
    SP       = std(min(Distance,[],2));
end

end