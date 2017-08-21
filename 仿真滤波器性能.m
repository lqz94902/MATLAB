% 仿真滤波器性能
clear all;


LFOrHF = 1; % 1:LF;2:HF
% fs = 100000; % fs= 100kHz
% fs = 400000; % fs= 100kHz
% f1 = 3000;    % f1 = 100Hz
% f2 = 13000;   % f2 = 10kHz

fs = 5100; % fs= 400kHz
fs = 4080; % fs= 400kHz
f1 = 1200;    % f1 = 400Hz
f2 = 20000;   % f2 = 20kHz
t = 0:1/fs:50/f1;

s1 = sin(2*pi*f1*t)*63;
s11 = [0 s1(1:end-1)];
plot(s1,'r')
hold on;
plot(0.5*(s1+s11))

fs2 = 5000; % fs= 400kHz
t2 = 0:1/fs2:10/f1;

S1 = sin(2*pi*f1*t2)*63;
plot(S1)

s2 = sin(2*pi*f2*t)*63;
s = s1 + s2;
fix_s = fix(s);


if(LFOrHF == 1)
    fc = 1000;
else
    fc = 20000;
end,

Rfc = fc/(fs/2);
M = 29;
Deltaw = 6.6*pi/(M-1);
wp = Deltaw - Rfc*pi;
ws = Deltaw + Rfc*pi;

n=[0:1:M-1];
wc=Rfc*pi;
alpha=(M-1)/2;
m=n-alpha+0.00000001;
if(LFOrHF == 1)
    hd=sin(wc*m)./(pi*m);
else
    hd=(-sin(wc*m))./(pi*m);
%     hd=(sin(pi*m)-sin(wc*m))./(pi*m);
    hhh = sin(pi*m);
    
    hd(fix((M+1)/2)) = 1 - wc/pi;
end,

x = (0:M-1)'/(M-1);

w_ham = 0.54 - 0.46*cos(2*pi*x);    %升余弦
% w_ham = ones(M,1);                %矩形窗
h=hd.*w_ham';

y = filter(h,1,s);
figure(4)
subplot(211)
plot(s)
subplot(212)
plot(y)
