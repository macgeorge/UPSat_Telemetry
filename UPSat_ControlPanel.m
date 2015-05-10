%UPSat Telemetry for EPS.
%It displays all the measurement data on a figure and saves it an an array

%Revision 1.1: Initial Release
%Date: 8/5/2015
%Author: George Christidis

%serial data format: X1;X2;X3;X4;...;X15
%with
%X1: PV1 voltage, X2: PV2 voltage, X3: PV3 voltage, X4: PV4 Voltage,
%X5: PV1 current, X6: PV2 current, X7: PV3 current, X8: PV4 current, X9:
%Battery Current positive, X10: Battery Current negative, X11: Battery
%Voltage, X12: 3.3V rail current, X13: 5V rail current, X14: Temperature1,
%X15: Temperature2

%output array data format: X1;X2;X3;X4;...;X16
%with
%X1: PV1 voltage, X2: PV2 voltage, X3: PV3 voltage, X4: PV4 Voltage,
%X5: PV1 current, X6: PV2 current, X7: PV3 current, X8: PV4 current, X9:
%Battery Current positive, X10: Battery Current negative, X11: Battery
%Current, X12: Battery Voltage, X13: 3.3V rail current, X14: 5V rail current, X15: Temperature1,
%X16: Temperature2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

t = 0; %x-axis
stop=0; %button
linestyle='-r.'; %line style
subplotx=4;
subploty=4;
startSpot = 0; %x-axis temp left point
step = 1 ;
startValue=0; %x-axis lef point
endValue=10; %x-axis right point
zoom=1; %determined by buttons
pan=0; %determined by buttons
startValuetemp=0;
starttime=clock;
samples=1;

%init
mes1=0;
mes2=0;
mes3=0;
mes4=0;
mes5=0;
mes6=0;
mes7=0;
mes8=0;
mes9=0;
mes10=0;
mes11=0;
mes12=0;
mes131=0;
mes132=0;
mes13=0;
mes14=0;
mes15=0;
mes16=0;
mes17=0;
mes18=0;
data='';


%%%%%%%SERIAL CONFIG%%%%%%%%%%%
%s=serial('/dev/tty.usbmodemfa131','baudrate', 9600, 'databits', 8, 'stopbits', 1)
%fopen(s);
%readasync(s);

%scrsz = get(groot,'ScreenSize');
scrsz=[1 1 1440 900];
text1posa=1320;
text1posb1=680;
text1posb2=510;
text1posb3=340;
text1posb4=210;
text12diff=30;

%figure and ui buttons
f=figure('Position',[1 scrsz(4)/1 scrsz(3)/1 scrsz(4)/1], 'Name', 'UPSat EPS Telemetry', 'NumberTitle', 'off');
btnstop=uicontrol('Style', 'pushbutton', 'String', 'Stop','Position', [50 20 50 20],'Callback', 'stop=stop+1;'); 
btnplus=uicontrol('Style', 'pushbutton', 'String', '+','Position', [50 50 20 20],'Callback', 'zoom=zoom/2;'); 
btnminus=uicontrol('Style', 'pushbutton', 'String', '-','Position', [80 50 20 20],'Callback', 'zoom=zoom*2;'); 
btnleft=uicontrol('Style', 'pushbutton', 'String', '<','Position', [50 80 20 20],'Callback', 'pan=pan+1;'); 
btnright=uicontrol('Style', 'pushbutton', 'String', '>','Position', [80 80 20 20],'Callback', 'pan=pan-1;'); 

%labels
txttit=uicontrol('Style','text', 'Position',[625 750 190 20],'String','EPS TELEMETRY','FontSize',20, 'FontWeight', 'Bold', 'ForegroundColor', 'red');
txttit1=uicontrol('Style','text', 'Position',[text1posa text1posb1 30 15],'String','Vpv1: ');
txttit2=uicontrol('Style','text', 'Position',[text1posa text1posb1-20 30 15],'String','Vpv2: ');
txttit3=uicontrol('Style','text', 'Position',[text1posa text1posb1-40 30 15],'String','Vpv3: ');
txttit4=uicontrol('Style','text', 'Position',[text1posa text1posb1-60 30 15],'String','Vpv4: ');
txttit5=uicontrol('Style','text', 'Position',[text1posa text1posb2 30 15],'String','Ipv1: ');
txttit6=uicontrol('Style','text', 'Position',[text1posa text1posb2-20 30 15],'String','Ipv2: ');
txttit7=uicontrol('Style','text', 'Position',[text1posa text1posb2-40 30 15],'String','Ipv3: ');
txttit8=uicontrol('Style','text', 'Position',[text1posa text1posb2-60 30 15],'String','Ipv4: ');
txttit9=uicontrol('Style','text', 'Position',[text1posa text1posb3 30 15],'String','Ppv1: ');
txttit10=uicontrol('Style','text', 'Position',[text1posa text1posb3-20 30 15],'String','Ppv2: ');
txttit11=uicontrol('Style','text', 'Position',[text1posa text1posb3-40 30 15],'String','Ppv3: ');
txttit12=uicontrol('Style','text', 'Position',[text1posa text1posb3-60 30 15],'String','Ppv4: ');
txttit131=uicontrol('Style','text', 'Position',[text1posa text1posb4 30 15],'String','Ibat+: ');
txttit132=uicontrol('Style','text', 'Position',[text1posa text1posb4-20 30 15],'String','Ibat-: ');
txttit13=uicontrol('Style','text', 'Position',[text1posa text1posb4-40 30 15],'String','Ibat: ');
txttit14=uicontrol('Style','text', 'Position',[text1posa text1posb4-60 30 15],'String','Vbat: ');
txttit15=uicontrol('Style','text', 'Position',[text1posa text1posb4-80 30 15],'String','I3.3V: ');
txttit16=uicontrol('Style','text', 'Position',[text1posa text1posb4-100 30 15],'String','I5V: ');
txttit17=uicontrol('Style','text', 'Position',[text1posa text1posb4-120 40 15],'String','Temp1:');
txttit18=uicontrol('Style','text', 'Position',[text1posa text1posb4-140 40 15],'String','Temp2:');

%values
txtmes1=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb1 30 15],'String','0000');
txtmes2=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb1-20 30 15],'String','0000');
txtmes3=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb1-40 30 15],'String','0000');
txtmes4=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb1-60 30 15],'String','0000');
txtmes5=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb2 30 15],'String','0000');
txtmes6=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb2-20 30 15],'String','0000');
txtmes7=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb2-40 30 15],'String','0000');
txtmes8=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb2-60 30 15],'String','0000');
txtmes9=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb3 30 15],'String','0000');
txtmes10=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb3-20 30 15],'String','0000');
txtmes11=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb3-40 30 15],'String','0000');
txtmes12=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb3-60 30 15],'String','0000');
txtmes131=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4 30 15],'String','0000');
txtmes132=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-20 30 15],'String','0000');
txtmes13=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-40 30 15],'String','0000');
txtmes14=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-60 30 15],'String','0000');
txtmes15=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-80 30 15],'String','0000');
txtmes16=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-100 30 15],'String','0000');
txtmes17=uicontrol('Style','text', 'Position',[text1posa+text12diff+10 text1posb4-120 40 15],'String','-127', 'HorizontalAlignment', 'left');
txtmes18=uicontrol('Style','text', 'Position',[text1posa+text12diff+10 text1posb4-140 40 15],'String','-127', 'HorizontalAlignment', 'left');

im=imread('UPSat_im.png'); %logo
axes('position',[0.005 0.15 0.1 0.1])
imshow(im);

txtstring=uicontrol('Style','text', 'Position',[600 20 600 15],'string',data, 'HorizontalAlignment', 'left');
txtstringtitle=uicontrol('Style','text', 'Position',[550 20 50 15],'string','raw data:', 'HorizontalAlignment', 'left');
starttimetitle=uicontrol('Style','text', 'Position',[1000 40 50 15],'string','Start time:', 'HorizontalAlignment', 'left');
starttimedata=uicontrol('Style','text', 'Position',[1050 40 650 15],'string',sprintf('%2d/%2d/%4d %2d:%02d:%02d', starttime(3), starttime(2), starttime(1), starttime(4), starttime(5), floor(starttime(6))), 'HorizontalAlignment', 'left');
samplestitle=uicontrol('Style','text', 'Position',[1200 40 50 15],'string','Samples:', 'HorizontalAlignment', 'left');
samplesdata=uicontrol('Style','text', 'Position',[1250 40 50 15],'string','0', 'HorizontalAlignment', 'left');

while (stop<3)
if (stop<1)
   %data=(fscanf(s)); %SERIAL
   data = '1210;1985;1955;400;500;600;700;300;0;399;8000;300;500;25;25'; %DEBUG
   txtstring.String=data;
   dataarray=strsplit(data,';');
   data1=str2double(cell2mat(dataarray(1,1)));
   data2=str2double(cell2mat(dataarray(1,2)));
   data3=str2double(cell2mat(dataarray(1,3)));
   data4=str2double(cell2mat(dataarray(1,4)));
   data5=str2double(cell2mat(dataarray(1,5)));
   data6=str2double(cell2mat(dataarray(1,6)));
   data7=str2double(cell2mat(dataarray(1,7)));
   data8=str2double(cell2mat(dataarray(1,8)));
   data131=str2double(cell2mat(dataarray(1,9)));
   data132=str2double(cell2mat(dataarray(1,10)));
   data13=data131-data132;
   data14=str2double(cell2mat(dataarray(1,11)));
   data15=str2double(cell2mat(dataarray(1,12)));
   data16=str2double(cell2mat(dataarray(1,13)));
   data17=str2double(cell2mat(dataarray(1,14)));
   data18=str2double(cell2mat(dataarray(1,15))); 
   
   % Power Calculation %
   data9=data1*data5/1000;
   data10=data2*data6/1000;
   data11=data3*data7/1000;
   data12=data4*data8/1000;
   
   t = t + step;
   mes1=[mes1,data1];
   mes2=[mes2,data2];
   mes3=[mes3,data3];
   mes4=[mes4,data4];
   mes5=[mes5,data5];
   mes6=[mes6,data6];
   mes7=[mes7,data7];
   mes8=[mes8,data8];
   mes9=[mes9,data9];
   mes10=[mes10,data10];
   mes11=[mes11,data11];
   mes12=[mes12,data12];
   mes131=[mes131,data131];
   mes132=[mes132,data132];
   mes13=[mes13,data13];
   mes14=[mes14,data14];
   mes15=[mes15,data15];
   mes16=[mes16,data16];
   mes17=[mes17,data17];
   mes18=[mes18,data18];
   samples=samples+1;
   samplesdata.String=int2str(samples);
   
end
% X-Axis Calculation %
   if ((t/step)-10 < 0) startSpot = 0;
   else startSpot = (t/step)-10;
   end
   
   startValue=(startSpot-pan*3);
   endValue=(t/step+3-pan*3);
   diffstartend=endValue-startValue;
   startValuetemp=endValue-diffstartend*zoom;
   if (startValuetemp<endValue) startValue=startValuetemp; end
   
   %Vpv1%
   subplot(subplotx,subploty,1) 
   plot(mes1,linestyle)
   axis([ startValue, endValue, 0 , 4000 ]);
   title('PV1 voltage');
   ylabel('[mV]');
   grid
   txtmes1.String=int2str(data1);
   %Vpv2%     
   subplot(subplotx,subploty,2)
   plot(mes2,linestyle) ;
   axis([ startValue, endValue, 0 , 4000 ]);
   title('PV2 voltage');
   ylabel('[mV]');
   grid   
   txtmes2.String=int2str(data2);
   %Vpv3%  
   subplot(subplotx,subploty,3) 
   plot(mes3,linestyle)
   axis([ startValue, endValue, 0 , 4000 ]);
   title('PV3 voltage');
   ylabel('[mV]');
   grid   
   txtmes3.String=int2str(data3);
   %Vpv4%    
   subplot(subplotx,subploty,4)
   plot(mes4,linestyle) ;
   axis([ startValue, endValue, 0 , 4000 ]);
   title('PV4 voltage');
   ylabel('[mV]');
   grid
   txtmes4.String=int2str(data4);
   %Ipv1%
   subplot(subplotx,subploty,5) 
   plot(mes5,linestyle)
   axis([ startValue, endValue, 0 , 1000 ]);
   title('PV1 current');
   ylabel('[mA]');
   grid 
   txtmes5.String=int2str(data5);
   %Ipv2%     
   subplot(subplotx,subploty,6)
   plot(mes6,linestyle) ;
   axis([ startValue, endValue, 0 , 1000 ]);
   title('PV2 current');
   ylabel('[mA]');
   grid   
   txtmes6.String=int2str(data6);
   %Ipv3%  
   subplot(subplotx,subploty,7) 
   plot(mes7,linestyle)
   axis([ startValue, endValue, 0 , 1000 ]);
   title('PV3 current');
   ylabel('[mA]');
   grid   
   txtmes7.String=int2str(data7);
   %Ipv4%     
   subplot(subplotx,subploty,8)
   plot(mes8,linestyle) ;
   axis([ startValue, endValue, 0 , 1000 ]);
   title('PV4 current');
   ylabel('[mA]');
   grid
   txtmes8.String=int2str(data8);
   %Ppv1%
   subplot(subplotx,subploty,9) 
   plot(mes9,linestyle)
   axis([ startValue, endValue, 0 , 3000 ]);
   title('PV1 power');
   ylabel('[mW]');
   grid  
   txtmes9.String=int2str(data9);
   %Ppv2%     
   subplot(subplotx,subploty,10)
   plot(mes10,linestyle) ;
   axis([ startValue, endValue, 0 , 3000 ]);
   title('PV2 power');
   ylabel('[mW]');
   grid 
   txtmes10.String=int2str(data10);
   %Ppv3%  
   subplot(subplotx,subploty,11) 
   plot(mes11,linestyle)
   axis([ startValue, endValue, 0 , 3000 ]);
   title('PV3 power');
   ylabel('[mW]');
   grid  
   txtmes11.String=int2str(data11);
   %Ppv4%     
   subplot(subplotx,subploty,12)
   plot(mes12,linestyle) ;
   axis([ startValue, endValue, 0 , 3000 ]);
   title('PV4 power');
   ylabel('[mW]');
   grid
   txtmes12.String=int2str(data12);
   %Ibat%
   subplot(subplotx,subploty,13) 
   plot(mes13,linestyle)
   axis([ startValue, endValue, -2000 , 2000 ]);
   title('Battery current');
   ylabel('[mA]');
   grid
   txtmes131.String=int2str(data131);
   txtmes132.String=int2str(data132);
   txtmes13.String=int2str(data13);
   %Vbat%     
   subplot(subplotx,subploty,14)
   plot(mes14,linestyle) ;
   axis([ startValue, endValue, 4000 , 13000 ]);
   title('Battery voltage');
   ylabel('[mV]');
   grid   
   txtmes14.String=int2str(data14);
   %I3.3%  
   subplot(subplotx,subploty,15) 
   plot(mes15,linestyle)
   axis([ startValue, endValue, 0 , 1000 ]);
   title('3.3V rail current');
   ylabel('[mA]');
   grid   
   txtmes15.String=int2str(data15);
   %I5%     
   subplot(subplotx,subploty,16)
   plot(mes16,linestyle) ;
   axis([ startValue, endValue, 0 , 1000 ]);
   title('5V rail current');
   ylabel('[mA]');
   grid
   txtmes16.String=int2str(data16);
   %Temp%   
   txtmes17.String=int2str(data17);
   txtmes18.String=int2str(data18);
   
   drawnow;

if (stop==1)
%fclose(s); //SERIAL
stop=2;
btnstop.String='Exit';
stoptime=clock;
stoptimetitle=uicontrol('Style','text', 'Position',[1000 20 50 15],'string','Stop time:', 'HorizontalAlignment', 'left');
stoptimedata=uicontrol('Style','text', 'Position',[1050 20 650 15],'string',sprintf('%2d/%2d/%4d %2d:%02d:%02d', stoptime(3), stoptime(2), stoptime(1), stoptime(4), stoptime(5), floor(stoptime(6))), 'HorizontalAlignment', 'left');


end
end
close(f); %close figure
%save measurement table in workspace
measurements=[mes1;mes2;mes3;mes4;mes5;mes6;mes7;mes8;mes9;mes10;mes11;mes12;mes131;mes132;mes13;mes14;mes15;mes16;mes17;mes18];
clearvars btnminus btnright btnleft btnplus btnstop data data1 data10 data11 data12 data13 data14 data15 data16 data17 data18 data2 data3 data4 data5 data6 data7 data8 data9 dataarray endValue f im linestyle mes1 mes10 mes11 mes12 mes13 mes14 mes15 mes16 mes2 mes3 mes4 mes5 mes6 mes7 mes8 mes9 pan scrsz startSpot startValue step stop subplotx subploty t text12diff text1posa text1posb1 text1posb2 text1posb3 text1posb4 txtmes1 txtmes10 txtmes11 txtmes12 txtmes13 txtmes14 txtmes15 txtmes16 txtmes17 txtmes18 txtmes2 txtmes3 txtmes4 txtmes5 txtmes6 txtmes7 txtmes8 txtmes9 txtstring txtstringtitle txttit txttit1 txttit10 txttit11 txttit12 txttit13 txttit14 txttit15 txttit16 txttit17 txttit18 txttit2 txttit3 txttit4 txttit5 txttit6 txttit7 txttit8 txttit9 zoom diffstartend startValuetemp mes17 mes18 data131 data132 mes131 mes132 txtmes131 txtmes132 txttit131 txttit132 samples samplesdata samplestitle starttime starttimedata starttimetitle stoptime stoptimetitle stoptimedata