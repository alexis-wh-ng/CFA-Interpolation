function result = bilinear(img)

img = im2double(img);
[row,col,ch] = size(img);

%for odd number of pixels
if mod(row,2) == 1
    row = row-1;
elseif mod(col,2) == 1
    col = col-1;
end

r_temp = img(:,:,1);
g_temp = img(:,:,2);
b_temp = img(:,:,3);

%used to print final image
R = r_temp;
G = g_temp;
B = b_temp;

for i=2:1:row-1
    for j=2:1:col-1
        
        %Green Channel
        if g_temp(i,j)==0
           G(i,j)=(g_temp(i,j-1)+g_temp(i,j+1)+g_temp(i+1,j)+g_temp(i-1,j))/4;
        end
        
        %Red Channel
        if r_temp(i-1,j)==0 && r_temp(i+1,j)==0 && r_temp(i,j-1)==0 && r_temp(i,j+1)==0
            if r_temp(i,j)==0
                R(i,j)=(r_temp(i-1,j-1)+r_temp(i-1,j+1)+r_temp(i+1,j-1)+r_temp(i+1,j+1))/4;
            end
        elseif r_temp(i-1,j)~=0 && r_temp(i+1,j) ~= 0 && r_temp(i,j-1)==0 && r_temp(i,j+1)==0
            R(i,j)=(r_temp(i-1,j)+r_temp(i+1,j))/2;
        elseif r_temp(i,j-1)~=0 && r_temp(i,j+1)~= 0 && r_temp(i-1,j)==0 && r_temp(i+1,j)==0
            R(i,j)=(r_temp(i,j-1)+r_temp(i,j+1))/2;
        end
        
        %Blue Channel
        if b_temp(i-1,j)==0 && b_temp(i+1,j)==0 && b_temp(i,j-1)==0 && b_temp(i,j+1)==0
            if b_temp(i,j)==0
                B(i,j)=(b_temp(i-1,j-1)+b_temp(i-1,j+1)+b_temp(i+1,j-1)+ b_temp(i+1,j+1))/4;
            end
        elseif b_temp(i-1,j)~=0 && b_temp(i+1,j) ~= 0 && b_temp(i,j-1)==0 && b_temp(i,j+1)==0
            B(i,j)=(b_temp(i-1,j)+b_temp(i+1,j))/2;
        elseif b_temp(i,j-1)~=0 && b_temp(i,j+1)~= 0 && b_temp(i-1,j)==0 && b_temp(i+1,j)==0
            B(i,j)=(b_temp(i,j-1)+b_temp(i,j+1))/2;
        end
    end
end

%EDGE CASES

%Green channel
for j = 3:2:col
    G(1,j) = (g_temp(1,j-1) + g_temp(1,j+1))/2;
end

for j = 2:2:col-1
    G(row,j) = (g_temp(row,j-1) + g_temp(row,j+1))/2;
end

for i = 3:2:row
    G(i,1) = (g_temp(i-1,1) + g_temp(i+1,1))/2;
end

for i = 2:2:row-1
    G(i,col) = (g_temp(i-1,col) + g_temp(i+1,col))/2;
end
G(1,1) = (g_temp(1,2)+g_temp(2,1))/2;
G(row,col) = (g_temp(row-1,col) + g_temp(row,col-1))/2;

%Red channel
for j=2:2:col-1
    R(1,j) = (r_temp(1,j-1) + r_temp(1,j+1))/2;
end
for i=2:2:row-1
    R(i,1) = (r_temp(i-1,1) + r_temp(i+1,1))/2;
end
for i=1:row
    R(i,col) = R(i,col-1)/2;
end
for i = 1:col
    R(row,i) = R(row-1,i)/2;
end

%Blue channel
for j=3:2:col
    B(row,j) = (b_temp(row,j-1) + b_temp(row,j+1))/2;
end
for i=3:2:row
    B(i,col) = (b_temp(i-1,col) + b_temp(i+1,col))/2;
end
for j = 1:col
    B(1,j) = B(2,j)/2;
end
for i = 1:row
    B(i,1) = B(i,2)/2;
end

result(:,:,1) = R; 
result(:,:,2) = G; 
result(:,:,3) = B;

result = im2uint8(result);

return
