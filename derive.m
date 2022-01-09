function [magnitudes, angles, lp_filtered_image] = derive(image)

    prewitt_mask_x = [-1, -1, -1; 0, 0, 0; 1, 1, 1];
    prewitt_mask_y = [-1, 0, 1; -1, 0, 1; -1, 0, 1];
    
    [h, w] = size(image);
    
    if h >= w
        dimension = w;
    else
        dimension = h;
    end
    sigma = 0.005*dimension;
    kernel_size = floor(6*sigma);
    
    if mod(kernel_size, 2) == 0
        kernel_size=kernel_size+1;
    end
    
    disp(sigma);
    disp(kernel_size);
    gaussian_kernel = fspecial('gaussian',[kernel_size, kernel_size],sigma);

    lp_filtered_image = imfilter(image, gaussian_kernel);
    derivation_x = imfilter (double(lp_filtered_image), prewitt_mask_x);
    derivation_y = imfilter (double(lp_filtered_image), prewitt_mask_y);


    magnitudes = sqrt((derivation_x.^2) + (derivation_y.^2));
    angles = atan2(derivation_y, derivation_x);

