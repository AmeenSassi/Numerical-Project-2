function out = correctsin(x)
    global L w d g p E I;
    grav = p*w*d*g;
    %TODO: divide grav by 24EI
    out = grav/24/E/I;
    out = out * x*x;
    out = out * (x*x - 4*L*x + 6*L*L);
    
    t2 = p*g*L/E/I/pi;
    t2 = t2 * (L*L*L/pi/pi/pi*sin(pi*x/L) - x*x*x/6 + L*x*x/2 - L*L/pi/pi*x);
    
    out = out-t2;
end

