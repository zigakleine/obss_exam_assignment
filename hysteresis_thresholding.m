function [thresholded_img] = hysteresis_thresholding(image, tl, th)

    [h, w] = size(image);
    thresholded_img = zeros(h, w);
    
    gnh = image >= th;
    gnl = image >= tl;
    gnl = gnl - gnh;
    
    gnh = padarray(gnh,[1, 1]);
    gnl = padarray(gnl,[1, 1]);
    
%{    
    for i = 1  : h
        for j = 1 : w
            if (image(i, j) < tl)
                thresholded_img(i, j) = 0;
            elseif (image(i, j) > th)
                thresholded_img(i, j) = 1;
            elseif (image(i-1, j) > th || image(i+1, j) > th || image(i, j-1) > th || image(i, j+1) > th || image(i-1, j-1) > th || image(i+1, j+1) > th || image(i-1, j+1) > th || image(i+1, j-1) > th)
                thresholded_img(i,j) = 1;
            end
        end
    end
%}

    for i = 1  : h
        for j = 1 : w
            
            i_p = i+1;
            j_p = j+1;
            
            if gnh(i_p, j_p) > 0
                thresholded_img(i,j) = 1;
        
                if     gnl(i_p-1, j_p) > 0
                    thresholded_img(i-1, j) = 1;
                elseif gnl(i_p+1, j) > 0
                    thresholded_img(i+1, j) = 1;
                elseif gnl(i_p, j_p-1) > 0
                    thresholded_img(i, j-1) = 1;
                elseif gnl(i_p, j_p+1) > 0
                    thresholded_img(i, j+1) = 1;
                elseif gnl(i_p-1, j_p-1) > 0
                    thresholded_img(i-1, j-1) = 1;
                elseif gnl(i_p+1, j_p+1) > 0
                    thresholded_img(i+1, j+1) = 1;
                elseif gnl(i_p-1, j_p+1) > 0
                    thresholded_img(i-1, j+1) = 1;
                elseif gnl(i_p+1, j_p-1) > 0
                    thresholded_img(i+1, j-1) = 1;
                end
            end
              
        end
    end
