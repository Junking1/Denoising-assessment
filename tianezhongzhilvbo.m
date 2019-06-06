clear;clc;
I=imread('swanNoise.bmp');
OI = imread('swanOriginal.bmp');
G=I;
G = medfilt2(G,[3,3]);
M=2*size(G,1);
N=2*size(G,2);
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u, v);
D=sqrt(U.^2+V.^2);
D0=132;
n=6;
H=1./(1+(D./D0).^(2*n));
J=fftshift(fft2(G, size(H, 1), size(H, 2))); 
K=J.*H;
L=ifft2(ifftshift(K));
L=L(1:size(G,1), 1:size(G, 2));
subplot(1,2,1),imshow(I),title('原图');
subplot(1,2,2),imshow(L,[]),title('中值后巴特沃斯低通滤波');

RMSE=RMSE(L,OI)