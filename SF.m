
clc;

exemplu = importdata('exemplu.txt');
% originalFile = fopen('exemplu.txt', 'r');
% exemplu = fscanf(originalFile, '%s');
%original = exemplu{1};

original = exemplu{1};
if (size(exemplu, 1) ~= 1)
    for i = 2 : size(exemplu, 1)
        original = [original char(10) exemplu{i}];
    end
end

N = length(original);

x = unique(original);
M = length(x);

y = zeros(1, M);

for i = 1 : M
   for j = 1 : N
       if (original(j) == x(i))
           y(i) = y(i) + 1;
       end
   end
end

[x, y] = quicksort(x, y);

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

vector = zeros(1, 2);
i = 1; k = 1; q = 1;
for i = 1 : N
    k = 1;
    j = find(x == original(i));
    while (A(k, j) ~= -1)
        vector(1, q) = A(k, j);
        k = k + 1;
        q = q + 1;
    end

end

save('result.mat', 'x', 'y', 'vector');
