%% 程序分享 
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% 维纳滤波图像处理
%--------------------------------------

clear
close all
clc
%% ****************************维纳滤波和均值滤波的比较*********************
img=imread('3096.jpg');
if size(img,3) == 3
   I=rgb2gray(img);
else
end

J=imnoise(I,'gaussian',0,0.01);
 
Mywiener2 = wiener2(J,[3 3]);
 
Mean_temp = ones(3,3)/9;
Mymean = imfilter(J,Mean_temp);
 
figure(1);
subplot(121),imshow(Mywiener2),title('维纳滤波器输出');
subplot(122),imshow(uint8(Mymean),[]),title('均值滤波器的输出');

%***********************维娜复原程序********************
figure(2);
subplot(231),imshow(I),title('原始图像');
 
LEN = 20;
THETA =10;
PSF = fspecial('motion',LEN,THETA);
 
Blurred = imfilter(I,PSF,'circular');
subplot(232),imshow(Blurred),title('生成的运动的模糊的图像');
 
noise = 0.1*randn(size(I));
subplot(233),imshow(im2uint8(noise)),title('随机噪声');
 
BlurredNoisy=imadd(Blurred,im2uint8(noise));
subplot(234),imshow(BlurredNoisy),title('添加了噪声的模糊图像');
 
Move=deconvwnr(Blurred,PSF);
subplot(235),imshow(Move),title('还原运动模糊的图像');

nsr = sum(noise(:).^2)/sum(im2double(I(:)).^2);
wnr2 = deconvwnr(BlurredNoisy,PSF,nsr);
subplot(236),imshow(wnr2),title('还原添加了噪声的图像');

%*************************维纳滤波应用于边缘提取****************************
N = wiener2(I,[3,3]);%选用不同的维纳窗在此修改
M = I - N;
My_Wedge = im2bw (M,5/256);%化二值图像
BW1 = edge(I,'prewitt');
BW2 = edge(I,'canny');
BW3 = edge(I,'zerocross');
BW4 = edge(I,'roberts');
 
figure(3)
subplot(2,4,[3 4 7 8]),imshow(My_Wedge),title('应用维纳滤波进行边沿提取');
subplot(241),imshow(BW1),title('prewitt');
subplot(242),imshow(BW2),title('canny');
subplot(245),imshow(BW3),title('zerocross');
subplot(246),imshow(BW4),title('roberts');

%*************************维纳滤波应用于图像增强***************************
for i = [1 2 3 4 5]
    K = wiener2(I,[5,5]);
end
 
  K = K + I;
 
figure(4);
subplot(121),imshow(I),title('原始图像');
subplot(122),imshow(K),title('增强后的图像');



