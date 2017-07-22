function msg = decode(key)
% DECODE(key) Decodes the message hidden by encode in pic, using key.
[filen pth] = uigetfile({'*.bmp';'*.tif'},'Choose Image To Decode.');
if isequal(filen,0) || isequal(pth,0)
msg = []; return
end % User cancelled.
pic2 = imread([pth filen]);
B = pic2(:,:,1); [piclngth pichght] = size(B); % Choose the top page.
dim1 = piclngth-2; dim2 = pichght-3; keyb = key(end:-1:1);
rows = cumsum(double(key)); columns = cumsum(double(keyb));
A = zeros(dim1,dim2); % This matrix houses the hiding points.
A = crtmtrx(A,rows,columns,dim1,dim2,key);
idx = find(A==1); msgmat = zeros(1000,7);
for vv = 1:1000 % This is the decoder.
for uu = 1:7
if rem(B(idx(uu+7*(vv-1))),2)==1
msgmat(vv,uu) = 1;
end
end
end
msg = char(bin2dec(num2str(msgmat)))';