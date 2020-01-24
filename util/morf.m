function [img2] = morf(img,typeE,typeSe,sizeSe,angle),

switch (typeSe),
case ('diamond'), se1 = strel('diamond',sizeSe);
case ('square'), se1 = strel('square',sizeSe);
case ('line'), se1 = strel('line',sizeSe,angle);
case ('disk'), se1 = strel('disk',sizeSe);
end,

switch (typeE),
case ('erode'), img2 = imerode(img,se1);
case ('dilate'), img2 = imdilate(img,se1);  	 
case ('open'), img2 = imopen(img,se1);	 
case ('close'), img2 = imclose(img,se1); 		 
case ('openclose'),  img2 = imclose(imopen(img,se1),se1); 
case ('closeopen'),  img2 = imopen(imclose(img,se1),se1); 			 
end,