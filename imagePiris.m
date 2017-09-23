close all;
clear all;

x = imread('iris.jpeg');
bw = hysthresh(x,180,60);
figure, imshow(bw);
