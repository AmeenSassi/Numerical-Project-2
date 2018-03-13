function force = beamforces(func, count, step)
    force = zeros(count,1);
    position = 0;
    for i = 1:count
       force(i,1) = func(position); 
       position = position + step;
    end
end

