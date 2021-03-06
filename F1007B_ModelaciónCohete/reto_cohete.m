clear all
%%CONSTANTES LOCALES
g=9.8;              % gravedad [uniades m/s²]
mb=.166;            % masa de la botella [unidades Kg]
A=0.012;            % Área de sección transversal de contenedor de radio 6.05cm [unidades m²]
Ac=.00064458;       % Área de sección transversal del cuello de la botella 1.43cm [unidades m²]
d=1000;             % Densidad del agua [unidades kg/m^3]
N=4;                % Cantidad de veces que se accionó la bomba [Adimensional]
Patm = 101325;      % Presión atmosférica
Vb = .00071620;     % Volumen del aire de la bomba [unidades m^3]
H = .4;             % Altura de la botella de agua [unidades m]
 
%%VALORES INICIALES DE VARIABLES
mw(1) = 1;          % masa inicial del agua [unidades Kg]
P(1) = Patm*(1+(N*Vb)/(A*(H-(mw(1)*A)/d))); % Presión inicial del aire dentro de la botella [unidades Pa]
m(1) = mb + mw(1);     % masa inicial del cohete [unidades Kg]
x(1)=0;             % posición inicial x [unidades m]
y(1)=0;             % posición inicial y [unidades m]
vc(1)=0;            % velocidad inicial de contenedor [unidades m/s]
v2(1)=sqrt((2*N*Patm*Vb)/(d*(H*A-m(1)/d)));
ang(1)=60;           % ángulo de salida [unidades grados]

%%VARIABLES DE TIEMPO
ti=0;               % tiempo inicial [unidades s]
tf=20;              % tiempo final [unidades s] 
h=0.01;             % paso de tiempo [unidades s] 
n=(tf-ti)/h;        % Cantidad de ciclos
t(1)=ti;            % Inicializando tiempo

%%MOVIMIENTO DEL COHETE CUANDO TIENE AGUA
for i=2:n
    mw(i,1) = mw(i-1,1)- Ac*v2(i-1,1)*d*h;
    m(i,1) = mb + mw(i,1);
    P(i,1) = (Patm*(H-(m(1,1)*A/d)+(N*Vb/A)))/(H-(m(i,1)*A/d));
    
    vc(i,1) = vc(i-1,1) + ((Ac*d*v2(i-1,1)^2)/m(i-1,1))*h;
    v2(i,1) = sqrt((P(i,1)-Patm)*(2/d));
    
    x(i,1) = x(i-1,1) + vc(i,1)*cosd(ang(1))*h;
    y(i,1) = y(i-1,1) + vc(i,1)*sind(ang(1))*h;
    
    if m(i,1)<mb
        x_cambio=x(i-1,1);
        y_cambio=y(i-1,1);
        break
    end
end

%%MOVIMIENTO DEL COHETE SIN AGUA
ay = zeros(i,1);            %Creamos los vectores de aceleración y velocidades
vx = zeros(i,1);
vy = zeros(i,1);

vx(i,1) = vc(i,1)*cosd(ang(1));  %Inicializamos las variables para el ciclo en el que nos quedamos
vy(i,1) = vc(i,1)*sind(ang(1));
ay(i,1) = -g;
for i=1:i
    ang(i,1) = ang(1);
end
for i =(i+1):n
    
    vy(i,1)=vy(i-1,1)+ay(i-1,1)*h;
    vx(i,1) = vx(i-1,1);
    ang(i,1)=atand(vy(i,1)/vx(i,1)); % nuevo ángulo [unidades grados]
    ay(i,1) = -g;
    
    x(i,1) = x(i-1,1) + vx(i,1)*h;
    y(i,1) = y(i-1,1) + vy(i,1)*h;
    
    if (vy(i,1)<0) && (vy(i-1,1)>0)
       y_max=y(i,1);
    end
    if y(i,1)<=0
        y(end) = [];
        x(end) = [];
        break
    end
end

% CÓDIGO TRAZA LA TRAYECTORIA
% hold on
% plot(x_cambio, y_cambio,'o')
comet(x,y)                      % Graficar trayectoria
fprintf("\nDesplazamiento en x recorrida: %.2f m",(x(end-1)))
try 
    fprintf("\nAltura máxima alcanzada: %.2f m\n",y_max)
catch
    error = "0m (tiro horizontal)";
    fprintf("\nAltura máxima alcanzada: %s\n",error)
end