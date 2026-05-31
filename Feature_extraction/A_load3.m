%loadframes


%spostiamo quelli vecchi
for kl=frameLoad:-1:2,
frameElab(:,:,:,kl) = frameElab(:,:,:,kl-1);
end,

%frameElab(:,:,:,3) = frameElab(:,:,:,2);
%frameElab(:,:,:,2) = frameElab(:,:,:,1);


%carichiamo quello nuovo
if (resizeV),
  frameElab(:,:,:,1) = imresize(read(obj, ml*floor(frameRate/7)),[240 320]);
else, 
  frameElab(:,:,:,1) = read(obj, ml*floor(frameRate/7));
end,


  

