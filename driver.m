 clear();
warning('off','all');
format long;

global L w d g n rho E I p mDiver;
L = 2;
w = 0.3;
d = 0.03;
g = -9.81;
n = 10;
rho = 480;
E = 1.3e+10;
p = 100;
mDiver = 70;

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
rel = ((dis(L)-def(n+1))/dis(L));
fprintf("\tRelative Error: %d\n", rel);
%clf;
ezplot(@dis, [0 L]);
title("Problem 2: Deflection of Board");


pause;
%Problem 3
disp("Problem 3:");
fprintf("\tn\t|\tRelative Error\t|\tCondition Number\ n");
err = zeros(12,1);
for i=0:11
    n = 10*(2^i);
    h = L/n;
    sm = structuremat(n);
    f = beamforces(@gravity,n,L/n);
    def = cat(1, [0], (sm\f));
    def = def*h*h*h*h/E/I;
    err(i+1) = abs((dis(L)-def(n+1))/dis(L));
    fprintf("\t%d\t|\t%d\t|\t%d\n", n, err(i+1), cond(sm));
end
clf;
semilogy(0:11, err);
title("Problem 3: R.E. of Unloaded Board with 10*2^x Samples");


pause;
%Problem 4
disp("Problem 4:");
n = 5120;
h = L/n;
sm = structuremat(n);
f = beamforces(@pile,n,L/n);
def = cat(1, [0], (sm\f));  %def = deflection at each grid point
def = def*h*h*h*h/E/I;
err = zeros(n+1,1);
for i=1:n+1
    err(i) = abs((correctsin((i-1)*h)-def(i))/correctsin((i-1)*h));
end
clf;
plot(0:h:L, err);
title("Problem 4: R.E. of Sinusoidal Pile at each x");

pause;
%Problem 5
disp("Problem 5:");
fprintf("\tn\t|\tRelative Error\t|\tCondition Number\n");
err = zeros(12,1);
hm = zeros(12,1);
for i=0:11
    n = 10*(2^i);
    h = L/n;
    sm = structuremat(n);
    f = beamforces(@pile,n,L/n);
    def = cat(1, [0], (sm\f));
    def = def*h*h*h*h/E/I;
    err(i+1) = abs((correctsin(L)-def(n+1))/correctsin(L));
    hm(i+1) = h^2;
    fprintf("\t%d\t|\t%d\t|\t%d\n", n, err(i+1), cond(sm));
end

clf;
semilogy(0:11, err); hold on
title("Problem 5: R.E. of Sinusoidal Pile with 10*2^x Samples");
pause;
clf;
loglog(hm, err);
title("Problem 5: Comparing the log(error) vs log(h^2) ");


pause;
%problem 6
disp("Problem 6:");
n = 5120;
h = L/n;
sm = structuremat(n);
f = beamforces(@diver,n,L/n);
divDef = cat(1, [0], (sm\f));
divDef = divDef*h*h*h*h/E/I;
f = beamforces(@gravity,n,L/n);
def = cat(1, [0], (sm\f));
def = def*h*h*h*h/E/I;
clf;
plot(0:h:L, def); hold on
plot(0:h:L, divDef); hold on
title("Problem 6: Deflection of Board with and without Diver");
fprintf("\tDeflection of end is: %d\n", divDef(n+1));


return;

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

function out = diver(x)
    global g mDiver;
    out = gravity(x);
    if x < 1.8
        return;
    end
    out = out + g * (mDiver/.2);
end

%Known closed-form solution given constant load
function out = dis(x)
    global E I L;
    f = gravity(0);
    out = (f/(24*E*I))*(x*x)*((x*x)-(4*L*x)+(6*(L*L)));
end   