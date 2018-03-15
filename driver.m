clear();
warning('off','all');

global L w d g n rho E I p;
L = 2;
w = 0.3;
d = 0.03;
g = -9.81;
n = 10;
rho = 480;
E = 1.3e+10;
p = 200;

I = w*d*d*d/12;
h = L/n;

%Problem 1
sm = structuremat(n);
f = beamforces(@gravity,n,L/n);
def = cat(1, [0], (sm\f));  %def = deflection at each grid point
def = def*h*h*h*h/E/I;
disp("Problem 1:");
disp(def);

%Problem 2
plot(0:h:L, def); hold on
disp("Problem 2:");
disp(def);
disp("Relative Error:");
rel = ((dis(L)-def(n+1))/dis(L));
disp(rel);
ezplot(@dis, [0 L]);


%Problem 3
disp("Problem 3:");
fprintf("\tn\t|\tRelative Error\n");
for i=0:11
    n = 10*(2^i);
    h = L/n;
    sm = structuremat(n);
    f = beamforces(@gravity,n,L/n);
    def = cat(1, [0], (sm\f));
    def = def*h*h*h*h/E/I;
    rel = (dis(L)-def(n+1))/dis(L);
    fprintf("\t%d\t|\t%d\n", n, rel);
end


%Problem 4
disp("Problem 4:");
sm = structuremat(n);
f = beamforces(@gravity,n,L/n);
def = cat(1, [0], (sm\f));  %def = deflection at each grid point
def = def*h*h*h*h/E/I;
for i=0:n
    err = zeros(n);
    err(i) = (def(i)-correctsin(i*h))/(def(i));
end
disp(err);
    



%Problem 5
disp("Problem 5:");
fprintf("\tn\t|\tRelative Error\n");
for i=0:11
    n = 10*(2^i);
    h = L/n;
    sm = structuremat(n);
    f = beamforces(@pile,n,L/n);
    def = cat(1, [0], (sm\f));
    def = def*h*h*h*h/E/I;
    rel = (correctsin(L)-def(n+1))/correctsin(L);
    fprintf("\t%d\t|\t%d\n", n, rel);
end

clf;
plot(0:h:L, def); hold on
ezplot(@correctsin, [0 L]);




%Helper Functions

%Forces for no constant load
function out = gravity(x)
    global w d g rho;
    out = rho*w*d*g;
end

%Forces for sinusoidal load
function out = pile(x)
    global p g L;
    out = p*g*sin(x*pi/L) + gravity(x);
end

%Known closed-form solution given constant load
function out = dis(x)
    global E I L;
    f = gravity(0);
    out = (f/(24*E*I))*(x*x)*((x*x)-(4*L*x)+(6*(L*L)));
end   