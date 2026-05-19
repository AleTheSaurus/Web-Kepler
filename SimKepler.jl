using Pkg
Pkg.add("GLMakie")

using GLMakie

# El propósito de este código es hacer 3 simulaciones interactivas para mostrar en el sitio web del proyecto.

# 1. Primera ley. La órbita de un planeta es en realidad una elipse, con el sol en uno de los focos

# Ecuaciones parametricas de la elipse:
# x(θ) = a * cos(θ) + h
# y(θ) = b * sin(θ) + k
# Con (h,k) siendo el centro de la elipse, a y b los semiejes mayor y menor

# Ubicación de foco de la elipse:
# (h-c,k), (h+c,k), con c = sqrt(a^2 - b^2) 

# Tamaño de la ventana
const WIDTH = 640
const HEIGHT = 360

# Centro de la órbita
const h = WIDTH / 2
const k = HEIGHT / 2

# Semiejes y variable para focos de elipse
a = 300
b = 160
c = sqrt(a^2 - b^2)

# Radio sol y planeta
const radioSol = 25
const radioPlaneta = 10

# Ángulo inicial planeta
thetaInicial = Observable(0.0)

# Posiciones iniciales Sol y planeta
posicionSol = (h - c, k) 
posicionPlaneta = @lift Point2f(cosd($thetaInicial) * a + h,sind($thetaInicial) * b + k)


# Figura
fig1 = Figure(size = (WIDTH, HEIGHT), backgroundcolor = :antiquewhite)

ejes1 = Axis(fig1[1,1],
    limits = (0,WIDTH,0,HEIGHT),
    aspect = DataAspect(),
    backgroundcolor = :antiquewhite,
    xgridvisible = false, 
    ygridvisible = false,
    xticksvisible = false,
    yticksvisible = false,
    xticklabelsvisible = false,
    yticklabelsvisible = false,
)

# Ejes x y y
hlines!(ejes1,[k], color = :black, linewidth = 1)
vlines!(ejes1,[h], color = :black, linewidth = 1)

# Órbita (elipse)
angulosOrbita = range(0, 360, length = 360)
xOrbita = h .+ cosd.(angulosOrbita) .* a
yOrbita = k .+ sind.(angulosOrbita) .* b
lines!(ejes1,xOrbita,yOrbita, color = :black, linewidth = 1)

# Añadir sol y planeta a la figura
scatter!(ejes1, @lift([$posicionPlaneta]), color = :blue, markersize = radioPlaneta * 2)
scatter!(ejes1, posicionSol, color = :red, markersize = radioSol * 2)

display(fig1)
# Velocidad
const SPEED = 0.5

while isopen(fig1.scene)
    thetaInicial[] -= SPEED
    sleep(1/60)
end

# 2. Segunda ley. Una linea que conecta al planeta y al Sol "recorre" un área de la elipse igual en un tiempo
# igual.






# 3. Tercera ley. El cuadrado periodo orbital de un planeta es proporcional al cubo de a (a es el 
# semieje mayor de la elipse que es la órbita)






