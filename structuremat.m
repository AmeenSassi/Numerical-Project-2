function mat = structuremat(n)
    mat = zeros(n,n);
    mat(1,1) = 16;
    mat(2,1) = -9;
    mat(3,1) = 8/3;
    mat(4,1) = -1/4;
    mat(1,2) = -4;
    mat(2,2) = 6;
    mat(3,2) = -4;
    mat(4,2) = 1;
    for y = 3:n-2
        mat(y-2, y) = 1;
        mat(y-1, y) = -4;
        mat(y, y) = 6;
        mat(y+1, y) = -4;
        mat(y+2, y) = 1;
    end
    mat(n-3,n-1) = 16/17;
    mat(n-2,n-1) = -60/17;
    mat(n-1,n-1) = 72/17;
    mat(n,n-1) = -28/17;
    mat(n-3,n) = -12/17;
    mat(n-2,n) = 96/17;
    mat(n-1,n) = -156/17;
    mat(n,n) = 72/17;
end

