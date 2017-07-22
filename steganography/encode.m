function success = encode(msg,key)
% ENCODE(msg,key) Encodes a text message using a key.
% This works by using the ascii number representation of the chars in
% KEY (and certain permutations) to create coordinate pairs that represent
% the places in matrix A (which is a submatrix of the pic matrix) where the
% unit alterations to the pic matrix will be made. I tried to make the
% code easy to follow, but I will respond to questions about how this
% works.
num2add = 1000-length(msg); % Number of spaces to add to end of MSG.
if num2add < 0, error('This message is too long to encode.'), end
newmsg = [msg,repmat(' ',1,num2add)]; % 1000 chars always encoded.
msgmat = dec2bin(newmsg)-48; % Each row is a bin. rep. of an ascii char.
[filen pth]=uigetfile({'*.bmp';'*.tif';'*.jpg'},'Choose Image To Encode.');
if isequal(filen,0) || isequal(pth,0)
success = []; return % User cancelled.
end
pic1 = imread([pth filen]);
B = pic1(:,:,1); [piclngth pichght] = size(B); % Choose the first page.
dim1 = piclngth-2; dim2 = pichght-3; keyb = key(end:-1:1);
rows = cumsum(double(key));
columns = cumsum(double(keyb)); % Coord pairs for KEY (rows,columns)
A = zeros(dim1,dim2); % This matrix will house the hiding points.
A = crtmtrx(A,rows,columns,dim1,dim2,key);
idx = find(A==1); % This same index will be used for pic matrix.
for vv = 1:1000 % This is the encoder.
for uu = 1:7
if msgmat(vv,uu)==1;
if rem(B(idx(uu+7*(vv-1))),2)==0
B(idx(uu+7*(vv-1))) = B(idx(uu+7*(vv-1)))+1;
end
elseif rem(B(idx(uu+7*(vv-1))),2)==1
B(idx(uu+7*(vv-1))) = B(idx(uu+7*(vv-1)))-1;
end
end
end
newpic = pic1; newpic(:,:,1) = B;
[filen pth] = uiputfile({'*.bmp';'*.tif'},'Save Encoded File As');
if isequal(filen,0) || isequal(pth,0)
success = []; return
end % User cancelled.
imwrite(newpic,[pth filen])
success = 1;