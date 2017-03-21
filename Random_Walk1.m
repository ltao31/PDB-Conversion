function [] = Random_Walk1()
%--------------------------------------------------------------------------
%
%Description: Making a random walk for the vesicle
%
%     Inputs: A diffusion coefficient, max length, and time
%
%    Outputs: A histogram and graphical representation of on average how
%             far away the vesicle diffuses.
%
%--------------------------------------------------------------------------

xStart = rand(1)*100000;
yStart = rand(1)*100000;
zStart = rand(1)*100000;
% D = input('What is the diffusion Coefficient?');% recommend using 1.52e-14
% time = input('what is duration of simulation time steps?');%recommend 10 s
% t = input('what is the time steps?');%recommend 0.01 s
% maxLength = 1.80e-07;% in meters
D = 1.52;%in 10^-14 meters
time = 100;
t = 0.1;
radius = 0.5;%radius does not matter. This is for graphical purposes only
maxLength = 18.0*10^7; %in 10^-14 meters

%plot initial vesicles
[x, y, z] = sphere;
Ves1=[xStart yStart zStart radius];
s1=surf(x*Ves1(1,4)+Ves1(1,1),y*Ves1(1,4)+Ves1(1,2),z*Ves1(1,4)+Ves1(1,3));
hold on

for i = 1:10000
    steps = [xStart yStart zStart];
    %run through
    for j = 1:time/t
        prevsteps = steps;
        if rand(1)>0.5
            steps(1) = steps(1)-sqrt(6*D*t);
        else
            steps(1) = steps(1)+sqrt(6*D*t);
        end
        if rand(1)>0.5
            steps(2) = steps(2)-sqrt(6*D*t);
        else
            steps(2) = steps(2)+sqrt(6*D*t);
        end
        if rand(1)>0.5
            steps(3) = steps(3)-sqrt(6*D*t);
        else
            steps(3) = steps(3)+sqrt(6*D*t);
        end
        delPos(j) = sqrt((steps(1)-xStart).^2 + (steps(2)-yStart).^2 + (steps(3)-zStart).^2);
        if delPos(j) >= maxLength
            steps = prevsteps;
        end
    end
    %find the change in position in 10^-14 meters
    delPos(i) = sqrt((steps(1)-xStart).^2 + (steps(2)-yStart).^2 + (steps(3)-zStart).^2);
    %replot the final position of the original vesicle
    s2=surf(x*Ves1(1,4)+steps(1),y*Ves1(1,4)+steps(2),z*Ves1(1,4)+steps(3));
end
figure
% delPos = delPos(delPos<0.0001);
hist(delPos);
hold off
end






