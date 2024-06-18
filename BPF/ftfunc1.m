function f = ftfunc1(t)
%     if (t>-2) && (t<=-1)
%         f = pi./4 .* (exp(-1+t) + exp(1+t) - exp(-2+t) - exp(-2-t));
%     elseif abs(t)<1
%         f = pi./4 .* (exp(-1+t) + exp(-1-t) - exp(-2+t) - exp(-2-t));
%     elseif (t>=1) && (t<=2)
%         f = pi./4 .* (exp(1-t) + exp(-1-t) - exp(-2+t) - exp(-2-t));
%     elseif (t>2)
%         f = pi./4 .* (exp(1-t) + exp(-1-t) - exp(2-t) - exp(-2-t));
%     else 
%         f = pi ./ 4 .* (exp(1+t) + exp(-1+t) - exp(2+t) - exp(-2+t));
%     end
%     f = (pi./4 .* (exp(-1+t) + exp(1+t) - exp(-2+t) - exp(-2-t))) .* (t(:)>-2*ones(1, length(t)) && t(:)<=-1*ones(1, length(t))) + ...
%         (pi./4 .* (exp(-1+t) + exp(-1-t) - exp(-2+t) - exp(-2-t))) .* (abs(t(:))<1*ones(1, length(t))) + ...
%         (pi./4 .* (exp(1-t) + exp(-1-t) - exp(-2+t) - exp(-2-t))) .* (t(:)>=1*ones(1, length(t)) && t(:)<=2*ones(1, length(t))) + ...
%         (pi./4 .* (exp(1-t) + exp(-1-t) - exp(2-t) - exp(-2-t))) .* (t(:)>2*ones(1, length(t))) + ...
%         (pi ./ 4 .* (exp(1+t) + exp(-1+t) - exp(2+t) - exp(-2+t))) .* (t(:) <= -2*ones(1, length(t)));
    f = pi./4 .*(exp(sign(t).*(1-t)) + exp(sign(t).*(-1-t))- exp(-2+t) - exp(-2-t));
    f(t<=-2) = pi ./ 4 .* (exp(1+t) + exp(-1+t) - exp(2+t) - exp(-2+t));
    %f(t>-2 & t<=-1) = pi./4 .* (exp(-1+t) + exp(1+t) - exp(-2+t) - exp(-2-t));
    f(abs(t)<1) = pi./4 .* (exp(-1+t) + exp(-1-t) - exp(-2+t) - exp(-2-t));
    %f(t>=1 & t<=2) = pi./4 .* (exp(1-t) + exp(-1-t) - exp(-2+t) - exp(-2-t));
    f(t>2) = pi./4 .* (exp(1-t) + exp(-1-t) - exp(2-t) - exp(-2-t));
    
end