function force = beamforces(func, count, step)
    force = zeros(1,count);
    position = 0;
    for i = 1:count
       force(1,i) = func(position); 
       position = position + step;
    end
end

