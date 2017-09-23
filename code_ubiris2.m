close all;
clear all;

xG = imread('C:\Users\HP-PC\Documents\3-1\image processing\UBIRIS_800_600\Sessao_2\1\1_1.jpg');
xG2 = rgb2gray(xG);
B = imresize(xG2, [256 256]);
subplot(2,1,1);
imshow(xG2);
[circleiris, circlepupil, imagewithnoise] = segmentiris2(B);
[polar_array, noise_array] = normaliseiris2(imagewithnoise, circleiris(2), circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3), 'C:\Users\HP-PC\Documents\3-1\image processing\UBIRIS_800_600\Sessao_2\1\myGray.jpg', 20, 240);
[template1, mask1] = encode1(polar_array, noise_array,1 ,18, 1, 0.5); 

A = imread('C:\Users\HP-PC\Documents\3-1\image processing\UBIRIS_800_600\Sessao_2\1\1_3.jpg');
C = rgb2gray(A);
D = imresize(C, [256 256]);
subplot(2,1,2);
imshow(C);
[circleiris2, circlepupil2, imagewithnoise2] = segmentiris2(D);
[polar_array2, noise_array2] = normaliseiris2(imagewithnoise2, circleiris2(2), circleiris2(1), circleiris2(3), circlepupil2(2), circlepupil2(1), circlepupil2(3), 'C:\Users\HP-PC\Documents\3-1\image processing\UBIRIS_800_600\Sessao_2\1\1_3.jpg' , 20, 240);
[template2, mask2] = encode1(polar_array2, noise_array2,1 ,18, 1, 0.5); 

hd = gethammingdistance(template1, mask1, template2, mask2, 1);
 



