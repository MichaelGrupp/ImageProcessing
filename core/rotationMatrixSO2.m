function [R] = rotationMatrixSO2(theta)
R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
end