%%
%%---------------Graficador de tablas EXCEL ---------------%%


a=1*(cos(2/3*pi)+1i*sin(2/3*pi));


%%------- i = filas
%%------- j = columnas

j=1;
i=1;



%%-------- x = factor de potencia; y = factor de carga[%]
x = [0.8 0.85 0.9 0.95 1];
y = [50 60 70 80 90 100];



m = sano;     %-- Fase y severidad de falla
k = 0;        %-- auxiliar graficas cartesianas (0:sin falla; 1:0.1 pu; 2:0.2 pu; 3:0.3 pu; 4:0.4 pu)
p = 1;        %-- 

    

while j<=13   % 13 para tabla completa -- 4 para tabla resumida
  
i=1;
while i<=16  %-- 16 para tabla completa -- 7 para tabla resumida



Ra = m(i,j);
Rb = m(i+1,j);
Rc = m(i+2,j);

Xa = m(i,j+1);
Xb = m(i+1,j+1);
Xc = m(i+2,j+1);

Za = m(i,j+2);
Zb = m(i+1,j+2);
Zc = m(i+2,j+2);


indicador = complex(Za)+Zb*a^2+Zc*a;


%---- Calculo en pu -- se corrige el 0 y se divide por la R mas baja


Za = complex(Za);
Zb = Zb*a^2;
Zc = Zc*a;




if exist('PROM')
    
    V = [abs(Za-PROM),abs(Zb-PROM),abs(Zc-PROM)];

    Zmin = min(V);

    indicador = (Za+Zb+Zc-PROM)/Zmin;
 
else

end



%----






%%
%------------------------------- Graficos --------------------------------%

   
    
 %------ Modulo/Angulo   
    
figure(4)                     %--------------------------- POLAR SCATTER Z

    plot(k,abs(indicador),'k-o')
    hold on
    xticks([0 1 2 3 4 5])
    xticklabels({'Sin falla','Caso 1','Caso 2','Caso 3','Caso 4','Caso 5'})
    

figure(5)                     %--------------------------- POLAR SCATTER R

    plot(k,angle(indicador)*180/pi(),'k-o')
    hold on
    xticks([0 1 2 3 4 5])
    xticklabels({'Sin falla','Caso 1','Caso 2','Caso 3','Caso 4','Caso 5'})


    
  




i=i+3;
fil=fil+1;

end
p=p+1;
j=j+3;
col=col+1;

end

if exist('REF')
else
    REF = AUX;
    PROM = mean(REF,'all'); %-- Promedio de casos sanos para compensacion
end








