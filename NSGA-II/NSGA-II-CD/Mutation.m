%% 多项式变异
function Offspring = Mutation(PopSize,Offspring,dim,lb,ub,Pm,YitaM)

%% 进行变异
for i = 1 : PopSize
    if rand() < Pm
        Mu = zeros(1,dim);
        Delta = zeros(1,dim);
        
        % 1.计算Delta
        for j = 1 : dim
            Mu(j) = rand();
            if Mu(j) < 0.5
                Delta(j) = (2 * Mu(j))^(1 / (YitaM + 1)) - 1;
            else
                Delta(j) = 1 - (2 * (1 - Mu(j)))^(1 / (YitaM + 1));
            end
        end
        
        % 2.进行多项式变异
        Offspring(i).Position = Offspring(i).Position + Delta;
        % 边界处理
        Offspring(i).Position = max(Offspring(i).Position,lb);
        Offspring(i).Position = min(Offspring(i).Position,ub);
    end
end

end