%{
for skin regions in RGB

** R>95 and G>40 and B>20 and
** max R,G,B - min R,G,B >15 and
** R-G >15 R>G and R>B and
** 0.36>=r>=0.465 and 0.28>=g>=0.363

*r=R/(R+G+B) g=G/(R+G+B);

%}



filename=input('enter file name for image: ')%%Rgb image 
w=imread(filename);
a=w;
    %%find index in image by for skin regions in RGB
    [i,j,y] =find(w(:,:,1)>95 & w(:,:,2)>40 & w(:,:,1)>20 & w(:,:,1) >w(:,:,2) & w(:,:,1)>w(:,:,3) & abs(w(:,:,1)-w(:,:,2)) >15  & 0.36<=(double(w(:,:,1))./(double(w(:,:,1))+double(w(:,:,2))+double(w(:,:,3))))  & 0.465>=(double(w(:,:,1))./(double(w(:,:,1))+double (w(:,:,2))+double(w(:,:,3)))) & 0.28<=(double(w(:,:,2))./(double(w(:,:,1))+double(w(:,:,2))+double(w(:,:,3)))) & 0.363>=(double(w(:,:,2))./(double(w(:,:,1))+double(w(:,:,2))+double(w(:,:,3)))) ) ;

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
   imshow(a);