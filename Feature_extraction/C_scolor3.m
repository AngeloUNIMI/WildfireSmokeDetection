%SMOKE COLORED REGION DETECTION
%As described
%Toreyin PhD Thesis "Fire detection algorithms using multimodal signal and image analysis"
%Section 6.2.2





y_old = y;


I1 = frameElab(:,:,:,1);



[y,u,v] = rgb2yuv(I1);

[h,s,i] = rgb2hsi(I1);




formula1 = y - u;
formula2 = y - v;
%troppa luminance non va bene (bianco)
formula3 = y;
%troppa poca luminance neanche (nero)
formula4 = y;

%decision level
res = 1 - ((abs(double(u(:,:)) - 128) + abs(double(v(:,:)) - 128)) / 128);
d_1 = double((formula1 > T_I) .* (formula2 > T_I) .* (formula3 < T_y) .* (formula4 > T_y2) ) .* double(res);
d_2 = double((logical((formula1 <= T_I) + (formula2 <= T_I) + (formula3 >= T_y) + (formula4 <= T_y2))) .* -1);

D2 = d_1 + d_2;









%mettiamo da 0 a 1
if (scale01),
Id2 = find(D2 < 0);
D2(Id2) = 0;
end,


%espandiamo la regione
%D2 = morf(D2,'dilate','diamond',3);





%spostiamo quelli vecchi
for koldcol=nOldCol:-1:2,
D2_old(:,:,koldcol) = D2_old(:,:,koldcol-1);
end,
D2_old(:,:,1) = D2;


