%luminance difference analysis
%differenze troppo grandi significano oggetti in movimento veloce (e dai contorni netti)



Dy(:,:) = 1;



diffY = abs(y - y_old);

%togliamo le zone con troppa differenza di luminanza
Iy = find(diffY > thY);


Dy(Iy) = -1;


%imshow(Dy,[])
%spostiamo quelli vecchi
for koldy=nOldY:-1:2,
Dy_old(:,:,koldy) = Dy_old(:,:,koldy-1);
end,
Dy_old(:,:,1) = Dy;