%% 23个无约束测试函数
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

    case 'F7'
        ObjFunc = @F7;
        dim = 30;
        lb = -1.28 * ones(1,dim);
        ub = 1.28 * ones(1,dim);

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

    case 'F21'
        ObjFunc = @F21;
        dim = 4;
        lb = 0 * ones(1,dim);
        ub = 10 * ones(1,dim);

end

end

% F1
function f = F1(x)

f = sum(x.^2);

end

% F2
function f = F2(x)

f = sum(abs(x)) + prod(abs(x));

end

% F7
function f = F7(x)

f = sum((1 : length(x)) .* x.^4) + rand();

end

% F12
function f = F12(x)

f = pi/length(x) * (10 * sin(pi * (1 + (x(1) + 1) / 4))^2 + ...
    sum(((x(1:end-1) + 1) / 4).^2 .* (1 + 10 * sin(pi * (1 + (x(2:end) + 1) / 4)).^2)) + ...
    ((x(end) + 1) / 4)^2) + sum(uFun(x,10,100,4));

end

% F13
function f = F13(x)

f = 0.1 * (sin(3 * pi * x(1))^2 + sum((x(1:end-1) - 1).^2 .* (1 + sin(3 * pi * x(2:end)).^2)) + ...
    (x(end) - 1)^2 * (1 + sin(2 * pi * x(end))^2)) + sum(uFun(x,5,100,4));

end

% uFun
function o = uFun(x,a,k,m)

o = k * ((x - a) .^ m) .* (x>a) + k * ((-x - a) .^ m) .* (x<(-a));

end

% F21
function f = F21(x)

a = [4 4 4 4;
    1 1 1 1;
    8 8 8 8;
    6 6 6 6;
    3 7 3 7;
    2 9 2 9;
    5 5 3 3;
    8 1 8 1;
    6 2 6 2;
    7 3.6 7 3.6];
c = [0.1 0.2 0.2 0.4 0.4 0.6 0.3 0.7 0.5 0.5];
f=0;
for i = 1 : 5
    f = f - ((x - a(i,:)) * (x - a(i,:))' + c(i))^(-1);
end

end
