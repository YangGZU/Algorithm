%% 模拟二进制交叉
function Offspring = Crossover(PopSize,Parent,dim,lb,ub,Pc,YitaC)

Offspring = Parent;

%% 进行交叉，每次产生两个子代
for i = 1 : 2 : PopSize
    % 1.随机产生两个父代
    RandIndex = randperm(PopSize);                  % 在种群中产生随机位置, 前2个作为父代
    Parent1 = Parent(RandIndex(1));
    Parent2 = Parent(RandIndex(2));
    
    % 2.初始化两个子代
    % 此步骤必不可少，因为若不进行交叉，则子代复制父代
    Offspring1 = Parent1;
    Offspring2 = Parent2;
    
    % 3.进行模拟二进制交叉
    if rand() < Pc
        Mu = zeros(1,dim);
        Gama = zeros(1,dim);
        % 3.1.计算gama
        for j = 1 : dim
            Mu(j) = rand();
            if Mu(j) < 0.5
                Gama(j) = (2 * Mu(j))^(1 / (YitaC + 1));
            else
                Gama(j) = 1 / (2 * (1 - Mu(j)))^(1 / (YitaC + 1));
            end
        end
        
        % 3.2.进行模拟二进制交叉产生子代
        Offspring1.Position = 0.5 * ((1 + Gama) .* Parent1.Position + (1 - Gama) .* Parent2.Position);
        Offspring2.Position = 0.5 * ((1 - Gama) .* Parent1.Position + (1 + Gama) .* Parent2.Position);
        % 边界处理
        % Offspring1
        Offspring1.Position = max(Offspring1.Position,lb);
        Offspring1.Position = min(Offspring1.Position,ub);
        % Offspring2
        Offspring2.Position = max(Offspring2.Position,lb);
        Offspring2.Position = min(Offspring2.Position,ub);
    end
    
    % 4.获取两个子代
    Offspring(i) = Offspring1;
    Offspring(i+1) = Offspring2;
end

end