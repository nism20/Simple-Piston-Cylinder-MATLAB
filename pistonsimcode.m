% piston cylinder code for ENME401 LCV assignment
% leo lloyd 21/05/20

clear all, close all, clc

syms pistHeight(L,a,theta)
pistHeight(L,a,theta) = a*cos(theta) + sqrt(L^2-a^2*sin(theta)^2); % height of piston, i.e. the furthest point from origin

% time vs height graph

syms t0 t
rpmConv = 2*pi/60;
angVel = 40*rpmConv; %constant velocity
angPos(t) = int(angVel,t0,0,t);

L = 190;
a = 65;

H(t) = pistHeight(L,a,angPos);

count = 1;

endTime = 5;

for i = 0:0.01:endTime
    x(count) = i;
    y(count) = H(i);
    count = count + 1;
end

plot(x, y)
    

sympref('FloatingPointOutput',true);
y2 = y(40:length(y));
peakY = max(y2);

xIndex = find(y2 == peakY, 1, 'first'); %y index of second peak
secondPeakTime = x(xIndex+(40-1));
div5 = (secondPeakTime/5);
inhaleStartY = H(secondPeakTime - div5);

inhaleDisplacement = peakY - inhaleStartY  % want this to be 55.
    

% animation:
% 
% figure;
% plot([-43 -43],[50 210],'k','LineWidth',3)
% hold on;
% plot([43 43],[50 210],'k','LineWidth',3)
% plot([-43 43],[210 210],'k','LineWidth',3)
% axis equal;
% 
% fanimator(@rectangle,'Position',[-43 H(t) 86 10],'FaceColor',[0.8 0.8 0.8])
% 
% fanimator(@(t) plot([0 50*sin(angPos(t))],[H(t) 50*cos(angPos(t))],'r-','LineWidth',3))
% fanimator(@(t) plot([0 50*sin(angPos(t))],[0 50*cos(angPos(t))],'g-','LineWidth',3))
% fanimator(@(t) text(-25,225,"Timer: "+num2str(t,2)));
% hold off;
% 
% playAnimation;
