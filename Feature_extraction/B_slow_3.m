%lavoriamo solo su grayscale
%sorgente frameElab
%I nel testo




%PEZZO SU DISTANT SMOKE?




I1 = rgb2gray(frameElab(:,:,:,1));
I2 = rgb2gray(frameElab(:,:,:,2));
I3 = rgb2gray(frameElab(:,:,:,3));
	

%I(:,:,k) = I1 (frame corrente)
%I(:,:,k-1) = I2 (frame prima -1)
%I(:,:,k-2) = I3 (frame prima -2)


%controllo se il pixel è stationary o moving
%moving matrix fast
m1 = (   I1 - I2 ) > T_fast;
m2 = (   I1 - I3 ) > T_fast;
mv_fast = m1 .* m2;

%moving matrix slow
m1 = (   I1 - I2 ) > T_slow;
m2 = (   I1 - I3 ) > T_slow;
mv_slow = m1 .* m2;


%aggiorno lo sfondo B_fast a seconda che il pixel sia moving o no
if (distantSmoke == 0),
b_1 = B_fast .* double(mv_fast);
b_2 = (     alfa1 .* B_fast + (1-alfa1) .* double(I1)        ) .* double(~mv_fast);
B_fast_new = b_1 + b_2;
%e la soglia
t_1 = T_fast .* double(mv_fast);
t_2 = (      alfa1 .* T_fast + (1-alfa1) .* (c .* abs(double(I1) - B_fast)  )      ) ...
       .* double(~mv_fast);
T_fast_new = t_1 + t_2;
end,




%aggiorno lo sfondo B_slow  a seconda che il pixel sia moving o no
if (mod(ml,frameRate) == 0), % once in a second

b_1 = B_slow .* double(mv_slow);
b_2 = (     alfa2 .* B_slow + (1-alfa2) .* double(I1)        ) .* double(~mv_slow);
B_slow_new = b_1 + b_2;
%e la soglia
t_1 = T_slow .* double(mv_slow);
t_2 = (      alfa2 .* T_slow + (1-alfa2) .* (c .* abs(double(I1) - B_slow)  )      ) ... 
      .* double(~mv_slow);
T_slow_new = t_1 + t_2;

else, 

B_slow_new = B_slow;  %lascia uguale
T_slow_new = T_slow;  %lascia uguale

end, %end if mod framerate



%decision level
%in the luminance component (Y) should be equal to grayscale?
d_1 = (abs(B_fast - B_slow)  < T_low)  .* -1;
%res = 2 *  (     (abs(B_fast-B_slow) - T_low) / (T_high - T_low)     )  - 1;
res = -1;
d_2 = (abs(B_fast - B_slow)  >= T_low) .* (abs(B_fast - B_slow)  <= T_high) .* res;
d_3 = (abs(B_fast - B_slow)  > T_high)  .*  1;

D1 = d_1 + d_2 + d_3;




%end, %end for k (frames)

%aggiorno

B_fast = B_fast_new;
T_fast = T_fast_new;
B_slow = B_slow_new;
T_slow = T_slow_new;








%spostiamo quelli vecchi
for koldmov=nOldMov:-1:2,
D1_old(:,:,koldmov) = D1_old(:,:,koldmov-1);
end,
D1_old(:,:,1) = D1;

