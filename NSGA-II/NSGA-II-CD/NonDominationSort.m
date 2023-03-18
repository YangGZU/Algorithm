%% 计算种群的非支配等级，并按非支配等级进行排序
function [Pop,RankNum] = NonDominationSort(Pop,FuncNum)

PopSize = length(Pop);                  
Rank = 1;                               % 非支配等级，初始化为1
NDS(Rank).Set = [];                     % 非支配等级为Rank的解的集合，即非支配等级为Rank的Pareto前沿的所有个体
P = [];                                 % 个体P的集合

% 1.求出Rank = 1的所有个体
for i = 1 : PopSize
    % 1.1.计算集合P中每个个体的两个属性
    P(i).n = 0;                         %#ok<AGROW> % 种群中支配个体i的个体数
    P(i).s = [];                        %#ok<AGROW> % 个体i支配的所有个体组成的集合s
    for j = 1 : PopSize
        Less = sum(Pop(i).Fitness < Pop(j).Fitness);        % 个体i的目标函数中小于个体j的目标函数的个数
        Equal = sum(Pop(i).Fitness == Pop(j).Fitness);   	% 个体i的目标函数中等于个体j的目标函数的个数
        More = FuncNum - Less - Equal;                   	% 个体i的目标函数中大于个体j的目标函数的个数
        if Less == 0 && Equal ~= FuncNum
            % 个体j至少有一个目标函数小于i，故个体j支配个体i
            P(i).n = P(i).n + 1;
        elseif More == 0 && Equal ~= FuncNum
            % 个体i至少有一个目标函数小于j，故个体i支配个体j
            P(i).s = [P(i).s,j];
        end
    end
    
    % 1.2.将种群中P(i).n = 0的个体放入集合Rank(1).Set中
    if P(i).n == 0
        Pop(i).Rank = 1;                        % 存储个体的非支配等级
        NDS(Rank).Set = [NDS(Rank).Set,i];      % 存储非支配等级为Rank = 1的所有个体的索引
    end
end

% 2.求出Rank = 2,3,4,...的集合
while ~isempty(NDS(Rank).Set)
    Q = [];                                     % 存储非支配等级为Rank + 1的所有个体
    for i = 1 : length(NDS(Rank).Set)           % 遍历非支配等级为Rank的所有个体
        if ~isempty(P(NDS(Rank).Set(i)).s)      % P(NDS(Rank).Set(i)).s 是非支配等级为Rank的个体i所支配的所有个体
            for j = 1 : length(P(NDS(Rank).Set(i)).s)   % 遍历非支配等级为Rank的个体i所支配的所有个体
                % 因为支配个体j的个体i已经标记好了非支配等级，故减1
                P(P(NDS(Rank).Set(i)).s(j)).n = P(P(NDS(Rank).Set(i)).s(j)).n - 1; %#ok<AGROW>
                if P(P(NDS(Rank).Set(i)).s(j)).n == 0   % 已经没有未标记非支配等级的个体支配个体j了
                    Pop(P(NDS(Rank).Set(i)).s(j)).Rank = Rank + 1;
                    Q = [Q,P(NDS(Rank).Set(i)).s(j)];   %#ok<AGROW>
                end
            end
        end
    end
    Rank = Rank + 1;
    NDS(Rank).Set = Q;
end

% 3.对Pareto解按非支配等级进行排序
% 冒泡排序
for i = 1 : PopSize
    for j = i + 1 : PopSize
        if Pop(i).Rank > Pop(j).Rank
            PopTemp = Pop(i);
            Pop(i) = Pop(j);
            Pop(j) = PopTemp;
        end
    end
end

% 4.获取每个非支配等级的个体个数，存储在RankNum
RankNum = zeros(Rank - 1,1);          % Rank的最后一个字段为空，无需计算，故减1
for k = 1 : Rank - 1
    RankNum(k) = length(NDS(k).Set);
end

end