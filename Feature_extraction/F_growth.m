%growing region analysis




t = par1l-par2l;

t2 = par2l-par3l;

diffArea = sum(t(:));

diffArea2 = sum(t2(:));



grw = diffArea;
grw_3 = diffArea2;



%trasformiamo in feature locale
t = zeros(size(Ct));
I = find(Ct == 1);
t(I) = grw;
grw = t;

t = zeros(size(Ct_3));
I = find(Ct_3 == 1);
t(I) = grw_3;
grw_3 = t;















