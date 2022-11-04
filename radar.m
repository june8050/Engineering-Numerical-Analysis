function [X,Y,Z,I] = radar(x,y,z)
[~,I] = max(x,[],'all','linear');
x = x(1,1:I);y = y(1,1:I);z = z(1,1:I);
X = zeros(1,10000);Y = zeros(1,10000);Z = zeros(1,10000);
X(1,1:I)=x;Y(1,1:I)=y;Z(1,1:I)=z;
left = [...
sum(x.^4) sum(x.^3) sum(x.^2) sum(x) sum(y.^4) sum(y.^3) sum(y.^2) sum(y) I;...
sum(x.^5) sum(x.^4) sum(x.^3) sum(x.^2) sum((y.^4).*x) sum((y.^3).*x) sum((y.^2).*x) sum(y.*x) sum(x);...
sum((x.^4).*y) sum((x.^3).*y) sum((x.^2).*y) sum(x.*y) sum(y.^5) sum(y.^4) sum(y.^3) sum(y.^2) sum(y);...
sum(x.^6) sum(x.^5) sum(x.^4) sum(x.^3) sum((y.^4).*(x.^2)) sum((y.^3).*(x.^2)) sum((y.^2).*(x.^2)) sum(y.*(x.^2)) sum((x.^2));...
sum((x.^4).*(y.^2)) sum((x.^3).*(y.^2)) sum((x.^2).*(y.^2)) sum(x.*(y.^2)) sum(y.^6) sum(y.^5) sum(y.^4) sum(y.^3) sum((y.^2));...
sum(x.^7) sum(x.^6) sum(x.^5) sum(x.^4) sum((y.^4).*(x.^3)) sum((y.^3).*(x.^3)) sum((y.^2).*(x.^3)) sum(y.*(x.^3)) sum((x.^3));...
sum((x.^4).*(y.^3)) sum((x.^3).*(y.^3)) sum((x.^2).*(y.^3)) sum(x.*(y.^3)) sum(y.^7) sum(y.^6) sum(y.^5) sum(y.^4) sum((y.^3));...
sum(x.^8) sum(x.^7) sum(x.^6) sum(x.^5) sum((y.^4).*(x.^4)) sum((y.^3).*(x.^4)) sum((y.^2).*(x.^4)) sum(y.*(x.^4)) sum((x.^4));...
sum((x.^4).*(y.^4)) sum((x.^3).*(y.^4)) sum((x.^2).*(y.^4)) sum(x.*(y.^4)) sum(y.^8) sum(y.^7) sum(y.^6) sum(y.^5) sum((y.^4))...
];
right = [sum(z);sum(z.*x);sum(z.*y);sum(z.*(x.^2));sum(z.*(y.^2));sum(z.*(x.^3));sum(z.*(y.^3));sum(z.*(x.^4));sum(z.*(y.^4))];
coeff = left\right;

xinterval = mean(diff(x(1:end)),'all');yinterval = mean(diff(y(1:end)),'all');

while Z(I) > 0
    I = I + 1;
    X(I) = X(I-1) + xinterval;Y(I) = Y(I-1)+ yinterval;
    Z(I) = coeff(1,1)*(X(I)^4)+coeff(2,1)*(X(I)^3)+coeff(3,1)*(X(I)^2)+coeff(4,1)*X(I)+coeff(5,1)*(Y(I)^4)+coeff(6,1)*(Y(I)^3)+coeff(7,1)*(Y(I)^2)+coeff(8,1)*Y(I)+coeff(9,1);
end
end