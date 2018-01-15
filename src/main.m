clc;
clear all;
close all;
input1 = videoinput('winvideo',1,'YUY2_320x240');
set(input1,'ReturnedColorSpace', 'rgb');
preview(input1);
pause(5);
data = getsnapshot(input1);
    closepreview(input1);
  diff_im = imsubtract(data(:,:,1), rgb2gray(data));
    diff_im = medfilt2(diff_im, [3 3]);
   diff_im = im2bw(diff_im,0.18);
   diff_im = bwareaopen(diff_im,300);
    bw = bwlabel(diff_im, 8);
   stats = regionprops(bw, 'BoundingBox');
   figure,imshow(data)
    hold on
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
     
   a=  rectangle('Position',bb,'EdgeColor','r','LineWidth',2);
    i1=imcrop(data,[16.5 2.5 290 238]);
    figure,imshow(i1) 
    end
    hold off
%text localization 
i1=rgb2gray(data);
se=strel('disk',1);
gi=imdilate(i1,se); 
% figure,imshow(gi)
m=imerode(gi,se);                                                                                                                                                                                                                                                                                                                                                                                                                                         
% figure,imshow(m)
gdiff=imsubtract(gi,m); 
% figure,imshow(gdiff)
gdiff=mat2gray(gdiff); 
% figure,imshow(gdiff)
gdiff=conv2(gdiff,[1 1;1 1]);
figure,imshow(gdiff)
gdiff=imadjust(gdiff,[0.5 0.7],[0 1],0.1);
figure,imshow(gdiff)
 B=logical(gdiff); 
 figure,imshow(B)
 F=imfill(B,'holes');
H=imerode(F,strel('line',3,90));
figure,imshow(H)
final=bwareaopen(F,100);
figure,imshow(final);
 out=fcm(final);
 figure,imshow(out,[])
 [m n]=size(out);
 for i=1:m;
     for j=1:n;
      if out(i,j)==2||out(i,j)==5
          new1(i,j)=1;
         else
           new1(i,j)=0;
        end
     end
 end
  figure,imshow(new1,[])
 e=imerode(new1,se);
 figure,imshow(e)
 cc=bwconncomp(e,4);
[cc1 nn]=bwlabel(e);
text(cc.PixelIdxList{5}) = true;
 textdata=regionprops(cc1,'basic');
gio1=zeros(m,n);
 for ii=1:length(textdata)
newn(ii,1)=(textdata(ii).Area);
end
for ii=1:length(newn)
    if newn(ii,1)>90 
    out=cc1==ii;
    gio1=gio1+out;
    end
end
figure,imshow(gio1,[])

% %feature extraction
 rp=robustltp(B);
 im=rp;
 im=sum(sum(im))/10000;
%  save b1 im3
 out=classify(im);
 if out==1
   warndlg('tide');
   tts(a1);
 elseif out==2
     warndlg('kitkat')
     tts('kitkat')
 elseif out==3
     msgbox('Others')
     tts('Others')
   end



