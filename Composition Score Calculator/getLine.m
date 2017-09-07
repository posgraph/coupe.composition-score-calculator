function endPoints = getLine(im)
f = fspecial('gaussian', [5, 5], 5);
im = imfilter(im, f, 'symmetric');
gray = rgb2gray(im);
BW = edge(gray,'canny', [0.2 0.5]);

[H, T, R] = hough(BW, 'RhoResolution', 5);
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',5);
%figure, imshow(im), hold on
max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
    % Plot beginnings and ends of lines
    %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
    %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % Determine the endpoints of the longest line segment
    len = norm(lines(k).point1 - lines(k).point2);
    if ( len > max_len)
        max_len = len;
        xy_long = xy;
    end
end
% plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
nlines = length(lines);
a = zeros(nlines, 1);
b = zeros(nlines, 1);
for k = 1:nlines
    a(k) = lines(k).rho;
    b(k) = lines(k).theta;
end
ma = mean(a);
mb = mean(b);
a = a - ma;
b = b - mb;
sa = std(a);
sb = std(b);
a = a / sa;
b = b / sb;
if(nlines == 0)
    endPoints= -ones(2,2);
    return;
end

if (sa==0) || (sb==0)
    endPoints=zeros(2,2);
else
    num_cluster = min(5, size(a, 1));
    [idx, center] = kmeans([a b], num_cluster);
    %
    sum_line_length = zeros(num_cluster, 1);
    for a = 1:size(idx,1)
        xy = [lines(a).point1; lines(a).point2];
        sum_line_length(idx(a)) = sum_line_length(idx(a)) + sqrt((xy(2,1)-xy(1,1))^2 + (xy(2,2)-xy(1,2))^2);
    end
    
    
    
    % num_lines = zeros(num_cluster, 1);
    % for i = 1:num_cluster
    %     num_lines(i) = sum(idx(:) == i);
    % end
    % [sorted_num_lines, index] = sort(num_lines, 'descend');
    
    [sorted_length_lines, index] = sort(sum_line_length, 'descend');
    
    
    ab = center(index(1), :) .* [sa sb] + [ma mb];
    rho = ab(1);
    theta = deg2rad(ab(2));
    [h, w, c] = size(im);
    
    ips =   int32([1, (rho-cos(theta))./sin(theta);
        w, (rho-w*cos(theta))./sin(theta);
        (rho-sin(theta))./cos(theta), 1;
        (rho-h*sin(theta))./cos(theta), h]);
    endPoints=zeros(2, 2); % [x, y; x, y];
    
    j=1;
    for i=1:4
        p = ips(i, :);
        if(p(1) > 0 && p(1) <= w && p(2) > 0 && p(2) <= h)
            endPoints(j, :) = p;
            j = j + 1;
        end
    end
end
% disp(endPoints);
% plot(endPoints(:, 1), endPoints(:, 2), 'LineWidth', 3, 'Color', 'Blue');
end
