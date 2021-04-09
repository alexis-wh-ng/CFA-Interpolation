clc;
clear;

%Original Image
origIm = imread('kodim23.png'); %%%%%%%%insert image
figure(1)
imshow(origIm)
title('original')

%%%%% a) MOSAICING ('RGGB' PATTERN)%%%%%%%%%%
[row, col, ch] = size(origIm);
bayerFilter = zeros(row, col, ch,'uint8');

%RGGB Bayer Pattern
for i = 1:row
  for j = 1:col
    if mod(i, 2) == 0 && mod(j, 2) == 0
      bayerFilter(i, j, 3) = origIm(i, j, 3); %Blue
    elseif mod(i, 2) == 0 && mod(j, 2) == 1
      bayerFilter(i, j, 2) = origIm(i, j, 2); %Green
    elseif mod(i, 2) == 1 && mod(j, 2) == 0
      bayerFilter(i, j, 2) = origIm(i, j, 2); %Green
    elseif mod(i, 2) == 1 && mod(j, 2) == 1 
      bayerFilter(i, j, 1) = origIm(i, j, 1); %Red 
    end
  end
end

figure(2);
imshow(bayerFilter);
title('Mosaiced Image')

%%%%% b) RECONSTRUCTING IMAGE - DEMOSAICING %%%%%%%%%%

%Bilinear function
bilinearImage = bilinear(bayerFilter);
figure(3);
imshow(bilinearImage);
title('Bilinear Interpolation')

%LMMSE Algorithm (By Zhang and Wu)
lmmseImage =dlmmse(bayerFilter);
figure(4);
imshow(lmmseImage);
title('LMMSE')

%MATLAB Built-in Demosaicing Function - converting to double image
temp = zeros(row, col,'uint8');
for i = 1:row
  for j = 1:col
    if mod(i, 2) == 0 && mod(j, 2) == 0
      temp(i, j) = origIm(i, j, 3);
    elseif mod(i, 2) == 0 && mod(j, 2) == 1
      temp(i, j) = origIm(i, j, 2);
    elseif mod(i, 2) == 1 && mod(j, 2) == 0
      temp(i, j) = origIm(i, j, 2);
    elseif mod(i, 2) == 1 && mod(j, 2) == 1
      temp(i, j) = origIm(i, j, 1);
    end
  end
end

matlabImage = demosaic(temp, 'rggb');

figure(5);
imshow(matlabImage);
title('Matlab')


%%%%% COMPUTE MSE %%%%%%%%%%

bilinear = immse(origIm, bilinearImage)
lmmse = immse(origIm, lmmseImage)
matlab = immse(origIm, matlabImage)


