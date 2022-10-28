clc
clear




%Datos de entrada
theta = deg2rad(input('Introduce el angulo de lanzamiento: ')); %grados deg a radianes 61
vo = input('Introduce la velocidad inicial del disparo: '); %180
b = input('Introduce la resistencia al aire: '); %coeficiente de viscosidad
pps = input('Introduce pps (puntos por segundo): '); %Puntos por segundo. Mientras mas pps, mas precision de datos,
%                         pero menos preciso el tiempo.

%Valores que quedaran constantes en ambos casos
g = 9.8;
vox = vo.*cos(theta); %Velocidad inicial en x
voy = vo.*sin(theta);

spd = 1; %Para apresurar el codigo

grid on

%Sin resisistencia al aire
t=0;
dt=1./pps;
while 1
    
    vy = (voy) - (g.*t);
    vx = vox;
    
    x = vox.*t;
    y = voy.*t - (0.5.*g.*(t.^2));

    if y<0
        break
    end
    
    hold on;
    plot(x,y,'o','Color',[0 0 1]);
    fprintf('theta: %f vo: %f x: %f y: %f vx: %f vy: %f t: %f \n',theta,vo,x,y,vx,vy,t)

    t = t + dt;
    pause(dt./spd);

end

input('Presiona enter para continuar...')

%Reiniciando valores
x = 0;
y = 0;
vy = 0;
vx = 0;
t=0;

%Con resistencia al aire
while 1
    
    vx = vox.*exp(-b.*t);
    vy = (((g./b)+voy).*exp(-b.*t))-(g./b);

    x = (vox./b).*(1-exp(-b.*t));
    y = (1./b).*((g./b)+voy).*(1-exp(-b.*t))-((g.*t)./b); %Se sacan las 2 ecuaciones de pocision
        
    if y<0 || isnan(y)
        break
    end
    
    hold on;
    plot(x,y,'o','Color',[1 0 0]);
    fprintf('theta: %f vo: %f x: %f y: %f vx: %f vy: %f t: %f \n',theta,vo,x,y,vx,vy,t)
    

    t = t + dt;
    pause(dt./spd);

end