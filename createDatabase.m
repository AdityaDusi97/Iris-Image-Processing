% creating the database 

close all;
clear all;

xG = imread('C:\Users\Aditya\Pictures\Images_Database\026\R\S1026R01.jpg'); % input image given by user
eyeimage_filename = 'C:\Users\Aditya\Pictures\Images_Database\026\R\S1026R01.jpg'; % filename with path 
%subplot(2,2,1); % show the image to the user 
%imshow(xG);
%title('Input Image');
[circleiris, circlepupil, imagewithnoise] = segmentiris(xG);

[polar_array, noise_array] = normaliseiris1(imagewithnoise, circleiris(2), circleiris(1), circleiris(3), circlepupil(2), circlepupil(1), circlepupil(3), 'C:\Users\Aditya\Pictures\Images_Database\026\R\S1026R01.jpg', 20, 240);
%subplot(2,2,3), imshow(polar_array);
%title('Normalised Image');

[template1, mask1] = encode1(polar_array, noise_array,1 ,18, 1, 0.5);

eyeDestination = 'C:\Users\Aditya\Pictures\MATLABCreatedDatabase\S26_Temp.jpg';
save(eyeDestination,'template1','-ascii');
eyeDestination = 'C:\Users\Aditya\Pictures\MATLABCreatedDatabase\S26_Mask.jpg';
save(eyeDestination,'mask1','-ascii');

