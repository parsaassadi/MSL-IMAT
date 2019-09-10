
%%                             Initialization
close all
clear all
clc
ImgPath = 'Lena.bmp';   % Image Path

Img=im2double(imread(ImgPath));     % Loading Image

dft2 = (fft2(Img));
for i=1:2:512
    for j=1:2:512
        dft2(i,j) = 0;
    end
end
Constructed_Image = ifft2(dft2);
imshow(Constructed_Image)