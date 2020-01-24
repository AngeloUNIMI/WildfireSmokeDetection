





%---- (A PHASE PARAMETERS)  VIDEO LOADING PARAMETERS ----
frameLoad = 5;







%---- (B PHASE PARAMETERS)  SLOW MOVING REGION PARAMETERS ----
alfa1 = 0.7; %alfa per B_fast
alfa2 = 0.9; %alfa per B_slow 
c = 5;
sogliaEmpirica = 6;
nCC = 5; %n. componenti connessi da mantenere
sizeSe1 = 0; %dimensione elemento strutturale per moving
T_low = 10; %on Y channel
T_high = 30;  %on Y channel

%da aggiungere ai parametri:
%frequenza di aggiornamento B_slow %default 1/s

distantSmoke = 0; %if smoke is very distant, B_fast is replaced by current image I


%nOldMov = 3;
nOldMov = frameLoad;





%---- (C PHASE PARAMETERS) Smoke coloured regions ----
T_I = 40; %soglia che dice di quanto Y deve essere superiore a U e V
%T_y = 200;
T_y = 1000;
T_y2 = 30;

nOldCol = frameLoad;






%---- (D PHASE PARAMETERS) luminance control ----
thY = 10;

nOldY = frameLoad;






%---- (E PHASE PARAMETERS) growth detection ----
thMov = 0.8;
thArea1 = 1;
thArea2 = 10;
dimGrowth = 5; %numero di frame considerati dal growing






%---- (- PHASE PARAMETERS) Rising regions detection ----
dimRis = 5; %num di campioni da tenere
dimRis2 = 5;  %serie di risultati storici 
thRis = 0; %soglia (in pixel) che determina se il pixel sale
thRis2 = 10;





%SHAPE detection
nOldshape = 5;



%---- (Z PHASE PARAMETERS) final decision ----

nFin = 20; %num of pixel necessary to determine there is smoke


























%INIZIALIZATION PROCEDURES (EQUIVALENTE INIT.M)





%---- (A PHASE INIZIALIZATION)  ----

%calcoliamo il numero di frame
obj = VideoReader(videoFile);
nFrames = obj.NumberOfFrames;
if numel(nFrames) == 0,
nFrames = 500;
end,
frameRate = obj.FrameRate;
frameRead = nFrames;
height = obj.Height;
width = obj.Width;


%struttura dati
%il primo record è il frame corrente
%via via i frame più vecchi
if (resizeV),
frameElab = zeros(240,320,3,frameLoad); %colori
else
frameElab = zeros(height,width,3,frameLoad); %colori
end,
frameElab = uint8(frameElab);


%inizializziamo i primi N frame che ci interessano
for kw=1:frameLoad
if (resizeV),
  frameElab(:,:,:,kw) = imresize(read(obj, kw),[240 320]);
else, 
  frameElab(:,:,:,kw) = read(obj, kw);
end,%end if resizeV
end, %end for






%---- (B PHASE INIZIALIZATION)  ----

%inizializzo il D1
%che ha solo 1 frame
D1 = zeros(size(frameElab,1),size(frameElab,2));

%inizializzo D1_old
D1_old = zeros(size(frameElab,1),size(frameElab,2),nOldMov);


%inizializzo il B_fast
B_fast = double(rgb2gray(frameElab(:,:,:,1)));


%inizializzo il B_slow
B_slow = double(rgb2gray(frameElab(:,:,:,1)));

%inizializzo T fast
T_fast = zeros(size(frameElab,1),size(frameElab,2));
T_fast(:,:) = sogliaEmpirica;

%inizializzo T slow
T_slow = zeros(size(frameElab,1),size(frameElab,2));
T_slow(:,:) = sogliaEmpirica;






%---- (C PHASE INIZIALIZATION)  ----

%inizializzo il D2
%che ha solo 1 frame
D2 = zeros(size(frameElab,1),size(frameElab,2));

y = uint8(zeros(size(frameElab,1),size(frameElab,2)));
y_old = uint8(zeros(size(frameElab,1),size(frameElab,2)));

D2_old = zeros(size(frameElab,1),size(frameElab,2),nOldCol);



%---- (D PHASE INIZIALIZATION)  ----
Dy = ones(size(frameElab,1),size(frameElab,2));
Dy_old = ones(size(frameElab,1),size(frameElab,2),nOldY);





%---- (E PHASE INIZIALIZATION)  ----
D5 = 0;
D5t = zeros(1,dimGrowth);




%---- (- PHASE INIZIALIZATION)  ----

%I_xnt = zeros(1,dimRis);
Dr = zeros(size(frameElab,1),size(frameElab,2));
I_xnt = [];
minRis = 1000;
D4 = 0;
D4t = zeros(1,dimRis2);




%---- (G PHASE INIZIALIZATION)  ----
Ds = ones(size(frameElab,1),size(frameElab,2));
Ds_old = ones(size(frameElab,1),size(frameElab,2),nOldshape);





%---- (Z PHASE INIZIALIZATION)  ----
Df = 0;
Fin = zeros(size(frameElab,1),size(frameElab,2));
Dfin = 0;
alarmF = zeros(3,2);
alarmCount = 0;










