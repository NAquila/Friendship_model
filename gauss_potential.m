function [ Z ] = gauss_potential( latt_size, x0, y0, sigma )
%Creates a gaussian source at x0, y0
%x, y in "matrix counting"
y0 = latt_size - y0;

x=1:latt_size;
y=1:latt_size;
x_shift = x - x0;
y_shift = y - y0;

[X_shift, Y_shift] = meshgrid(x_shift, y_shift);
Z = -exp(-((X_shift).^2+(Y_shift).^2)/(sigma^2));

end

