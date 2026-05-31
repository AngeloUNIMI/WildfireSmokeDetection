%SCRIPT PER LA FUSIONE DELLE MASCHERE






%differenza di area
comp1 = D1 + 1;
comp2 = D1_old(:,:,3) + 1;
comp3 = D1_old(:,:,5) + 1;
comp4 = D2 + 1;
comp5 = D2_old(:,:,3) + 1;
comp6 = D1_old(:,:,5) + 1;
comp7 = Dy + 1;
comp8 = Dy_old(:,:,3) + 1;
comp9 = D1_old(:,:,5) + 1;

par1 = comp1 .* comp4 .* comp7; %ct
par2 = comp2 .* comp5 .* comp6; %ct-3
par3 = comp3 .* comp6 .* comp9; %ct-5

%diffArea = sum(par1(:)) - sum(par2(:));


par1l = logical(par1);
par2l = logical(par2);
par3l = logical(par3);
%par1l = morf(par1l,'open','square',2);
%par2l = morf(par2l,'open','square',2);

Ct = par1l;
Ct_3 = par2l;
Ct_5 = par3l;
