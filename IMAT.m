
close all
clear all
clc
%%                          Simulation Parameters    
r = 0.5;                % Random (Missing) Sampling Rate 
alpha = 0.5;            % Exponential Threshold Reduction Factor
beta = 50;              % Initial Threshold
IterNum = 60;           % Number of Algorithm Iterations
ImgPath = 'Lena.bmp';   % Image Path
%%                             Random Sampling   
Img=im2double(imread(ImgPath));     % Loading Image
Smask=rand(size(Img))<r;            % Generating the Random Sampling Mask
SImg=Smask.*Img;                    % Random (Missing) Sampling
s=size(Img);
%%                            IMAT Reconstruction   
x=SImg;
for i=1:IterNum
    PSNR(i)=10*log10(max(max(Img)).^2*s(1)*s(2)/sum(sum((x-Img).^2)));  % PSNR Calculation
    Tx=dct2(x);                         % Switching to the Sparse Domain
    Thresh=beta*exp(-alpha*(i-1));      % Adapting the Threshold
    Tmask=abs(Tx)>Thresh;
    Threshx=idct2(Tmask.*Tx);           % Thresholding in the Sparse Domain & Returning to the Original Domain
    x=SImg+(1-Smask).*Threshx;          % Recursion Formula
end
%%                             Simulation Results   
Img=im2double(imread(ImgPath));     % Loading Image
Smask=rand(size(Img))<r;            % Generating the Random Sampling Mask
SImg=Smask.*Img;                    % Random (Missing) Sampling
subplot(2,2,1)
plot(PSNR,'*-')
xlabel('Number of Iterations')
ylabel('Reconstruction PSNR (dB)')
title('IMAT PSNR Convergence Curve')
subplot(2,2,2)
imshow(Img)
title('Original Image')
subplot(2,2,3)
imshow(SImg)
title('Random Sampled Image')
subplot(2,2,4)
imshow(x)
title('Reconstructed Image using IMAT')