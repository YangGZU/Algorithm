%% 计算每个非支配集合中所有个体的拥挤度
function Pop = CrowdingDistanceSort(RankNum,Pop,FuncNum)

EndIndex = 0;                                       % 当前非支配等级最后一个个体的索引，并且初始化为0
for Rank = 1 : length(RankNum)
    % 1.计算每一个非支配等级中个体的拥挤度
    RNSize = RankNum(Rank);                       	% 非支配等级为Rank的个体数
    CD = zeros(RNSize,FuncNum);                  	% 将每一个目标函数的拥挤度初始化为0

    % 2.获取非支配等级为Rank的所有个体
    StartIndex = EndIndex + 1;                     	% 非支配等级为Rank的第一个个体的索引
    EndIndex = EndIndex + RNSize;                 	% 非支配等级为Rank的最后一个个体的索引
    FitValue = zeros(RNSize,FuncNum);               % 存储非支配等级为Rank的所有个体的目标函数
    for i = StartIndex : EndIndex
        FitValue(i - StartIndex + 1,:) = Pop(i).Fitness;
    end

    % 3.遍历每一个目标函数，计算非支配等级为Rank中每个个体的第r个函数的拥挤度
    for r = 1 : FuncNum
        if RNSize == 1
            CD(1,r) = +Inf;
        elseif RNSize == 2
            CD(1,r) = +Inf;
            CD(2,r) = +Inf;
        elseif RNSize >= 3
            % 3.1.根据第r个目标函数值对该等级的个体进行排序
            [~,rIndex] = sort(FitValue(:,r));     	% rIndex为按第r个目标函数升序排序后的个体索引
            FVr = sortrows(FitValue,r);            	% 第r个目标函数升序排序后的个体
            
            % 3.3.两个边界点的拥挤度设为正无穷，以确保每次都能被选入下一代
            CD(rIndex(1),r) = +Inf;
            CD(rIndex(RNSize),r) = +Inf;
            
            % 3.4.计算边界内的点的第f个目标函数的拥挤度
            for i = 2 : RNSize - 1
                CD(rIndex(i),r) = (FVr(i+1,r) - FVr(i-1,r)) / (FVr(RNSize,r) - FVr(1,r) + eps);
            end            
        end
    end

    % 4.所有目标函数对应的拥挤度求和
	CD = sum(CD,2);
    
    % 5.为非支配等级为Rank的所有个体赋值拥挤度
    for i = StartIndex : EndIndex
        Pop(i).CD = CD(i - StartIndex + 1);
    end

    % 6.非支配等级为Rank的所有个体按拥挤度降序排序
    % 冒泡排序
    for i = StartIndex : EndIndex
        for j = i + 1 : EndIndex
            if Pop(i).CD < Pop(j).CD
                PopTemp = Pop(i);
                Pop(i) = Pop(j);
                Pop(j) = PopTemp;
            end
        end
    end
end

end