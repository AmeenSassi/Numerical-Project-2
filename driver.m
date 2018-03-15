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


waitforbuttonpress();
%Problem 2
plot(0:h:L, def); hold on
disp("Problem 2:");
disp(def);
disp("Relative Error:");
rel = ((dis(L)-def(n+1))/dis(L));
disp(rel);
ezplot(@dis, [0 L]);


waitforbuttonpress();
%Problem 3
disp("Problem 3:");
fprintf("\tn\t|\tRelative Error\n");
rel = zeros([12]);
for i=0:11
    n = 10*(2^i);
    h = L/n;
    sm = structuremat(n);
    f = beamforces(@gravity,n,L/n);
    def = cat(1, [0], (sm\f));
    def = def*h*h*h*h/E/I;
    rel(i+1) = (dis(L)-def(n+1))/dis(L);
    fprintf("\t%d\t|\t%d\n", n, rel(i+1));
end
clf;
plot(0:11, rel);


waitforbuttonpress();
%Problem 4
disp("Problem 4:");
n = 5120;
h = L/n;
sm = structuremat(n);
f = beamforces(@correctsin,n,L/n);
def = cat(1, [0], (sm\f));  %def = deflection at each grid point
def = def*h*h*h*h/E/I;
err = zeros([n+1]);
for i=1:n+1
    err(i) = (correctsin((i-1)*h)-def(i))/correctsin((i-1)*h);
end
clf;
plot(0:h:L, err); hold on
    

waitforbuttonpress();
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