% jugador(Quien)/1
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% tomo(Quien, Que)/2
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).

% maximo(Que, Cuanto)/2
maximo(cocacola, 3).
maximo(gatoreit, 1).
maximo(naranju, 5).

% composicion(Resultado, Componentes)/2
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

% sustanciaProhibida(Cual)/2
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).

% 1.a
tomo(passarella, Que) :- not(tomo(maradona, Que)).

% 1.b
tomo(pedemonti, Que) :- 
    tomo(chamot, Que), 
    tomo(maradona, Que).

% 1.c Gracias al principio de universo cerrado presente en Prolog
% no es necesario modelar que "basualdo no toma cocacola"
