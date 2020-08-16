% jugador(Quien)/1
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% maximo(Que, Cuanto)/2
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% composicion(Resultado, Componentes)/2
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustanciaProhibida(Cual)/2
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).

% tomo(Quien, Que)/2
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

% 1.a
% tomo(passarella, Que) :- 
%     tomo(_, Que),
%     not(tomo(maradona, Que)).

% 1.b
tomo(pedemonti, Que) :- 
    tomo(chamot, Que), 
    tomo(maradona, Que).

% 1.c Gracias al principio de universo cerrado presente en Prolog
% no es necesario modelar que "basualdo no toma cocacola"


% 2
% puedeSerSuspendido(Quien)/1
puedeSerSuspendido(Quien) :-
    sustanciaProhibida(SustanciaProhibida),
    ingirioSustanciaProhibida(Quien, SustanciaProhibida).
puedeSerSuspendido(Quien) :-
    tomo(Quien, producto(Producto, CuantoTomo)),
    maximo(Producto, CantidadMaxima),
    CantidadMaxima < CuantoTomo.

% ingirioSustanciaProhibida(Quien, Sustancia)/2
ingirioSustanciaProhibida(Quien, Sustancia) :-
    tomo(Quien, sustancia(Sustancia)).
ingirioSustanciaProhibida(Quien, Sustancia) :-
    tomo(Quien, compuesto(Compuesto)),
    composicion(Compuesto, Ingredientes),
    member(Sustancia, Ingredientes).

% 3
% amigo(Persona1, Persona2)/2
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

% malaInfluencia(Influencer, Influenciado)/2
malaInfluencia(Influencer, Influenciado) :-
    puedeSerSuspendido(Influencer),
    puedeSerSuspendido(Influenciado),
    seConocen(Influencer, Influenciado).

% seConocen(Persona1, Persona2)/2
seConocen(Persona1, Persona2) :- amigo(Persona1, Persona2).
seConocen(Persona1, Persona2) :- 
    amigo(Persona1, Persona3),
    seConocen(Persona3, Persona2).

% 4
% atiende(Medico, Jugador)/2
atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).
atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

% chanta(Quien)/1
chanta(Quien) :-