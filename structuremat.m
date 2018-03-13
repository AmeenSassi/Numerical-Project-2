function mat = structuremat(n)
    mat = zeros(n,n);
    mat(1,1) = 16;
    mat(1,2) = -9;
    mat(1,3) = 8/3;
    mat(1,4) = -1/4;
    mat(2,1) = -4;
    mat(2,2) = 6;
    mat(2,3) = -4;
    mat(2,4) = 1;
    for y = 3:n-2
        mat(y, y-2) = 1;
        mat(y, y-1) = -4;
        mat(y, y) = 6;
        mat(y, y+1) = -4;
        mat(y, y+2) = 1;
    end
    mat(n-1,n-3) = 16/17;
    mat(n-1,n-2) = -60/17;
    mat(n-1,n-1) = 72/17;
    mat(n-1,n) = -28/17;
    mat(n,n-3) = -12/17;
    mat(n,n-2) = 96/17;
    mat(n,n-1) = -156/17;
    mat(n,n) = 72/17;
end

