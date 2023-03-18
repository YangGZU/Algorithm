%% 获取真实的Pareto前沿
function TruePF = GetTrueParetoFront(FuncX)

switch FuncX    
    case 'UF1'
        load ('UF.mat','UF1')
        TruePF = UF1;

    case 'UF2'
        load ('UF.mat','UF2')
        TruePF = UF2;
        
    case 'UF3'
        load ('UF.mat','UF3')
        TruePF = UF3;

    case 'UF4'
        load ('UF.mat','UF4')
        TruePF = UF4;

    case 'UF5'
        load ('UF.mat','UF5')
        TruePF = UF5;

    case 'UF6'
        load ('UF.mat','UF6')
        TruePF = UF6;
        
    case 'UF7'
        load ('UF.mat','UF7')
        TruePF = UF7;
        
    case 'UF8'
        load ('UF.mat','UF8')
        TruePF = UF8;

    case 'UF9'
        load ('UF.mat','UF9')
        TruePF = UF9;
        
    case 'UF10'
        load ('UF.mat','UF10')
        TruePF = UF10;        
end

end