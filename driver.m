global L w d g n p E I;
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
disp("Problem 2:");
disp(def);
disp("Relative Error:");
rel = ((def(n+1)-dis(L))/def(n+1));
disp(rel);
ezplot(@dis, [0 L]);


%Problem 3
for i=1:11
    n = 10*(2^i);
    sm = structuremat(n);
    f = beamforces(@gravity,n,L/n);
    def = cat(1, [0], (sm\f));
    def = def*h*h*h*h/E/I;
end
disp("Problem 3:");
disp(def);


function out = gravity(x)
    global w d g p;
    out = p*w*d*g;
end

function out = dis(x)
    global E I L;
    f = gravity(0);
    out = (f/(24*E*I))*(x*x)*((x*x)-(4*L*x)+(6*(L*L)));
end   