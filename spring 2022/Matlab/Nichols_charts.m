%   Matlab examples for SSCM Spring 2022 "Shop Talk" column.
%   Mangelsdorf 5/14/22
%
%   Open-Loop Transfer Functions.
s=tf('s');
sysG=60*(s/2+1)/((s/10-1)*(10*s+1)*(s/100 +1)*(s/1000 +1)*(s/10000+1));
sysH1=feedback(sysG,1);
sysH2=feedback(0.1*sysG,1);
%
%   Quick Stability Check for Unity Gain Loop.
StabilityStr= {'unstable','stable'};
fprintf(' H1 is %s\n',StabilityStr{isstable(sysH1)+1});
fprintf(' H2 is %s\n',StabilityStr{isstable(sysH2)+1});
%
%   Bode Plot.
figure('Name','Bode Plot','NumberTitle','off','WindowStyle','Docked');
margin(sysG); hold; margin(0.1*sysG);
%
%   2-D Nichols Plot.
figure('Name', '2-D Nichols Plot','NumberTitle','off','WindowStyle','Docked');
nichols(sysG,0.1*sysG); ngrid;
%
%   3-D Nichols Plot.
figure('Name', '3-D Nichols Plot','NumberTitle','off','WindowStyle','Docked');
y=linspace(-30,60); x=linspace(-360,0);
[X,Y]=meshgrid(x,y);
G=(10.^(Y/20)).*exp(j*X*pi/180);
H=G./(1+G);
surfh=surf(X,Y,20*log10(abs(H)),'FaceColor','white');
axis([-360,0,-30,40,-30,40]); hold;
%
[magG,phaseG,wG]=bode(sysG);
magG1=squeeze(magG); 
phaseG1=squeeze(phaseG);
%
[magG,phaseG,wG]=bode(0.1*sysG);
magG2=squeeze(magG); 
phaseG2 = squeeze(phaseG);
%
[magH1,phaseH1]=bode(feedback(sysG,1),wG);
[magH2,phaseH2]=bode(feedback(0.1*sysG,1),wG);
magH1=squeeze(magH1); magH2=squeeze(magH2);
%
plot3(phaseG1,20*log10(magG1),20*log10(magH1),'Color','b','LineWidth',3);
plot3(phaseG2,20*log10(magG2),20*log10(magH2),'Color','r','LineWidth',3);
xlabel('Open Loop Phase (deg)'); 
ylabel('Open Loop Gain (dB)'); zlabel('Closed Loop Gain (dB)');
%
rotate3d on;