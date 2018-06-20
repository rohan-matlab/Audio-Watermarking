clc;
close all;
[Y1,fs,nbits]=wavread('embeded_signal.wav');%read wav file
Y2=fftshift(fft(Y1));
Y=Y2(:,1);%using only one channel for detection
p=500;%width of band
q=length(Y)/2+1;%point of zero frequency
frame=50;
d=10;
a=0.1;
Y3=abs(Y);
X1=Y3((q-5000-(p)):(q-5001));%portion of signal to be detected for watermark
x1=vec2mat(X1,d);%convert row vector to 50*10 matrix

for k=1:frame%k runs over each frame
   avg=0; 
   b=0;
   c=0;
        for l=1:d
         avg=avg+x1(k,l);
        end
        avg=avg/d;
        for l=1:d/2 %checking first half of frame
            if(x1(k,l)>=(1+a)*avg/2)
              c=c+1;%increment c if 0 is embeded
            else 
               b=b+1;%increment b if 1 is embeded
            end
        end
         for l=d/2+1:d %checking second half of frame 
             if(x1(k,l)<(3-a)*avg/2)
                 c=c+1;%increment c if 0 is embeded
             else
                 b=b+1;%increment b if 1 is embeded
             end
         end
            if(b>c)
                A(k)=1;
            else
                A(k)=0;
            end
end

    display(A);       %recovered signal     
           