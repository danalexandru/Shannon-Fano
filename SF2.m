clc;

load('result.mat');

N = length(vector);
M = length(x);

A(1, :) = -ones(1, M);
A(2, :) = -ones(1, M);

A = divide_et_impera(y, A, 1, M, 1);

finish = 2; start = 1; i = 2;
numberOfLeafs = 0;

while (numberOfLeafs ~= M)
    
    while (A(i-1, start) == -1)
        start = start + 1;
    end
    
    currentDirection = A(i-1, start);
    finish = start + 1;
    
    if (finish < M + 1)
        while (A(i - 1, finish) == currentDirection && finish <= M)
            finish = finish + 1;
            if (finish == M + 1)
                break;
            end
        end
    end
    
    if (finish - start ~= 1)
        A = divide_et_impera(y(start:finish-1), A, start, finish-1, i);
    else
        numberOfLeafs = numberOfLeafs + 1;
    end
    
    if (finish == M + 1 && start ~= M)
        i = i + 1;
        start = 1;
        A(i, :) = -ones(1, M);
    else
        start = finish;
    end
    
end

original = char(32);    % space
j = 1; k = 1;
start = 1; finish = M;

for i = 1 : N
    
    while (A(j, start) ~= vector(1, i) || A(j, finish) ~= vector(1, i))
        
        if (A(j, start) ~= vector(1, i))
            start = start + 1;
        end
        
        if (A(j, finish) ~= vector(1, i))
            finish = finish - 1;
        end
    end
    
    if (start == finish && A(j + 1, start) == -1)
        original(k) = x(start);
        start = 1;
        finish = M;
        j = 1;
        k = k + 1;
    else
        j = j  + 1;
    end
    
end

originalFile = fopen('exemplu2.txt', 'wt');
fprintf(originalFile, '%s', original);
fclose('all');
