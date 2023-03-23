function [xvect, xdif, fx, it_cnt] = bisect(a, b, eps, fun)
    xvect = [];
    xdif = [];
    fx = [];
    counter = 0;
    c = (a + b)/2;
    
    for i = 1:1000
        c1 = c;
        c = (a + b)/2;
        xvect(i) = c;
        xdif(i) = abs(c1 - c);
        fx(i) = feval(fun, c);
        counter = counter + 1;
        if abs(feval(fun, c)) < eps || abs(b - a) < eps
            it_cnt = counter;
            return;
        elseif feval(fun, a) * feval(fun, c) < 0
            b = c;
        else
            a = c;
        end
    end
end