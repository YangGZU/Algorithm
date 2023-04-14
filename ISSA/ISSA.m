%% QSSA
%% 清空环境
close all
clear
clc
format long

tic
%% 1.初始化条件
% 1.1.测试函数(1,2,7,12,13,21)
FuncX = 'F1';                           	% 测试函数的名称，F1到F23
[ObjFunc,dim,lb,ub] = TestingFunc(FuncX);
% dim: 决策变量的维度
% lb: 决策变量的下限
% ub: 决策变量的上限

% 1.2.种群参数
PopSize = 30;                               % 麻雀数量
IterMax = 500;                           	% 最大的迭代次数

RatioExpl = 0.2;                          	% 探索者的比例
NumExpl = round(PopSize * RatioExpl);     	% 探索者的数量

RatioDefe = 0.2;                          	% 防御者的比例
NumDefe = round(PopSize * RatioDefe);     	% 防御者的数量

ST = 0.8;                                	% 安全阈值

% 1.3.其他参数
ConvCurve = zeros(IterMax + 1,1);           % 存储每一代的最优值

%% 2.种群初始化
emptyPop.Position = [];                     % 个体位置
emptyPop.Fitness = [];                  	% 适应度
emptyPop.Best.Position = [];                % 个体极值
emptyPop.Best.Fitness = [];                 % 个体极值的适应度
Pop = repmat(emptyPop,PopSize,1);           % 个体的属性
GlobalBest.Position = [];                   % 群体极值
GlobalBest.Fitness = +Inf;                  % 群体极值的适应度(若是求最大则初值为0)

% 2.1.种群初始化
for i = 1 : PopSize
    % 2.1.1.个体初始化
    Pop(i).Position = unifrnd(lb,ub);               % 个体位置初始化
    Pop(i).Fitness = ObjFunc(Pop(i).Position);      % 计算个体的适应度
    
    % 2.1.2.个体极值初始化
    Pop(i).Best.Position = Pop(i).Position;         % 初始化个体极值
    Pop(i).Best.Fitness = Pop(i).Fitness;           % 初始化个体极值的适应度
    
    % 2.1.3.群体极值更新
    if Pop(i).Best.Fitness < GlobalBest.Fitness
        GlobalBest.Position = Pop(i).Best.Position; % 更新群体极值
        GlobalBest.Fitness = Pop(i).Best.Fitness;   % 更新群体极值的适应度
    end
end

% 2.2.收敛曲线
ConvCurve(1) = GlobalBest.Fitness;

%% 3.主循环
for t = 1 : IterMax
    [~,Index] = sort([Pop(1 : PopSize).Fitness]);           % 对适应度进行升序排序
    
    Best.Position = Pop(Index(1)).Position;                 % 第t代最优个体的位置
    Best.Fitness = Pop(Index(1)).Fitness;                   % 第t代最优个体的适应度
    
    Worst.Position = Pop(Index(PopSize)).Position;          % 第t代最差个体的位置
    Worst.Fitness = Pop(Index(PopSize)).Fitness;            % 第t代最差个体的适应度

    % 3.1.探索者的位置更新
    R2 = rand();                                            % 预警值 [0,1]
    for i = 1 : NumExpl
        if R2 < ST                                          % 预警值较小，没有捕食者出现
            Alpha = rand();
            if rand() <= 0.5
                Pop(Index(i)).Position = Pop(Index(i)).Best.Position * (1 + exp(-t / (Alpha * IterMax)));
            else
                Pop(Index(i)).Position = Pop(Index(i)).Best.Position * (1 - exp(-t / (Alpha * IterMax)));
            end
        else                                                % 预警值较大，有捕食者出现，种群安全受到威胁，去其他地方觅食
            Pop(Index(i)).Position = Pop(Index(i)).Best.Position + randn(1,dim);
        end
    end
    
    % 3.2.追随者的位置更新
    for i = NumExpl + 1 : PopSize
        A = floor(rand(1,dim) * 2) * 2 - 1;             	% A为随机向量，值为-1或1
        if i <= PopSize / 2                                 % 这部分追随者围绕最好的探索者周围进行觅食，其间也有可能发生食物的争夺，使其自己变成探索者
            Pop(Index(i)).Position = Best.Position + abs(Pop(Index(i)).Best.Position - Best.Position) * (A' * (A * A')^(-1));
        else                                                % 这部分追随者处于十分饥饿的状态，需要到其它地方觅食
            Pop(Index(i)).Position = randn(1,dim) .* exp((Worst.Position - Pop(Index(i)).Best.Position) / (i^2));
        end
    end
    
    % 3.3.防御者的位置更新
    RandIndex = randperm(PopSize);                      	% 在种群中产生随机位置，前面NumDefe个是防御者
    DefeIndex = RandIndex(1 : NumDefe);                    	% 防御者的位置
    for i = 1 : NumDefe
        if Pop(DefeIndex(i)).Fitness == Best.Fitness      	% 处于种群中心的麻雀
            Pop(DefeIndex(i)).Position = Pop(DefeIndex(i)).Best.Position + (2 * rand() - 1) * abs(Pop(DefeIndex(i)).Best.Position - Worst.Position) / ((Pop(DefeIndex(i)).Best.Fitness - Worst.Fitness) + 1e-50);
        else                                                % 处于种群外围的麻雀
            Pop(DefeIndex(i)).Position = Best.Position + randn(1,dim) .* abs(Pop(DefeIndex(i)).Best.Position - Best.Position);
        end
    end
    
    % 3.4.计算适应度并更新个体极值和群体极值
    for i = 1 : PopSize
        % 3.4.1.位置的边界处理
        Pop(i).Position = max(Pop(i).Position,lb);
        Pop(i).Position = min(Pop(i).Position,ub);
        
        % 3.4.2.计算适应度
        Pop(i).Fitness = ObjFunc(Pop(i).Position);
        
        % 3.4.3.更新个体极值
        if Pop(i).Fitness < Pop(i).Best.Fitness
            Pop(i).Best.Position = Pop(i).Position;
            Pop(i).Best.Fitness = Pop(i).Fitness;
        end
        
        % 3.4.3.更新群体极值
        if Pop(i).Best.Fitness < GlobalBest.Fitness
            GlobalBest.Position = Pop(i).Best.Position;
            GlobalBest.Fitness = Pop(i).Best.Fitness;
        end
    end
    
    ConvCurve(t+1) = GlobalBest.Fitness;
end
toc

%% 4.输出结果与数据可视化
disp('The best solution obtained by QSSA is :')
disp(num2str(GlobalBest.Position))

disp('The best optimal value of the objective funciton found by QSSA is :')
disp(num2str(GlobalBest.Fitness))

% 收敛图像
figure(1)
plot(0 : IterMax,ConvCurve,'LineWidth',2);
xlabel('Iteration');
ylabel('Fitness');
set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',14,'FontWeight','bold');
