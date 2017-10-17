function  [line_value, line_info] = getLineValue(endPoints, w, h)

thirds_line = zeros(4, 4); % [x, y; x, y];
thirds_line(1, :) = [0, 1/3*h, w, 1/3*h];
thirds_line(2, :) = [0, 2/3*h, w, 2/3*h];
thirds_line(3, :) = [1/3*w, 0, 1/3*w, h];
thirds_line(4, :) = [2/3*w, 0, 2/3*w, h];
thirds_center = zeros(4, 2);
thirds_center(1,:) = [0.5*w, 1/3*h];
thirds_center(2,:) = [0.5*w, 2/3*h];
thirds_center(3,:) = [1/3*w, 0.5*h];
thirds_center(4,:) = [2/3*w, 0.5*h];
sigma_line = 0.17;
line_idx = 1;

% double temp = line.LineDistance(ThirdsLn[0]);
% double LineDistance(const CCompLine &dstLine) const { return aver_dist(dstLine); }
% 
% double aver_dist(const Line2D& ln) const{
% 		const double d1 = ln.sdist( start );
% 		const double d2 = ln.sdist( end );
% 		if( d1*d2>=0 )	return fabs(d1+d2)/2;
% 		return (square(d1)+square(d2))/2/fabs(d1-d2);		//	d = d1*l1/l + d2*l2/l = (d1^2+d2^2)/(|d1|+|d2|)
% 	}
%         
% 
% pt: prominant line�� start, Ȥ�� end
% ls: third line�� start
% le: third line�� end
% 
% ((le.y()-ls.y())*pt.x() - (le.x()-ls.x())*pt.y() + le.x()*ls.y() - ls.x()*le.y())/len;


len = sqrt((thirds_line(1,3)-thirds_line(1,1))^2 + (thirds_line(1,4)-thirds_line(1,2))^2);
d1 = (((thirds_line(1,4)-thirds_line(1,2)) * endPoints(1,1) - (thirds_line(1,3)-thirds_line(1,1))*endPoints(1,2) + thirds_line(1,3)*thirds_line(1,2) - thirds_line(1,1)*thirds_line(1,4)))/len;
d2 = (((thirds_line(1,4)-thirds_line(1,2)) * endPoints(2,1) - (thirds_line(1,3)-thirds_line(1,1))*endPoints(2,2) + thirds_line(1,3)*thirds_line(1,2) - thirds_line(1,1)*thirds_line(1,4)))/len;
if (d1*d2 >= 0)
    temp = abs(d1+d2)/2;
else
    temp = (d1^2+d2^2) / 2 / abs(d1-d2);
end


for i = 2 : 4    
    len = sqrt((thirds_line(i,3)-thirds_line(i,1))^2 + (thirds_line(i,4)-thirds_line(i,2))^2);
    d1 = (((thirds_line(i,4)-thirds_line(i,2)) * endPoints(1,1) - (thirds_line(i,3)-thirds_line(i,1))*endPoints(1,2) + thirds_line(i,3)*thirds_line(i,2) - thirds_line(i,1)*thirds_line(i,4)))/len;
    d2 = (((thirds_line(i,4)-thirds_line(i,2)) * endPoints(2,1) - (thirds_line(i,3)-thirds_line(i,1))*endPoints(2,2) + thirds_line(i,3)*thirds_line(i,2) - thirds_line(i,1)*thirds_line(i,4)))/len;
    if (d1*d2 >= 0)
        line_distance = abs(d1+d2)/2;
    else
        line_distance = (d1^2+d2^2) / 2 / abs(d1-d2);
    end
        
    if (line_distance < temp)
        temp = line_distance;
        line_idx = i;
    end
end

x1 = endPoints(1,1);
y1 = endPoints(1,2);
x2 = endPoints(2,1);
y2 = endPoints(2,2);
k = abs((y2-y1) / (x2-x1));
image_center_x = 0.5 * w;
image_center_y = 0.5 * h;
targetPoint = zeros(1,2);

if (line_idx == 1) || (line_idx == 2)
    tanTheta = h/w;
    tanTheta1 = 1/4 * tanTheta;
    tanTheta2 = 3/4 * tanTheta;
    if (k < tanTheta1)
        targetPoint = thirds_center(line_idx, :);
        line_info = 0; % HORIZONTALLINE
%     elseif (tanTheta1 <= k && k <= tanTheta2)
%         targetPoint(1,1) = thirds_center(line_idx, 1) + (k - tanTheta1)/(tanTheta2 - tanTheta1)*(image_center_x - thirds_center(line_idx, 1));
%         targetPoint(1,2) = thirds_center(line_idx, 2) + (k - tanTheta1)/(tanTheta2 - tanTheta1)*(image_center_y - thirds_center(line_idx, 2));
%         line_info = 2; % DIAGONALLINE_HORIZONTAL
%         disp('sshang1');
%    elseif (tanTheta2 < k)
    else
        targetPoint = ([image_center_x, image_center_y]);
        line_info = 2;
        if (x2-x1) == 0
            line_info = 1;
        end
    end
    dist = abs(targetPoint(1,2)-(y1+y2)*0.5)/w + abs(targetPoint(1,1)-(x1+x2)*0.5)/h;
    line_value = exp(-dist*dist/2/sigma_line^2);

    
elseif (line_idx == 3) || (line_idx == 4)
    k = 1/k;
    tanTheta = w/h;
    tanTheta1 = 1/4 * tanTheta;
    tanTheta2 = 3/4 * tanTheta;
    if (k < tanTheta1) || ((x2-x1) == 0)
        targetPoint = thirds_center(line_idx, :);
        line_info = 1; % VERTICALLINE
%     elseif (tanTheta1 <= k && k <= tanTheta2)
%         targetPoint(1,1) = thirds_center(line_idx, 1) + (k - tanTheta1)/(tanTheta2 - tanTheta1)*(image_center_x - thirds_center(line_idx, 1));
%         targetPoint(1,2) = thirds_center(line_idx, 2) + (k - tanTheta1)/(tanTheta2 - tanTheta1)*(image_center_y - thirds_center(line_idx, 2));
%         line_info = 3; % DIAGONALLINE_VERTICAL
%         disp('sshang2');
%    elseif (tanTheta2 < k)
    else
        targetPoint = ([image_center_x, image_center_y]);
        line_info = 3;
    end
    dist = abs(targetPoint(1,1)-(x1+x2)*0.5)/w + abs(targetPoint(1,2)-(y1+y2)*0.5)/h;
    line_value = exp(-dist*dist/2/sigma_line^2);

end
    
    












    

