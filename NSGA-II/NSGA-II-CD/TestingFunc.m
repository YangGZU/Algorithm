%% 测试函数
function [ObjFunc,FuncNum,dim,lb,ub] = TestingFunc(FuncX)

switch FuncX
    % UF系列
    case 'UF1'
        ObjFunc = @UF1;
        FuncNum = 2;
        dim = 30;
        lb = [0,-1 * ones(1,dim-1)];
        ub = [1,1 * ones(1,dim-1)];
        
    case 'UF2'
        ObjFunc = @UF2;
        FuncNum = 2;
        dim = 30;
        lb = [0,-1 * ones(1,dim-1)];
        ub = [1,1 * ones(1,dim-1)];
        
    case 'UF3'
        ObjFunc = @UF3;
        FuncNum = 2;
        dim = 30;
        lb = 0 * ones(1,dim);
        ub = 1 * ones(1,dim);
        
    case 'UF4'
        ObjFunc = @UF4;
        FuncNum = 2;
        dim = 30;
        lb = [0,-2 * ones(1,dim-1)];
        ub = [1,2 * ones(1,dim-1)];
        
    case 'UF5'
        ObjFunc = @UF5;
        FuncNum = 2;
        dim = 30;
        lb = [0,-1 * ones(1,dim-1)];
        ub = [1,1 * ones(1,dim-1)];
        
    case 'UF6'
        ObjFunc = @UF6;
        FuncNum = 2;
        dim = 30;
        lb = [0,-1 * ones(1,dim-1)];
        ub = [1,1 * ones(1,dim-1)];
        
    case 'UF7'
        ObjFunc = @UF7;
        FuncNum = 2;
        dim = 30;
        lb = [0,-1 * ones(1,dim-1)];
        ub = [1,1 * ones(1,dim-1)];
        
    case 'UF8'
        ObjFunc = @UF8;
        FuncNum = 3;
        dim = 30;
        lb = [0,0,-2 * ones(1,dim-2)];
        ub = [1,1,2 * ones(1,dim-2)];
        
    case 'UF9'
        ObjFunc = @UF9;
        FuncNum = 3;
        dim = 30;
        lb = [0,0,-2 * ones(1,dim-2)];
        ub = [1,1,2 * ones(1,dim-2)];
        
    case 'UF10'
        ObjFunc = @UF10;
        FuncNum = 3;
        dim = 30;
        lb = [0,0,-2 * ones(1,dim-2)];
        ub = [1,1,2 * ones(1,dim-2)];
        
end

end

%% UF1
function f = UF1(x,dim)

normOdd = 0;
sumOdd = 0;

normEven = 0;
sumEven = 0;

for j = 2 : dim
    y = x(j) - sin(6 * pi * x(1) + j * pi / dim);
    if mod(j,2) == 1
        normOdd = normOdd + j;
        sumOdd = sumOdd + y^2;
    else
        normEven = normEven + j;
        sumEven = sumEven + y^2;
    end
end

% 求目标函数1
f1 = x(1) + 2 / normOdd * sumOdd;

% 求目标函数2
f2 = 1 - x(1)^0.5 + 2 / normEven * sumEven;

% 合并
f = [f1,f2];

end

%% UF2
function f = UF2(x,dim)

normOdd = 0;
sumOdd = 0;

normEven = 0;
sumEven = 0;

for j = 2 : dim
    if mod(j,2) == 1
        normOdd = normOdd + j;
        y = x(j) - (0.3 * x(1)^2 * cos(24 * pi * x(1) + 4 * j * pi / dim) + 0.6 * x(1)) * cos(6 * pi * x(1) + j * pi / dim);
        sumOdd = sumOdd + y^2;
    else
        normEven = normEven + j;
        y = x(j) - (0.3 * x(1)^2 * cos(24 * pi * x(1) + 4 * j * pi / dim) + 0.6 * x(1)) * sin(6 * pi * x(1) + j * pi / dim);
        sumEven = sumEven + y^2;
    end
end

% 求目标函数1
f1 = x(1) + 2 / normOdd * sumOdd;

% 求目标函数2
f2 = 1 - x(1)^0.5 + 2 / normEven * sumEven;

% 合并
f = [f1,f2];

end

%% UF3
function f = UF3(x,dim)

normOdd = 0;
sumOdd = 0;
proOdd = 1;

normEven = 0;
sumEven = 0;
proEven = 1;

for j = 2 : dim
    y = x(j) - x(1)^(0.5 * (1 + 3 * (j - 2) / (dim - 2)));
    if mod(j,2) == 1
        normOdd = normOdd + j;
        sumOdd = sumOdd + y^2;
        proOdd = proOdd * cos(20 * y * pi / j^0.5);
    else
        normEven = normEven + j;
        sumEven = sumEven + y^2;
        proEven = proEven * cos(20 * y * pi / j^0.5);
    end
end

% 求目标函数1
f1 = x(1) + 2 / normOdd * (4 * sumOdd - 2 * proOdd + 2);

% 求目标函数2
f2 = 1 - x(1)^0.5 + 2 / normEven * (4 * sumEven - 2 * proEven + 2);

% 合并
f = [f1,f2];

end

%% UF4
function f = UF4(x,dim)

normOdd = 0;
sumOdd = 0;

normEven = 0;
sumEven = 0;

for j = 2 : dim
    y = x(j) - sin(6 * pi * x(1) + j * pi / dim);
    if mod(j,2) == 1
        normOdd = normOdd + j;
        sumOdd = sumOdd + abs(y) / (1 + exp(2 * abs(y)));
    else
        normEven = normEven + j;
        sumEven = sumEven + abs(y) / (1 + exp(2 * abs(y)));
    end
end

% 求目标函数1
f1 = x(1) + 2 / normOdd * sumOdd;

% 求目标函数2
f2 = 1 - x(1)^2 + 2 / normEven * sumEven;

% 合并
f = [f1,f2];

end

%% UF5
function f = UF5(x,dim)

normOdd = 0;
sumOdd = 0;

normEven = 0;
sumEven = 0;

for j = 2 : dim
    y = x(j) - sin(6 * pi * x(1) + j * pi / dim);
    if mod(j,2) == 1
        normOdd = normOdd + j;
        sumOdd = sumOdd + 2 * y^2 - cos(4 * pi * y) + 1;
    else
        normEven = normEven + j;
        sumEven = sumEven + 2 * y^2 - cos(4 * pi * y) + 1;
    end
end

% 求目标函数1
f1 = x(1) + (1/20 + 0.1) * abs(sin(20 * pi * x(1))) + 2 / normOdd * sumOdd;

% 求目标函数2
f2 = 1 - x(1) + (1/20 + 0.1) * abs(sin(20 * pi * x(1))) + 2 / normEven * sumEven;

% 合并
f = [f1,f2];

end

%% UF6
function f = UF6(x,dim)

normOdd = 0;
sumOdd = 0;
proOdd = 1;

normEven = 0;
sumEven = 0;
proEven = 1;

for j = 2 : dim
    y = x(j) - sin(6 * pi * x(1) + j * pi / dim);
    if mod(j,2) == 1
        normOdd = normOdd + j;
        sumOdd = sumOdd + y^2;
        proOdd = proOdd * cos(20 * y * pi / j^0.5);
        
    else
        normEven = normEven + j;
        sumEven = sumEven + y^2;
        proEven = proEven * cos(20 * y * pi / j^0.5);
    end
end

% 求目标函数1
f1 = x(1) + max(0,2 * (1/4 + 0.1) * abs(sin(4 * pi * x(1)))) + 2 / normOdd * (4 * sumOdd - 2 * proOdd + 2);

% 求目标函数2
f2 = 1 - x(1) + max(0,2 * (1/4 + 0.1) * abs(sin(4 * pi * x(1)))) + 2 / normEven * (4 * sumEven - 2 * proEven + 2);

% 合并
f = [f1,f2];

end

%% UF7
function f = UF7(x,dim)

normOdd = 0;
sumOdd = 0;

normEven = 0;
sumEven = 0;

for j = 2 : dim
    y = x(j) - sin(6 * pi * x(1) + j * pi / dim);
    if mod(j,2) == 1
        normOdd = normOdd + j;
        sumOdd = sumOdd + y^2;
    else
        normEven = normEven + j;
        sumEven = sumEven + y^2;
    end
end

% 求目标函数1
f1 = x(1)^0.2 + 2 / normOdd * sumOdd;

% 求目标函数2
f2 = 1 - x(1)^0.2 + 2 / normEven * sumEven;

% 合并
f = [f1,f2];

end

%% UF8
function f = UF8(x,dim)

norm1 = 0;
sum1 = 0;

norm2 = 0;
sum2 = 0;

norm3 = 0;
sum3 = 0;

for j = 3 : dim
    y = x(j) - 2 * x(2) * sin(2 * pi * x(1) + j * pi / dim);
    if mod(j,3) == 1
        norm1 = norm1 + j;
        sum1 = sum1 + y^2;
    elseif mod(j,3) == 2
        norm2 = norm2 + j;
        sum2 = sum2 + y^2;
    else
        norm3 = norm3 + j;
        sum3 = sum3 + y^2;        
    end
end

% 求目标函数1
f1 = cos(0.5 * x(1) * pi) * cos(0.5 * x(2) * pi) + 2 / norm1 * sum1;

% 求目标函数2
f2 = cos(0.5 * x(1) * pi) * sin(0.5 * x(2) * pi) + 2 / norm2 * sum2;

% 求目标函数3
f3 = sin(0.5 * x(1) * pi) + 2 / norm3 * sum3;

% 合并
f = [f1,f2,f3];

end

%% UF9
function f = UF9(x,dim)

norm1 = 0;
sum1 = 0;

norm2 = 0;
sum2 = 0;

norm3 = 0;
sum3 = 0;

for j = 3 : dim
    y = x(j) - 2 * x(2) * sin(2 * pi * x(1) + j * pi / dim);
    if mod(j,3) == 1
        norm1 = norm1 + j;
        sum1 = sum1 + y^2;
    elseif mod(j,3) == 2
        norm2 = norm2 + j;
        sum2 = sum2 + y^2;
    else
        norm3 = norm3 + j;
        sum3 = sum3 + y^2;        
    end
end

% 求目标函数1
f1 = 0.5 * (max(0,(1 + 0.1) * (1 - 4 * (2 * x(1) - 1)^2)) + 2 * x(1)) * x(2) + 2 / norm1 * sum1;

% 求目标函数2
f2 = 0.5 * (max(0,(1 + 0.1) * (1 - 4 * (2 * x(1) - 1)^2)) - 2 * x(1) + 2) * x(2) + 2 / norm2 * sum2;

% 求目标函数3
f3 = 1 - x(2) + 2 / norm3 * sum3;

% 合并
f = [f1,f2,f3];

end

%% UF10
function f = UF10(x,dim)

norm1 = 0;
sum1 = 0;

norm2 = 0;
sum2 = 0;

norm3 = 0;
sum3 = 0;

for j = 3 : dim
    y = x(j) - 2 * x(2) * sin(2 * pi * x(1) + j * pi / dim);
    h = 4 * y^2 - cos(8 * pi * y) + 1;
    if mod(j,3) == 1
        norm1 = norm1 + j;
        sum1 = sum1 + h;
    elseif mod(j,3) == 2
        norm2 = norm2 + j;
        sum2 = sum2 + h;
    else
        norm3 = norm3 + j;
        sum3 = sum3 + h;        
    end
end

% 求目标函数1
f1 = cos(0.5 * x(1) * pi) * cos(0.5 * x(2) * pi) + 2 / norm1 * sum1;

% 求目标函数2
f2 = cos(0.5 * x(1) * pi) * sin(0.5 * x(2) * pi) + 2 / norm2 * sum2;

% 求目标函数3
f3 = sin(0.5 * x(1) * pi) + 2 / norm3 * sum3;

% 合并
f = [f1,f2,f3];

end