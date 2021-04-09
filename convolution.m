function result = convolution(A,B)

[M1 N1] = size(A);
[M2 N2] = size(B);

h = rot90(B, 2); %rotate matrix 90 degrees

ctr = floor((size(h)+1)/2);
left = ctr(2) - 1;
right = N2 - ctr(2);
top = ctr(1) - 1;
bottom = M2 - ctr(1);

temp = zeros(M1+top+bottom, N1+left+right);

for x = 1+top:M1+top
    for y = 1+left:N1+left
        temp(x,y) = A(x-top, y-left);
    end
end

result = zeros(M1,N1);
for x = 1:M1
    for y = 1:N1
        for i = 1:M2
            for j = 1:N2
                p1 = x-1;
                p2 = y-1;
                result(x,y) = result(x,y) + (temp(i+p1,j+p2) * h(i,j));
            end
        end
    end
end
end