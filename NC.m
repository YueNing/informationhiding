%input(­ìmark¡A¨úmark)
function output=NC(or_mark,re_mark)
[N,M]=size(or_mark);
temp1=0;
temp2=0;
for i=1:N
    for j=1:M
        temp1=temp1+or_mark(i,j)*re_mark(i,j);
        temp2=temp2+or_mark(i,j)^2;
    end
end
output=temp1/temp2;%¿é¥XNC­È
