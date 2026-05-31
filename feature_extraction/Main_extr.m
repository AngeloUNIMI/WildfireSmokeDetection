%APPROCCIO I
%MAIN LOOP FILE




startF = round(startFt / floor(frameRate / 7));
if (startF == 0),
startF = 1;
end,



%il ciclo è su tutti i frame del video
%for ml=frameLoad:nFrames,
for ml=startF:1:nFrames,

if (ml*floor(frameRate/7) > nFrames),
break;
end,

%carichiamo i frame che ci interessano
A_load3

%slow moving region
B_slow_3


%smoke colour
C_scolor3




%luminance control
D_lumY



%mask fusion
E_mask_fusion


%growing region
F_growth



%rising region
G_rising



%shape
H_shape





%costruzione input matrix

%manteniamo solo le regioni in movimento
if (onlyMov),

Ct_n = Ct;
Ct_3_n = Ct_3;
grw_n = grw;
grw_3_n = grw_3;
ris_n = ris;
ris_3_n = ris_3;
Ds_n = Ds;
Ds_3_n = Ds_3;
imov = [];
jmov = [];
Imov = [];

else, %oppure manteniamo tutto
Ct_n = Ct;
Ct_3_n = Ct_3;
grw_n = grw;
grw_3_n = grw_3;
ris_n = ris;
ris_3_n = ris_3;
Ds_n = Ds;
Ds_3_n = Ds_3;
imov = [];
jmov = [];
Imov = [];
end,



%organizziamo i dati concatenando i pixel
%frameLoad X nPixelTotali

Ctr = reshape(Ct_n,[1 size(Ct_n,1) * size(Ct_n,2)]);
Ct_3r = reshape(Ct_3_n,[1 size(Ct_3_n,1) * size(Ct_3_n,2)]);
grwr = reshape(grw_n,[1 size(grw_n,1) * size(grw_n,2)]);
grw_3r = reshape(grw_3_n,[1 size(grw_3_n,1) * size(grw_3_n,2)]);
risr = reshape(ris_n,[1 size(ris_n,1) * size(ris_n,2)]);
ris_3r = reshape(ris_3_n,[1 size(ris_3_n,1) * size(ris_3_n,2)]);
Dsr = reshape(Ds_n,[1 size(Ds_n,1) * size(Ds_n,2)]);
Ds_3r = reshape(Ds_3_n,[1 size(Ds_3_n,1) * size(Ds_3_n,2)]);



newSize = size(Ctr);


%inputV = [D1r; D2r; Dyr; repmat(D4t',1,newSize(2)); ...
%           repmat(D5t',1,newSize(2))];

inputV = [...
         Ctr; Ct_3r; Dsr; Ds_3r; ...
		 repmat(diffArea,1,newSize(2)); repmat(diffArea2,1,newSize(2)); ...
		 repmat(diffRis,1,newSize(2)); repmat(diffRis2,1,newSize(2)) ...
		 ];

%usiamo la somma...
%{
inputV = [...
         Ctr; Ct_3r; ...
		 grwr; grw_3r; risr; ris_3r; Dsr; Ds_3r];
%}

	
clear Ctr Ct_3r grwr grw_3r risr ris_3r Dsr Ds_3r
	
	
nFeatures = size(inputV,1);
nPixel = size(inputV,2);

if (ml > frameLoad - 1),
if (ml<10), inputFile = ['inputV_0' num2str(ml)]; end,
if (ml>=10), inputFile = ['inputV_' num2str(ml)]; end,
save([nnDir '\' inputFile],'inputV','nFeatures','nPixel','Imov','imov','jmov');



end,




fprintf(1,'%d... \n',ml);	







end, %end main loop ml


fprintf(1,'\n');	


clear obj










