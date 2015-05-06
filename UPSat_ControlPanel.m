close all

t = 0 ;
x = 0 ;
stop=0;
linestyle='-r.';
subplotx=4;
subploty=4;

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
mes13=0;
mes14=0;
mes15=0;
mes16=0;
%s = serial('/dev/tty.usbmodemfd121');
%s=serial('/dev/tty.usbmodemfa131')

%fopen(s);
startSpot = 0;
interv = 100 ; % considering 1000 samples
step = 1 ; % lowering step has a number of cycles and then acquire more data

scrsz = get(groot,'ScreenSize');
text1posa=1320;
text1posb1=680;
text1posb2=510;
text1posb3=340;
text1posb4=190;
text12diff=30;
f=figure('Position',[1 scrsz(4)/1 scrsz(3)/1 scrsz(4)/1], 'Name', 'UPSat EPS Telemetry', 'NumberTitle', 'off');
btn=uicontrol('Style', 'pushbutton', 'String', 'Stop','Position', [20 20 50 20],'Callback', 'stop=1;'); 

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
txttit13=uicontrol('Style','text', 'Position',[text1posa text1posb4 30 15],'String','Ibat: ');
txttit14=uicontrol('Style','text', 'Position',[text1posa text1posb4-20 30 15],'String','Vbat: ');
txttit15=uicontrol('Style','text', 'Position',[text1posa text1posb4-40 30 15],'String','I3.3V: ');
txttit16=uicontrol('Style','text', 'Position',[text1posa text1posb4-60 30 15],'String','I5V: ');
txttit17=uicontrol('Style','text', 'Position',[text1posa text1posb4-80 40 15],'String','Temp1: ');
txttit18=uicontrol('Style','text', 'Position',[text1posa text1posb4-100 40 15],'String','Temp2: ');

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
txtmes13=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4 30 15],'String','0000');
txtmes14=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-20 30 15],'String','0000');
txtmes15=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-40 30 15],'String','0000');
txtmes16=uicontrol('Style','text', 'Position',[text1posa+text12diff text1posb4-60 30 15],'String','0000');
txtmes17=uicontrol('Style','text', 'Position',[text1posa+text12diff+10 text1posb4-80 40 15],'String','-127');
txtmes18=uicontrol('Style','text', 'Position',[text1posa+text12diff+10 text1posb4-100 40 15],'String','-127');

%while ( t <interv )
while (stop<1)
    %readasync(s);
    %b=(fscanf(s));
   data1=500+500*sin(t);
   data2=100+100*sin(t);
   data3=500+500*sin(t);
   data4=100+100*sin(t);
   data5=500+500*sin(t);
   data6=100+100*sin(t);
   data7=500+500*sin(t);
   data8=100+100*sin(t);
   data13=500+500*sin(t);
   data14=100+100*sin(t);
   data15=500+500*sin(t);
   data16=100+100*sin(t);
   data17=-100;
   data18=-100;
   
   
   
   
   
   data9=data1*data5/1000;
   data10=data2*data6/1000;
   data11=data3*data7/1000;
   data12=data4*data8/1000;
   if ((t/step)-500 < 0)
          startSpot = 0;
      else
          startSpot = (t/step)-500;
      end
      
   subplot(subplotx,subploty,1) 
   mes1=[mes1,data1];
   plot(mes1,linestyle)
   axis([ startSpot, (t/step+50), 0 , 4000 ]);
   title('PV1 voltage');
   ylabel('[mV]');
   grid
   txtmes1.String=int2str(data1);
        
   subplot(subplotx,subploty,2)
   mes2=[mes2,data2];
   plot(mes2,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 4000 ]);
   title('PV2 voltage');
   ylabel('[mV]');
   grid   
   txtmes2.String=int2str(data2);
     
   subplot(subplotx,subploty,3) 
   mes3=[mes3,data3];
   plot(mes3,linestyle)
   axis([ startSpot, (t/step+50), 0 , 4000 ]);
   title('PV3 voltage');
   ylabel('[mV]');
   grid   
   txtmes3.String=int2str(data3);
       
   subplot(subplotx,subploty,4)
   mes4=[mes4,data4];
   plot(mes4,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 4000 ]);
   title('PV4 voltage');
   ylabel('[mV]');
   grid
   txtmes4.String=int2str(data4);
   
   subplot(subplotx,subploty,5) 
   mes5=[mes5,data5];
   plot(mes5,linestyle)
   axis([ startSpot, (t/step+50), 0 , 1000 ]);
   title('PV1 current');
   ylabel('[mA]');
   grid 
   txtmes5.String=int2str(data5);
        
   subplot(subplotx,subploty,6)
   mes6=[mes6,data6];
   plot(mes6,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 1000 ]);
   title('PV2 current');
   ylabel('[mA]');
   grid   
   txtmes6.String=int2str(data6);
     
   subplot(subplotx,subploty,7) 
   mes7=[mes7,data7];
   plot(mes7,linestyle)
   axis([ startSpot, (t/step+50), 0 , 1000 ]);
   title('PV3 current');
   ylabel('[mA]');
   grid   
   txtmes7.String=int2str(data7);
        
   subplot(subplotx,subploty,8)
   mes8=[mes8,data8];
   plot(mes8,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 1000 ]);
   title('PV4 current');
   ylabel('[mA]');
   grid
   txtmes8.String=int2str(data8);
   
   subplot(subplotx,subploty,9) 
   mes9=[mes9,data9];
   plot(mes9,linestyle)
   axis([ startSpot, (t/step+50), 0 , 3000 ]);
   title('PV1 power');
   ylabel('[mW]');
   grid  
   txtmes9.String=int2str(data9);
        
   subplot(subplotx,subploty,10)
   mes10=[mes10,data10];
   plot(mes10,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 3000 ]);
   title('PV2 power');
   ylabel('[mW]');
   grid 
   txtmes10.String=int2str(data10);
     
   subplot(subplotx,subploty,11) 
   mes11=[mes11,data11];
   plot(mes11,linestyle)
   axis([ startSpot, (t/step+50), 0 , 3000 ]);
   title('PV3 power');
   ylabel('[mW]');
   grid  
   txtmes11.String=int2str(data11);
        
   subplot(subplotx,subploty,12)
   mes12=[mes12,data12];
   plot(mes12,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 3000 ]);
   title('PV4 power');
   ylabel('[mW]');
   grid
   txtmes12.String=int2str(data12);
   
   subplot(subplotx,subploty,13) 
   mes13=[mes13,data13];
   plot(mes13,linestyle)
   axis([ startSpot, (t/step+50), -2000 , 2000 ]);
   title('Battery current');
   ylabel('[mA]');
   grid   
   txtmes13.String=int2str(data13);
        
   subplot(subplotx,subploty,14)
   mes14=[mes14,data14];
   plot(mes14,linestyle) ;
   axis([ startSpot, (t/step+50), 4000 , 13000 ]);
   title('Battery voltage');
   ylabel('[mV]');
   grid   
   txtmes14.String=int2str(data14);
     
   subplot(subplotx,subploty,15) 
   mes15=[mes15,data15];
   plot(mes15,linestyle)
   axis([ startSpot, (t/step+50), 0 , 1000 ]);
   title('3.3V rail current');
   ylabel('[mA]');
   grid   
   txtmes15.String=int2str(data15);
        
   subplot(subplotx,subploty,16)
   mes16=[mes16,data16];
   plot(mes16,linestyle) ;
   axis([ startSpot, (t/step+50), 0 , 1000 ]);
   title('5V rail current');
   ylabel('[mA]');
   grid
   txtmes16.String=int2str(data16);
      
   
   txtmes17.String=int2str(data17);
   txtmes18.String=int2str(data18);
   t = t + step;
   drawnow;
end

%fclose(s);

