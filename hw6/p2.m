function p2()
clc; 
clear;
scale = 100;
sigma = 0.5;
chair = [2 2.5;
         3.5 3;];
desk = [5.5 2.5;
        6 3];
    
max_norm = normpdf(0, 0, sigma);
for i = 1:10 * scale
   for j = 1:10 * scale
       pos = [i/scale j/scale];
       d = dist(pos, chair(1,:));
       graph(i, j) = normpdf(d - 0.01, 0, sigma) / max_norm;
   end
end

for i = 1:10 * scale
   for j = 1:10 * scale
       pos = [i/scale j/scale];
       d = dist(pos, chair(2,:));
       graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
   end
end

for i = 1:10 * scale
   for j = 1:10 * scale
       pos = [i/scale j/scale];
       
       if (pos(1) >= desk(1, 1) && pos(1) <= desk(2, 1) && pos(2) >= desk(1, 2) && pos(2) <= desk(2, 2))
           graph(i, j) = 1;
       elseif (pos(1) <= desk(1, 1) && pos(2) <= desk(1, 2))
           d = dist(pos, [desk(1, 1) desk(1, 2)]);
           graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
       elseif (pos(1) <= desk(1, 1) && pos(2) >= desk(2, 2))
           d = dist(pos, [desk(1, 1) desk(2, 2)]);
           graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
       elseif (pos(1) >= desk(2, 1) && pos(2) <= desk(1, 2))
           d = dist(pos, [desk(2, 1) desk(1, 2)]);
           graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
       elseif (pos(1) >= desk(2, 1) && pos(2) >= desk(2, 2))
           d = dist(pos, [desk(2, 1) desk(2, 2)]);
           graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
       elseif (pos(1) <= desk(2, 1) && pos(1) >= desk(1, 1))
           d = min(abs([pos(2) - desk(1, 2), pos(2) - desk(2, 2)]));
           graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
       elseif (pos(2) >= desk(1, 2) && pos(2) <= desk(2, 2))
           d = min(abs([pos(1) - desk(1, 1), pos(1) - desk(2, 1)]));
           graph(i, j) = graph(i, j) + normpdf(d - 0.01, 0, sigma) / max_norm;
       end
   end
end


% imshow(graph, [0 1]);
plot(graph(:, 3 *scale))


function [d] = dist(robot_pose, pos)
    d = sqrt((robot_pose(1) - pos(1))^2 + (robot_pose(2) - pos(2))^2);
end
end