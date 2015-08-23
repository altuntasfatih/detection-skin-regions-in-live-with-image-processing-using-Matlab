
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program Name : Detection skin region in Live Video(Image Processing)                
% Author       : M.Fatih Altunta?                                             
% Description  : This program just tracks all skin region and finding
% boundary of skin.Then insert red line boundary of skin.
% rgb color spaced is used this program.there is two example in this file
% filtering example on rgb and hsv color space for acquire skin region in Live Video
%% Video :https://youtu.be/qj49c3DxFVg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hardwareInfo=imaqhwinfo; % Acquire input video propert 
memoryInfo=imaqmem; % Acquire memory info video stream
imaqmem(memoryInfo.AvailPhys); 
video = videoinput('macvideo', '1', 'YCbCr422_1280x720'); % % Acquire input video 
isRunning = 1;
set(video, 'FramesPerTrigger', Inf); % Acquire  frame contiously
set(video,  'ROI', [1 1 640 480]);% Set resolution return input video 
set(video, 'ReturnedColorspace', 'rgb'); % Set ReturnedColorspace  rgb
video.FrameGrabInterval = 7; % Specify how often to acquire frame from video stream
start(video); 
figure;
%Insert Button for terminating program
u=uicontrol('String','Stop','Callback','isRunning = 0; disp(''Program is Termited.'')','ForegroundColor','w','BackgroundColor','r','Fontsize',14,'FontWeight','Demi','Position',[1 1 60 60]);
set(u,'position',[1 1 20 20])
isRunning=1;
while(isRunning)
   data = getsnapshot(video); % Acquire single frame
   data = flipdim(data,2);% obtain the mirror image for displaying,
   imshow(data); 
   hold on
   w=data;
   a=w;
    %%% This region is filter for skin color
             [i,j,y] =find(w(:,:,1)>95 & w(:,:,2)>40 & w(:,:,1)>20 & w(:,:,1) >w(:,:,2) & w(:,:,1)>w(:,:,3) & abs(w(:,:,1)-w(:,:,2)) >15  & 0.36<=(double(w(:,:,1))./(double(w(:,:,1))+double(w(:,:,2))+double(w(:,:,3))))  & 0.465>=(double(w(:,:,1))./(double(w(:,:,1))+double (w(:,:,2))+double(w(:,:,3)))) & 0.28<=(double(w(:,:,2))./(double(w(:,:,1))+double(w(:,:,2))+double(w(:,:,3)))) & 0.363>=(double(w(:,:,2))./(double(w(:,:,1))+double(w(:,:,2))+double(w(:,:,3))))  ) ;

                a(:,:,1)=0;
                a(:,:,2)=0;
                a(:,:,3)=0;
                b=1;
                while b<=length(i);

                        R=double(w(i(b),j(b),1));
                        G=double(w(i(b),j(b),2));
                        B=double(w(i(b),j(b),3));

                         if(max([R;G;B])-min([R;G;B]) >15)
                             a(i(b),j(b),1)=R;
                             a(i(b),j(b),2)=G;
                             a(i(b),j(b),3)=B;
                         end
                    b=b+1;
                end
     %%%      
        I = rgb2gray(a);% Converting greyscale image
        threshold = graythresh(I);% Obtain trehshold valur for converting binary image
        bw = im2bw(I,threshold);% Converting binary image
        bw = bwareaopen(bw,250);%wiping white regions that is smal 50 pixels 
        se = strel('disk',5);
        bw = imclose(bw,se);%Morphologically close image
        bw = imfill(bw,'holes');%filing holes in image 
        
       [B,L] = bwboundaries(bw,'noholes');%finding white region in binary image and their boundaries
       for k = 1:length(B)
                
         boundary = int32(B{k});
         plot(boundary(:,2), boundary(:,1), 'r', 'Linewidth', 3)%nserting red line boundary of skin.
           
       end 
     hold off
     if mod(video.FramesAcquired,1000)==0 %stop  at 1000 frame 
        flushdata(video);
        stop(video);
        break;
    end
    
end
stop(video);
flushdata(video);
    