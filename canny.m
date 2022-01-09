
function canny(img_name)
    image = imread("./ctmridb/" + img_name);
    image = im2double(image);

    to_display = image;
    
    [magnitudes, angles, lp_filtered_image] = derive(image);

    %imshow(lp_filtered_image);
    %imshow(magnitudes, []); 
    %imshow(angles, []);

    %imshow([magnitudes, angles]);

    image = nonmaxima_suppression(magnitudes, angles);  

    to_display = [to_display, image];
    %imshow(image);
    th = 0.1;
    tl = th/2;

    image = hysteresis_thresholding(image, th, tl);
    
    to_display = [to_display, image];
    imshow(to_display);
    
    imwrite(uint8(image*255), "./results/edges_" + img_name);
    
    %Canny_img = edge(image,'Canny');
    %imshow(Canny_img)