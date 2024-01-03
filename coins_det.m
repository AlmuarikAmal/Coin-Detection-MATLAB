clc;
clear all;
close all;

coin_image = imread('coins.png');
[rows, columns, channels]= size(coin_image);

if channels > 1
    coin_image = rgb2gray(coin_image);
end

binary_image = im2bw(coin_image);
figure(2);
subplot(1,2,1),imshow(binary_image), title('Binary image');

binary_image_in = imfill(binary_image, 'holes');
figure(2);
subplot(1,2,2),imshow(binary_image_in), title('Binary image after filling holes');

binary_image_out = binary_image_in;

props = regionprops(binary_image_in, {'Area', 'Centroid'});

props = struct2table(props);
disp(props);

figure(1);
subplot(1,2,1), imshow(coin_image), title('original image');

dimes_type = 0;
nickel_type = 0;

for i = 1:numel(props.Area(:,1))
    if props.Area(i) < 2200
        coin_image = insertShape(coin_image, "circle", [props.Centroid(i,1) props.Centroid(i,2) 25], LineWidth=5);
        coin_image = insertText(coin_image,[props.Centroid(i,1)-20 props.Centroid(i,2)-10],'1 dimes',BoxOpacity=0.0,TextColor="blue");
        dimes_type = dimes_type + 1;
    else
        coin_image = insertShape(coin_image,"circle",[props.Centroid(i,1) props.Centroid(i,2) 30], LineWidth=5,  Color="green");
        coin_image = insertText(coin_image, [props.Centroid(i,1)-25 props.Centroid(i,2)-10],'2 Nickel',BoxOpacity=0.0,TextColor="red");
        nickel_type = nickel_type + 1;
    end
end
subplot(1,2,2), figure(1), imshow(coin_image), title('Detected coins');
fprintf('number of coins based on type:');
dimes_type
nickel_type

        
