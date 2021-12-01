clear all
x(1)=0;   % posición inicial x [unidades m]
y(1)=0;   % posición inicial y [unidades m]
ang(1)=45;   % ángulo de salida [unidades grados]

vc=0;               % velocidad inicial de contenedor [unidades m/s]
Vw=7;               % Viento externo [uniades m/s]
g=9.8;              % gravedad [uniades m/s²]
mb=.166;            % masa de la botella [unidades Kg]
mw(1) = 1;          % masa inicial del agua [unidades Kg]
m(1) = mb + mw;     % masa del cohete [unidades Kg]
p=1.24;             % Densidad del aire siempre constante [unidades Kg/m³]
cd=0.5;             % Coeficiente de arrastre [Adimensional]
A=0.012;            % Área de sección transversal de contenedor de radio 6.05cm [unidades m²]
Ac=.00064458;       % Área de sección transversal del cuello de la botella 1.43cm [unidades m²]
k=(1/2)*p*A*cd;     % Constante para el cálculo del fuerza de arrastre [unidades Kg/m]
d=1000;             % Densidad del agua [unidades kg/m^3]
N=4;                % Cantidad de veces que se accionó la bomba [Adimensional]
Patm = 101325;      % Presión atmosférica
Vb = .00071620;     % Volumen del aire de la bomba [unidades m^3]
H = .4;             % Altura de la botella de agua [unidades m]
ti=0;               % tiempo inicial [unidades s]
tf=100;             % tiempo final [unidades s] 
h=0.01;             % paso de tiempo [unidades s] 
n=(tf-ti)/h;        % Numero de ciclos
t(1)=ti;            % Inicializando tiempo
P(1) = Patm*(1+(N*Vb)/(A*(H-(mw(1)*A)/d))); % Presión inicial del aire dentro de la botella [unidades Pa]

vo=0;                   % velocidad inicial de contenedor [unidades m/s]
vx(1)=vo*cosd(ang(1));   % velocidad inicial en x  [unidades m/s]
vy(1)=vo*sind(ang(1));   % velocidad inicial en y  [unidades m/s]

% if m>mb
%     for i = 
%     P = (Patm*d*(H-(mw(t)*A/d)-(N*Vb/A)))/(H-mw(t)*A);  %Presión dentro de la botella
%     v2 = sqrt((P-Patm)*(2/d));                          % Velocidad de escape del agua
%     vc = vc + A*d*h*v2^2;                               % Velocidad del cohete
% else
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
%end

% CÓDIGO QUE SOLO CARGA LA IMAGEN DE LA AVIONETA
I = imread ('cohete.jpg');   % Cargar imagen de avioneta
image([0 0],[0 0],I);          % Insertar imagen de avioneta en plot
hold on;
% CÓDIGO TRAZA LA TRAYECTORIA
plot(x,y)                     % Graficar trayectoria
disp(x(end-1))