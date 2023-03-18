%% NSGAII
%% 清空环境和设置数据长度
close all
clear 
clc
format long
tic

%% 1.NSGAII的参数
% 无约束测试函数：UF1-10
FuncX = 'UF1';                      % 测试函数的名称
[ObjFunc,FuncNum,dim,lb,ub] = TestingFunc(FuncX);
TruePF = GetTrueParetoFront(FuncX);	% 获取真实的Pareto前沿
% ObjFunc: 目标函数; % FuncNum: 目标函数的个数; dim: 变量的个数
% lb: 变量的下界; ub: 变量的上界

% 1.2.种群参数
PopSize = 100;                      % 种群大小
IterMax = 2000;                  	% 最大的迭代次数
Pc = 0.9;                           % 交叉概率
Pm = 1/dim;                         % 变异概率
YitaC = 20;                         % 模拟二进制交叉参数
YitaM = 20;                         % 多项式变异参数

% 1.3.评价指标
Metric = zeros(IterMax,5);

%% 2.种群初始化
emptyPop.Position = [];           	% 决策变量
emptyPop.Fitness = [];              % 目标函数
emptyPop.Rank = [];                 % 非支配等级
emptyPop.CD = [];                   % 拥挤度
Pop = repmat(emptyPop,PopSize,1);

% 2.1.初始化决策变量和目标函数
for i = 1 : PopSize
    Pop(i).Position = unifrnd(lb,ub);
    Pop(i).Fitness = ObjFunc(Pop(i).Position,dim);
end

% 2.2.初始种群的非支配等级，并且按非支配等级从小到大进行排序
[Pop,RankNum] = NonDominationSort(Pop,FuncNum);

% 2.3.计算初始种群的拥挤度，并且按拥挤度从大到小进行排序
Pop = CrowdingDistanceSort(RankNum,Pop,FuncNum);

%% 3.主循环
for t = 2 : IterMax
    % 3.1.选择: 二元锦标赛
    Parent = TournamentSelection(PopSize,Pop);

    % 3.2.交叉: 模拟二进制交叉
    Offspring = Crossover(PopSize,Parent,dim,lb,ub,Pc,YitaC);

    % 3.3.变异: 多项式变异
    Offspring = Mutation(PopSize,Offspring,dim,lb,ub,Pm,YitaM);

    % 3.4.计算子代的目标函数
    for i = 1 : PopSize
        Offspring(i).Fitness = ObjFunc(Offspring(i).Position,dim);
    end

    % 3.5.精英保留策略
    PopCom = [Pop;Offspring];       % 将上一代和这一代合并
    [PopCom,RankNum] = NonDominationSort(PopCom,FuncNum);   % 计算非支配等级，并且按非支配等级从小到大进行排序
    PopCom = CrowdingDistanceSort(RankNum,PopCom,FuncNum);  % 计算拥挤度，并且按拥挤度从大到小进行排序
    Pop = PopCom(1:PopSize);                                % 挑选排名前一半的个体作为下一代
    
    % 3.6.计算评价指标
    FitValue = [];
    for i = 1 : numel(Pop)
        if Pop(i).Rank == 1
            FitValue(i,:) = Pop(i).Fitness;                     %#ok<SAGROW>
        end
    end
    
    % 3.6.1.IGD:度量解集的收敛性和多样性,越小越好
    IGD = IGDCalculate(FitValue,TruePF);
    
    % 3.6.2.CPF:度量解集的均匀性和延展性,越大越好
    CPF = CPFCalculate(FitValue,TruePF);
    
    % 3.6.3.GD:度量解集的收敛性
    GD = GDCalculate(FitValue,TruePF);
    
    % 3.6.4.SP:度量解集的均匀性
    SP = SPCalculate(FitValue,TruePF);
    
    % 3.6.5.SD:度量解集的广泛性
    SD = SDCalculate(FitValue,TruePF);
    
    Metric(t,:) = [IGD,CPF,GD,SP,SD];     

    if rem(t,10) == 0
        clc;
        fprintf('Run %d\n',t);
        fprintf('Progress Rate %s%%\n',num2str(t / IterMax * 100));
    end
end
toc

%% 4.计算评价指标
% 4.1.IGD:度量解集的收敛性和多样性,越小越好
disp(['Inverted Generational Distance = ',num2str(Metric(end,1))])

% 4.2.CPF:度量解集的均匀性和延展性,越大越好
disp(['Coverage over Pareto front = ',num2str(Metric(end,2))])

% 4.3.GD:度量解集的收敛性
disp(['Generational Distance = ',num2str(Metric(end,3))])

% 4.4.SP:度量解集的均匀性
disp(['Spacing = ',num2str(Metric(end,4))])

% 4.5.SD:度量解集的广泛性
disp(['Spread = ',num2str(Metric(end,5))])

%% 5.数据可视化
% Pareto曲线
figure(1)
if FuncNum == 2
    plot(TruePF(:,1),TruePF(:,2),'.','MarkerSize',20);hold on
    plot(FitValue(:,1),FitValue(:,2),'r.','MarkerSize',20);hold on
    xlabel('\it{f_1}')
    ylabel('\it{f_2}')
elseif FuncNum == 3
    plot3(TruePF(:,1),TruePF(:,2),TruePF(:,3),'.','MarkerSize',20);hold on
    plot3(FitValue(:,1),FitValue(:,2),FitValue(:,3),'r.','MarkerSize',20);
    xlabel('\it{f_1}')
    ylabel('\it{f_2}')
    zlabel('\it{f_3}')
    grid on
end
legend('True Pareto front','NSGA-II Pareto front','Location','NorthEast','FontSize',14)
set(gca,'LineWidth',1.5,'FontName','Times New Roman','FontSize',14,'FontWeight','bold')

% IGD的变化曲线
figure(2)
plot(1 : IterMax,Metric(:,1),'LineWidth',2);
xlabel('Iteration');
ylabel('IGD');
set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',14,'FontWeight','bold');

% CPF的变化曲线
figure(3)
plot(1 : IterMax,Metric(:,2),'LineWidth',2);
xlabel('Iteration');
ylabel('CPF');
set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',14,'FontWeight','bold');

% GD的变化曲线
figure(4)
plot(1 : IterMax,Metric(:,3),'LineWidth',2);
xlabel('Iteration');
ylabel('GD');
set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',14,'FontWeight','bold');

% SP的变化曲线
figure(5)
plot(1 : IterMax,Metric(:,4),'LineWidth',2);
xlabel('Iteration');
ylabel('SP');
set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',14,'FontWeight','bold');

% SD的变化曲线
figure(6)
plot(1 : IterMax,Metric(:,5),'LineWidth',2);
xlabel('Iteration');
ylabel('SD');
set(gca,'LineWidth',2,'FontName','Times New Roman','FontSize',14,'FontWeight','bold');