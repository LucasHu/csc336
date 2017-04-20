a = -1; b = 1;
xe = linspace(a, b, 1000);
ye = sin(pi*xe);
yda = pi*cos(pi*a); ydb = pi*cos(pi*b);

disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('   n    err poly   err lin_spl')
for nn = 1:6
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = sin(pi*xi);
    yp = polyval(polyfit(xi, yi, n), xe);
    yl = interp1(xi, yi, xe, 'linear');
    ep = max(abs(ye-yp));
    el = max(abs(ye-yl));
    fprintf('%4d %12.3e %12.3e\n', n, ep, el);
end

fprintf('\n')
disp(['interval (' num2str(a) ',' num2str(b), ')'])
disp('   n   err lin_spl err cub_spl')

for nn = 4:10
    n = 2^nn;
    xi = linspace(a, b, n+1);
    yi = sin(pi*xi);
    yl = interp1(xi, yi, xe, 'linear');
    
    % here fill in the clamped cubic spline interpolant computation
    % add endpoints slope into yi, then yi2 has extra two values
    yi2 = [yda yi ydb];
    yc = spline(xi, yi2, xe);
    
    el = max(abs(ye-yl));
    ec = max(abs(ye-yc));
    fprintf('%4d %12.3e %12.3e ', n, el, ec);
    elv(nn) = el; ecv(nn) = ec;
    if (nn > 4) fprintf('%6.1f %6.1f\n', log(elv(nn-1)/el)/log(2), ...
                                         log(ecv(nn-1)/ec)/log(2));
    else fprintf('\n'); end
end
