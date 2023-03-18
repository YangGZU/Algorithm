%% 测试函数的定义
function [ObjFunc,dim,lb,ub] = TestingFunc(FuncX)

switch FuncX
    case 'F1'
        ObjFunc = @F1;
        dim = 30;
        lb = -100 * ones(1,dim);
        ub = 100 * ones(1,dim);
        
    case 'F2'
        ObjFunc = @F2;
        dim = 30;
        lb = -10 * ones(1,dim);
        ub = 10 * ones(1,dim);
        
    case 'F3'
        ObjFunc = @F3;
        dim = 30;
        lb = -100 * ones(1,dim);
        ub = 100 * ones(1,dim);
        
    case 'F4'
        ObjFunc = @F4;
        dim = 30;
        lb = -100 * ones(1,dim);
        ub = 100 * ones(1,dim);
        
    case 'F5'
        ObjFunc = @F5;
        dim = 30;
        lb = -30 * ones(1,dim);
        ub = 30 * ones(1,dim);
        
    case 'F6'
        ObjFunc = @F6;
        dim = 30;
        lb = -100 * ones(1,dim);
        ub = 100 * ones(1,dim);
        
    case 'F7'
        ObjFunc = @F7;
        dim = 30;
        lb = -1.28 * ones(1,dim);
        ub = 1.28 * ones(1,dim);
        
    case 'F8'
        ObjFunc = @F8;
        dim = 30;
        lb = -500 * ones(1,dim);
        ub = 500 * ones(1,dim);
        
    case 'F9'
        ObjFunc = @F9;
        dim = 30;
        lb = -5.12 * ones(1,dim);
        ub = 5.12 * ones(1,dim);
        
    case 'F10'
        ObjFunc = @F10;
        dim = 30;
        lb = -32 * ones(1,dim);
        ub = 32 * ones(1,dim);
        
    case 'F11'
        ObjFunc = @F11;
        dim = 30;
        lb = -600 * ones(1,dim);
        ub = 600 * ones(1,dim);
        
    case 'F12'
        ObjFunc = @F12;
        dim = 30;
        lb = -50 * ones(1,dim);
        ub = 50 * ones(1,dim);
        
    case 'F13'
        ObjFunc = @F13;
        dim = 30;
        lb = -50 * ones(1,dim);
        ub = 50 * ones(1,dim);
        
    case 'F14'
        ObjFunc = @F14;
        dim = 2;
        lb = -65 * ones(1,dim);
        ub = 65 * ones(1,dim);
        
    case 'F15'
        ObjFunc = @F15;
        dim = 4;
        lb = -5 * ones(1,dim);
        ub = 5 * ones(1,dim);
        
    case 'F16'
        ObjFunc = @F16;
        dim = 2;
        lb = -5 * ones(1,dim);
        ub = 5 * ones(1,dim);
        
    case 'F17'
        ObjFunc = @F17;
        dim = 2;
        lb = -5 * ones(1,dim);
        ub = 5 * ones(1,dim);
        
    case 'F18'
        ObjFunc = @F18;
        dim = 2;        
        lb = -2 * ones(1,dim);
        ub = 2 * ones(1,dim);
        
    case 'F19'
        ObjFunc = @F19;
        dim = 3;
        lb = 1 * ones(1,dim);
        ub = 3 * ones(1,dim);

        
    case 'F20'
        ObjFunc = @F20;
        dim = 6;
        lb = 0 * ones(1,dim);
        ub = 1 * ones(1,dim);
        
    case 'F21'
        ObjFunc = @F21;
        dim = 4;
        lb = 0 * ones(1,dim);
        ub = 10 * ones(1,dim);
        
    case 'F22'
        ObjFunc = @F22;
        dim = 4;
        lb = 0 * ones(1,dim);
        ub = 10 * ones(1,dim);
        
    case 'F23'
        ObjFunc = @F23;
        dim = 4;
        lb = 0 * ones(1,dim);
        ub = 10 * ones(1,dim);
end

end

% F1
function obj = F1(x)

obj = sum(x.^2);

end

% F2
function obj = F2(x)

obj = sum(abs(x)) + prod(abs(x));

end

% F3
function obj = F3(x)

dim = size(x,2);
obj = 0;
for i = 1 : dim
    obj = obj + sum(x(1:i))^2;
end

end

% F4
function obj = F4(x)

obj = max(abs(x));

end

% F5
function obj = F5(x)

dim = size(x,2);
obj = sum(100 * (x(2:dim) - x(1:dim-1).^2).^2 + (x(1:dim-1) - 1).^2);

end

% F6
function obj = F6(x)

obj = sum(floor(x + 0.5).^2);

end

% F7
function obj = F7(x)

dim = size(x,2);
y = 1 : dim;
obj = sum(y .* (x.^4)) + rand();

end

% F8
function obj = F8(x)

obj = sum(-x .* sin(abs(x).^0.5));

end

% F9
function obj = F9(x)

obj = sum(x.^2 - 10 * cos(2 * pi .* x) + 10);

end

% F10
function obj = F10(x)

dim = size(x,2);
obj = -20 * exp(-0.2 * (sum(x.^2) / dim).^0.5) - exp(sum(cos(2 * pi .* x))/dim) + 20 + exp(1);

end

% F11
function obj = F11(x)

dim = size(x,2);
y = 1 : dim;
obj = sum(x.^2) / 4000 - prod(cos(x ./ y.^0.5)) + 1;

end

% F12
function obj = F12(x)

dim = size(x,2);
y = 1 + (x + 1) / 4;
obj = pi/dim * (10 * sin(pi * y(1)) + sum((y(1:dim-1) - 1).^2 .* (1 + 10 * sin(pi * y(2:dim)).^2)) + (y(dim) - 1)^2) + sum(uFun(x,10,100,4));

end

% uFun
function obj = uFun(x,a,k,m)

obj = zeros(size(x));
dim = size(x,2);
for i = 1 : dim
    if x(i) < -a
        obj(i) = k * (-x(i) - a)^m;
    elseif x(i) <= a
        obj(i) = 0;
    else
        obj(i) = k * (x(i) - a)^m;
    end
end

end

% F13
function obj = F13(x)

dim = size(x,2);
obj = 0.1 * (sin(3 * pi * x(1))^2 + sum((x(1:dim-1)-1).^2 .* (1 + sin(3 .* pi .* x(2:dim) + 1).^2)) + ((x(dim)-1)^2) * (1 + sin(2 * pi * x(dim))^2)) + sum(uFun(x,5,100,4));

end

% F14
function obj = F14(x)

aS = [-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;-32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];
bS = zeros(1,25);
for j = 1:25
    bS(j) = sum((x' - aS(:,j)).^6);
end
y = 1 : 25;
obj = (1/500 + sum(1 ./ (y + bS))).^(-1);

end

% F15
function obj = F15(x)

aK = [0.1957 0.1947 0.1735 0.16 0.0844 0.0627 0.0456 0.0342 0.0323 0.0235 0.0246];
bK = [0.25 0.5 1 2 4 6 8 10 12 14 16];
bK = 1 ./ bK;
obj = sum((aK - ((x(1) .* (bK .^ 2 + x(2) .* bK)) ./ (bK .^2 + x(3) .* bK + x(4)))) .^2);

end

% F16
function obj = F16(x)

obj = 4 * (x(1)^2) - 2.1*(x(1)^4) + (x(1)^6) / 3 + x(1) * x(2) - 4 * (x(2)^2) + 4 * (x(2)^4);

end

% F17
function obj = F17(x)

obj = (x(2) - 5.1 / (4 * (pi^2)) * (x(1)^2) + 5 / pi * x(1) - 6)^2 + 10 * (1 - 1 / (8 * pi)) * cos(x(1)) + 10;

end

% F18
function obj = F18(x)

obj = (1 + (x(1) + x(2) + 1)^2 * (19 - 14 * x(1) + 3 * x(1)^2 - 14 * x(2) + 6 * x(1) * x(2) + 3 * x(2)^2)) * (30 + (2 * x(1) - 3 * x(2))^2 * (18 - 32 * x(1) + 12 * x(1)^2 + 48 * x(2) - 36 * x(1) * x(2) + 27 * x(2)^2));

end

% F19
function obj = F19(x)

aH = [3 10 30;0.1 10 35;3 10 30;0.1 10 35];
cH = [1 1.2 3 3.2];
pH = [0.3689 0.117 0.2673;0.4699 0.4387 0.747;0.1091 0.8732 0.5547;0.03815 0.5743 0.8828];
obj = 0;
for i = 1 : 4
    obj = obj - cH(i) * exp(-(sum(aH(i,:) .* (x - pH(i,:)).^2)));
end

end

% F20
function obj = F20(x)

aH = [10 3 17 3.5 1.7 8;0.05 10 17 0.1 8 14;3 3.5 1.7 10 17 8;17 8 0.05 10 0.1 14];
cH = [1 1.2 3 3.2];
pH = [0.1312 0.1696 0.5569 0.0124 0.8283 0.5886;0.2329 0.4135 0.8307 0.3736 0.1004 0.9991;0.2348 0.1415 0.3522 0.2883 0.3047 0.6650;0.4047 0.8828 0.8732 0.5743 0.1091 0.0381];
obj = 0;
for i = 1 : 4
    obj = obj - cH(i) * exp(-(sum(aH(i,:) .* (x-pH(i,:)).^2)));
end

end

% F21
function obj = F21(x)

aSH = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH = [.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];
obj=0;
for i = 1 : 5
    obj = obj - ((x - aSH(i,:)) * (x - aSH(i,:))' + cSH(i))^(-1);
end

end

% F22
function obj = F22(x)

aSH = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH = [0.1 0.2 0.2 0.4 0.4 0.6 0.3 0.7 0.5 0.5];
obj = 0;
for i = 1 : 7
    obj = obj - ((x - aSH(i,:)) * (x - aSH(i,:))' + cSH(i))^(-1);
end

end

% F23
function obj = F23(x)

aSH = [4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH = [0.1 0.2 0.2 0.4 0.4 0.6 0.3 0.7 0.5 0.5];
obj = 0;
for i = 1 : 10
    obj = obj - ((x - aSH(i,:)) * (x - aSH(i,:))' + cSH(i))^(-1);
end

end