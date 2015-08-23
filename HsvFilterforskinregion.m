%{
for skin regions in Hsv

** 0>=H>=50, O.2>=S>=0.68 and 0.35V>=1

%}



filename=input('enter file name for image: ')

rgbimage=imread(filename);%%Rgb image 
hsvimage = rgb2hsv(rgbimage);%%Convert RGB colormap to HSV colormap 
[r c b]=size(hsvimage);



for i=1 : r

    for j=1:c
        
         H=double(hsvimage(i,j,1));%The hue
        S=double(hsvimage(i,j,2));%Saturtation
        V=double(hsvimage(i,j,3));%Brightness
     
       if(H>=0 && H<=50 && S>=0.2 && S<=0.68 && V>=0.35 && V<=1)
           %%This pixels is will be skin 
       else
             hsvimage(i,j,:)=0;                %%This pixels is not skin 
       end
    end


end
rgb_image = hsv2rgb(hsvimage); %%Convert HSV colormap to RGB colormap for showing in sceene
imshow(rgb_image);
