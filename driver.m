global L w d g n p;
L = 2;
w = 0.3;
d = 0.03;
g = -9.81;
n = 10;
p = 480;

sm = structuremat(n);
f = beamforces(@gravity,n, L/n);

disp(sm\f);


function out = gravity(x)
    global w d g p;
    out = p*w*d*g;
end

