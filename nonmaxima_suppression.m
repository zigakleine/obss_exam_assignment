function [suppressed_img] = nonmaxima_suppression(magnitudes, angles)

    [h, w] = size(magnitudes);
    suppressed_img = zeros(h,w);
    
    disp(max(angles(:)));
    disp(min(angles(:)));   
    
    magnitudes_padded = padarray(magnitudes,[1, 1]);
    

    for i = 1:h
        for j = 1:w
            current_angle = angles(i, j);
            mag_i = i+1;
            mag_j = j+1;
            current_magnitude = magnitudes_padded(mag_i, mag_j);
            
            if ((current_angle >= -pi/8) && (current_angle <= pi/8)) || (current_angle > 7*pi/8) || (current_angle < -7*pi/8)
                % horizontal edge
                if current_magnitude < magnitudes_padded(mag_i-1, mag_j) || current_magnitude < magnitudes_padded(mag_i+1, mag_j)
                    suppressed_img(i,j) = 0;
                else
                    suppressed_img(i,j) = current_magnitude;
                end
     
            elseif (current_angle > pi/8) && (current_angle <= 3*pi/8) || (current_angle < -5*pi/8) && (current_angle >= -7*pi/8)
                % -45% edge
                if current_magnitude < magnitudes_padded(mag_i-1, mag_j-1) || current_magnitude < magnitudes_padded(mag_i+1, mag_j+1)
                    suppressed_img(i,j) = 0;
                else
                    suppressed_img(i,j) = current_magnitude;
                end 
           
            elseif (current_angle > 3*pi/8) && (current_angle <= 5*pi/8) || (current_angle < -3*pi/8) && (current_angle >= -5*pi/8)
                 % vertical edge  
                if current_magnitude < magnitudes_padded(mag_i, mag_j-1) || current_magnitude < magnitudes_padded(mag_i, mag_j+1)
                    suppressed_img(i,j) = 0;
                else
                    suppressed_img(i,j) = current_magnitude;
                end                 
                 
            elseif (current_angle > 5*pi/8) && (current_angle <= 7*pi/8) || (current_angle < -pi/8) && (current_angle >= -3*pi/8)                  
                % -45 edge  
                if current_magnitude < magnitudes_padded(mag_i-1, mag_j+1) || current_magnitude < magnitudes_padded(mag_i+1, mag_j-1)
                    suppressed_img(i,j) = 0;
                else
                    suppressed_img(i,j) = current_magnitude;
                end                
                 
            else
                disp("ojoj");
            end
                        
        end
    end