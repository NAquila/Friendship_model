function C = ClustCoeff(A)

Cubed_adjecentcy = A^3;

No_Triangles = trace(Cubed_adjecentcy)/2; %nnz(Cubed_adjecentcy == 3)

k = sum(A,2);
No_Triplets = sum(k.*(k-1))/2;

C = No_Triangles/No_Triplets;