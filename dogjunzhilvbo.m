clear;clc;
I=imread('dogDistorted.bmp');

F=I;
[m,n]=size(I);
for i=2:m-1
    for j=2:n-1
        A=F(i-1:i+1,j-1:j+1);
        F(i,j)=mean(mean(A(:)));
    end
end
I=uint8(I);
subplot(1,2,1),imshow(I);
title('原图');
G = F;
M=2*size(G,1);
N=2*size(G,2);
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u, v);
D=sqrt(U.^2+V.^2);
D0=120;
n=6;
H=1./(1+(D./D0).^(2*n));
J=fftshift(fft2(G, size(H, 1), size(H, 2))); 
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(G,1), 1:size(G, 2));
subplot(1,2,2),imshow(L,[]);
title('均值后巴特沃斯低通滤波图像');
OI = imread('dogOriginal.bmp');
RMSE=RMSE(L,OI)