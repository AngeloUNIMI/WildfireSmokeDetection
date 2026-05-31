%rising region analysis

%usa un vettore globale
%appena raggiunge tot frame (es 100)
% confronta con il pixel 100 frame prima





%mettiamo insieme D2 e D3
%Dr = D2 .* D3;
%Dr = logical(D1+1).*logical(D2+1);
%Dr = logical(D1+1).*logical(D2+1).*logical(Dy+1);
%Dr = t;
Dr = par1l;

%t = morf(Dr,'dilate','diamond',2);
%t2 = connComp2(t,1,0);
%t3 = morf(t2,'erode','diamond',2);

%Dr = t3;



if (ml <= startF+dimRis-1),

[h d] = find(Dr > 0);
minH = min(h);
if (numel(minH) > 0),
I_xnt = [I_xnt minH];
else, 
I_xnt = [I_xnt 0];
end,  %end if numel

diffRis = 0;
diffRis2 = 0;
ris = zeros(size(Ct,1),size(Ct,2));
ris_3 = zeros(size(Ct,1),size(Ct,2));


end, %end if ml <= 100


if (ml > startF+dimRis-1),


for koldRis=dimRis2:-1:2,
D4t(koldRis) = D4t(koldRis-1);
end,



diffRis = I_xnt(1) - I_xnt(3); %1 = valore vecchio; end = valore nuovo corrente
                                 %si vorrebbe che il valore vecchio sia maggiore (pixel più in basso)

diffRis2 = I_xnt(3) - I_xnt(5); %1 = valore vecchio; end = valore nuovo corrente
                                 %si vorrebbe che il valore vecchio sia maggiore (pixel più in basso)
								 
if ((diffRis > thRis) && (diffRis < thRis2) && (I_xnt(1) ~= 0) ),
D4t(1) = 1;
end,

if ((diffRis == 0) && (I_xnt(1) ~= 0) ),
D4t(1) = 0;
end,


if ((diffRis < 0 || diffRis >= thRis2) && I_xnt(1) ~= 0 ),
%D4t(1) = -1;
D4t(1) = 0;
end,

if (I_xnt(1) == 0),
D4t(1) = 0;
end,


I_xnt = circshift(I_xnt,[0 -1]);
[h d] = find(Dr > 0);
minH = min(h);
if (numel(minH) > 0),
I_xnt(end) = minH;
else, 
I_xnt(end) = 0;
end, %end if numel




%trasformiamo in feature locale
t = zeros(size(Ct));
I = find(t == 1);
t(I) = diffRis;
ris = t;

t = zeros(size(Ct_3));
I = find(t == 1);
t(I) = diffRis2;
ris_3 = t;





end, %end if ml > 100















