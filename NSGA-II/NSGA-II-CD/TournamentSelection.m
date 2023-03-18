%% 选择: 二元锦标赛
function Parent = TournamentSelection(PopSize,Pop)

Parent = Pop;                               % 存储每轮竞标赛选取出的最优个体，从而选出父代

%% 进行竞标赛选取个体
for i = 1 : PopSize
    % 1.随机产生2个候选者
    RandIndex = randperm(PopSize);          % 在种群中产生随机位置
    Candidate1 = Pop(RandIndex(1));         % 参赛者1
    Candidate2 = Pop(RandIndex(2));         % 参赛者2
    
    % 2.评出优胜者，作为父代
    if Candidate1.Rank < Candidate2.Rank        % 参赛者1优于参赛者2
        Parent(i) = Candidate1;
    elseif Candidate1.Rank > Candidate2.Rank    % 参赛者2优于参赛者1
        Parent(i) = Candidate2;
    else                                        % 参赛者1与参赛者2的非支配等级相同
        if Candidate1.CD >= Candidate2.Rank   	% 参赛者1的拥挤度大于等于参赛者2
            Parent(i) = Candidate1;
        else                                    % 参赛者1的拥挤度小于参赛者2
            Parent(i) = Candidate2;
        end
    end
end

end
