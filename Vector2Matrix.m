function A=Vector2Matrix(oi,row)
%将数组转换成二位数组,row为行数
cl=length(oi)/row;
A=zeros(row,cl);
for i=1:row
    for j=1:cl
        A(i,j)=oi(cl*(i-1)+j);
    end
end