% biometric identification and matching or iris
%its functionality has to altered. Tweak it to search through database

close all;
clear all;

xG = imread('C:\Users\Aditya\Pictures\Images_Database\001\L\S1001L01.jpg'); % input image given by user
eyeimage_filename = 'C:\Users\Aditya\Pictures\Images_Database\001\L\S1001L01.jpg'; % filename with path 
subplot(2,2,1); % show the image to the user 
imshow(xG);
title('Input Image');
[circleiris, circlepupil, imagewithnoise] = segmentiris(xG);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% will now draw  circles on the images to identify irir and pupil  boundary
subplot(2,2,2), imshow(xG);
title('Segmented Image');
hold on;
rowi = circleiris(1);
coli = circleiris(2);
ri = circleiris(3);
rowp = circlepupil(1); % all this to enable multiplication 
colp = circlepupil(2);% for drawing circles
rp = circlepupil(3);

rowi = round(double(rowi));
coli = round(double(coli));
ri = round(double(ri));

rowp = round(double(rowp));
colp = round(double(colp));
rp = round(double(rp));

theta = 0 : (2 * pi / 10000) : (2 * pi);
pline_x = rp * cos(theta) + colp; % col gives x co-ordinate
iline_x = ri * cos(theta) + coli;
pline_y = rp * sin(theta) + rowp; % row gives y co-ordinate
iline_y = ri * sin(theta) + rowi;
plot(pline_x, pline_y, '-');
hold on;
plot(iline_x, iline_y, '-');
hold off;
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% apply a transform to convert the annulus to a rectangular sheet i.e is a polar array  
[polar_array, noise_array] = normaliseiris1(imagewithnoise, circleiris(2), circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3), 'C:\Users\Aditya\Pictures\Images_Database\001\L\S1001L01.jpg', 20, 240);
subplot(2,2,3), imshow(polar_array);
title('Normalised Image');
% now perform encoding on the image using gabor log transform and get a
% encoded image pattern
[template1, mask1] = encode1(polar_array, noise_array,1 ,18, 1, 0.5); 
%template3 = template1;
% the template contains the final encoded pattern that is to be matched
subplot(2,2,4), imshow(template1); title('encoded image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eyeDestination = 'C:\Users\Aditya\Pictures\MATLABCreatedDatabase\S1_Temp.jpg';
% template2 = load(eyeDestination,'S1_Temp','-ascii');
% eyeDestination = 'C:\Users\Aditya\Pictures\MATLABCreatedDatabase\S1_Mask.jpg';
% mask2 = load(eyeDestination,'S1_Mask','-ascii');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hd = gethammingdistance(template1, mask1, template2, mask2, 1);




