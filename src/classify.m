function out=classify(n)
t=abs(fft(n));
tr=mean(abs(t));
load tide
 load k1
% load milk
% load fing4
%  load fing5
im1=sum(sum(im1));
 im2=sum(sum(im2));
%  im3=sum(sum(im3));
% im4=sum(sum(im4));
% im5=sum(sum(im5));
% im5=sum(sum(im5));
% if tr>3.5 && tr <5.0
error(1)=mean(abs(im1-t));
 error(2)=mean(abs(im2-t));
% error(3)=mean(abs(im3-t));
% error(4)=mean(abs(im4-t));
% error(5)=mean(abs(im5-t));

min_error=min(error);
display(error)
disp(min_error)
if min_error>15
    out=3;
elseif (min_error==error(2))
  out=2;
% elseif (min_error==error(3))
%   out=3;
% elseif (min_error==error(4))
%   out=4;
%  elseif (min_error==error(5))
%    out=5;
% end
% else
%     warndlg('Not Authenticated')
elseif (min_error==error(1))
    out=1;
end

