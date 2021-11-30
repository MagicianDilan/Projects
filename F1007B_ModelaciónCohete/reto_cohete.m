clear all
x(1)=0;   % posición inicial x [unidades m]
y(1)=0;   % posición inicial y [unidades m]
ang(1)=0;   % ángulo de salida [unidades grados]

vo=65;                   % velocidad inicial de contenedor [unidades m/s]
vx(1)=vo*cosd(ang(1));   % velocidad inicial en x  [unidades m/s]
vy(1)=vo*sind(ang(1));   % velocidad inicial en y  [unidades m/s]
Vw=7;                    % Viento externo [uniades m/s]

g=9.8;              % gravedad [uniades m/s²]
m=80;               % masa de la partícula [unidades Kg]
p=1.24;             % Densidad del aire siempre constante [unidades Kg/m³]
cd=0.5;             % Coeficiente de arrastre [Adimensional]
A=0.3;              % Área de sección transversal de contenedor de 30.9 cm de radio [unidades m²]
k=(1/2)*p*A*cd;     % Constante para el cálculo del fuerza de arrastre [unidades Kg/m]

ti=0;               % tiempo inicial [unidades s]
tf=100;             % tiempo final [unidades s] 
h=0.01;              % paso de tiempo [unidades s] 
n=(tf-ti)/h;        % Numero de ciclos
t(1)=ti;            % Inicializando tiempo

ax(1)=k*(Vw^2-vx(1)*sqrt(vx(1)^2+vy(1)^2))/m;   % Componente de aceleración inicial en x [unidades m/s²]
ay(1)=-g-(k*vy(1)*sqrt(vx(1)^2+vy(1)^2))/m;     % Componente de aceleración inicial en y [unidades m/s²]

% Ciclo para el metodo de Euler
for i=2:n
    x(i,1) =vx(i-1,1)*h+x(i-1,1);  % nueva posición en x [unidades m]
    y(i,1) =vy(i-1,1)*h+y(i-1,1);  % nueva posición en y [unidades m]
    
    vx(i,1)=ax(i-1,1)*h+vx(i-1,1);  % nueva velocidad en x [unidades m/s]
    vy(i,1)=ay(i-1,1)*h+vy(i-1,1);  % nueva velocidad en y [unidades m/s]

    ang(i,1) =atand(vy(i,1)/vx(i,1)); % nuevo ángulo [unidades grados]
   
    t(i,1) =t(i-1,1)+h;             % Contador de tiempo

    ax(i,1)=k*(Vw^2-vx(i)*sqrt(vx(i)^2+vy(i)^2))/m; % nueva aceleración en x [unidades m/s²]
    ay(i,1)=-g-(k*vy(i)*sqrt(vx(i)^2+vy(i)^2))/m;   % nueva aceleración en y [unidades m/s²]
    
    if y(i,1)<=-1000
        break % Romper el ciclo al llegar al suelo
    end
end


% CÓDIGO QUE SOLO CARGA LA IMAGEN DE LA AVIONETA
I = imread ('cohete.jpg');   % Cargar imagen de avioneta
image([0 0],[0 0],I);          % Insertar imagen de avioneta en plot
hold on;
