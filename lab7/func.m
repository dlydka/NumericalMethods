function [ f ] = func(t)
    sigma = 3;
    mi = 10;
    
    f = (1 / (sigma * sqrt(2 * pi))) * exp((-(t - mi).^2) / (2 * sigma.^2));
end