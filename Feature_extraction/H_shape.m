%script per il calcolo del rapporto perimetro / area (disordine della forma)

%im = logical(D1+1);
%im = par1l;
im = D1;

[l,num] = bwlabel(im);
s = regionprops(im,'Area','Perimeter','Centroid');
t = [];
for i=1:numel(s),
t(i) = s(i).Perimeter / s(i).Area;
I = find(l == i);
	%if (s(i).Area < 10),
	%l(I) = 0;
	%else
	l(I) = t(i);
end,


Ds = l;




%spostiamo quelli vecchi
for koldshape=nOldshape:-1:2,
Ds_old(:,:,koldshape) = Ds_old(:,:,koldshape-1);
end,
Ds_old(:,:,1) = Ds;



Ds_3 = Ds_old(:,:,3);