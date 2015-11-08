function z = myConv(x,y)

    % 
    % x = ones(1,101)
    % y = 0:0.01:2

    h = []
    g = []

    minK = 1
    maxK = length(x) + length(y) -1

    for k = 1 : length(x)
        for t = 1 : length(y)
            h = [h x(k)*y(t)]
        end
        g = [g ; zeros(1,k-1) h zeros(1,length(x)-k)]
        h = []
    end

    z = sum(g)
end
