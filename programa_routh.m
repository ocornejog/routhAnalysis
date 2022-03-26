clc
clear
r=input('Ingrese el vector de los coeficientes del sistema: ');
m=length(r);
n=round(m/2);
q=1;
k=0;
for p=1:length(r)
    if rem(p,2)==0
        c_even(k)=r(p);
    else
        c_odd(q)=r(p);
        k=k+1;
        q=q+1;
    end
end
Tabla=zeros(m,n);
if m/2 ~= round(m/2)
    c_even(n)=0;
end
Tabla(1,:)=c_odd;
Tabla(2,:)=c_even;
if Tabla(2,1)==0
    Tabla(2,1)=0.01;
end
for i=3:m
    for j=1:n-1
        x=Tabla(i-1,1);
        if x==0
            x=0.01;
        end
        Tabla(i,j)=((Tabla(i-1,1)*Tabla(i-2,j+1))-(Tabla(i-2,1)*Tabla(i-1,j+1)))/x;
    end
    if Tabla(i,:)==0
        order=(m-i+1);
        c=0;
        d=1;
        for j=1:n-1
             Tabla(i,j)=(order-c)*(Tabla(i-1,d));
             d=d+1;
             c=c+2;
        end
    end
    if Tabla(i,1)==0
        Tabla(i,1)=0.01;
    end
end
Right_poles=0;
for i=1:m-1
    if sign(Tabla(i,1))*sign(Tabla(i+1,1))==-1
        Right_poles=Right_poles+1;
    end
end
fprintf('\n Tabla de Routh:\n')
Tabla
fprintf('\n Numero de polos en el semiplano derecho = %2.0f \n',Right_poles)
reply = input('¿Necesita las raices del sistema? Y (Yes) or N (No)\n','s');
if reply=='y'||reply=='Y'
    RAICES=roots(r);
    fprintf('\nRaices del polinomio de coeficientes:\n')
    RAICES
else
end