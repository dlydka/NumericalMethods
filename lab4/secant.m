function [xvect, xdif, fx, it_cnt] = secant(a, b, eps, fun)
    xvect = [];
    xdif = [];
    fx = [];
    x0 = a;
    x1 = b;
    counter = 0;
    
    for i = 1:1000
        tmpx = x1;
        x = x1 - (feval(fun, x1) * (x1 - x0))/(feval(fun, x1) - feval(fun, x0));
        counter = counter + 1; 
        xvect(i) = x;
        xdif(i) = abs(tmpx - x);
        fx(i) = feval(fun, x);
        if abs(feval(fun, x)) < eps
            it_cnt = counter;
            return;
        end
        x0 = x1;
        x1 = x;
    end
end