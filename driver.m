global L w d g n p E;
L = 2;
w = 0.3;
d = 0.03;
g = -9.81;
n = 10;
p = 480;
E = 1.3e+10;

I = w*d*d*d/12;
h = L/n;


%Problem 1
sm = structuremat(n);
f = beamforces(@gravity,n,L/n);
def = cat(1, [0], (sm\f));
def = def*h*h*h*h/E/I;
disp("Problem 1:");
disp(def);

%Problem 2
plot(0:h:L, def); hold on


function out = gravity(x)
    global w d g p;
    out = p*w*d*g;
end