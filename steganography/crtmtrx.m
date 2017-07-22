function A = crtmtrx(A,rows,columns,dim1,dim2,key)
% Creates the matrix used to find the points to hide the message.
jj = 1; idx = 1;
while 7000 > length(idx) % Need 7000 points to hide 1000 characters.
for ii = 1:length(rows)
if rows(ii) < dim1
rows(ii) = rem(dim1,rows(ii))+1;
else
rows(ii) = rem(rows(ii),dim1)+1;
end
if columns(ii) < dim2
columns(ii) = rem(dim2,columns(ii))+1;
else
columns(ii) = rem(columns(ii),dim2)+1;
end
A(rows(ii),columns(ii)) = 1;
end
rows = jj*cumsum(double(columns))+round(dim2/2); % Each pass is diff.
columns = jj*cumsum(double(rows))+round(dim1/2);
if jj > ceil(7000/length(key))+2 % Estimate how many iters. needed.
idx = find(A==1);
end
jj = jj+1;
end