function [] = plotconf2(dat),

if size(dat,1) == 2 && size(dat,2) == 2,


f = figure('Position',[200 200 400 170]);
grid off
axis off
rnames = {'Target Class 0','Target Class 1'};
cnames = {'Output Class 0', 'Output Class 1'};
t = uitable('Parent',f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames,'Position',[20 20 360 100]);
			
			
else,

fprintf(1,'Matrix must be 2x2 ! \n\n');

end