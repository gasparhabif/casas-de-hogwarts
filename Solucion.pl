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

% chanta(Medico)/1
chanta(Medico) :- 
    atiende(Medico, _),
    forall(atiende(Medico, Jugador), puedeSerSuspendido(Jugador)).

% 5
% nivelFalopez(Sustancia, Cantidad)/2
nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).
nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

% cuantaFalopaTiene(Jugador, Cantidad)/2
% cuantaFalopaTiene(Jugador, Cantidad) :- True.


cantidadFalopa(producto(_), 0).
cantidadFalopa(sustancia(Sustancia), Cantidad) :- nivelFalopez(Sustancia, Cantidad).
cantidadFalopa(sustancia(Sustancia), Cantidad) :- 
    not(nivelFalopez(Sustancia, _)),
    Cantidad is 0.
% cantidadFalopa(compuesto(Compuesto), Cantidad) :-
%     composicion(Compuesto, Ingredientes),

% 6
% medicoConProblemas(Medico)/1
medicoConProblemas(Medico) :-
    atiende(Medico, _),
    tieneProblemas(Medico, Problematicos),
    length(Problematicos, Cantidad),
    3 =< Cantidad.

% tieneProblemas(Medico, Problematicos)/2
tieneProblemas(Medico, Problematicos) :-
    findall(jugador(Jugador), (atiende(Medico, Jugador), puedeSerSuspendido(Jugador)), Problematicos).
tieneProblemas(Medico, Problematicos) :-
    findall(jugador(Jugador), (atiende(Medico, Jugador), seConocen(maradona, Jugador)), Problematicos).

% 7
% programaTVFantinesco(Lista)/1
programaTVFantinesco(Lista) :-
   findall(Jugador, jugador(Jugador), Jugadores),
   jugadoresFaloperos(Jugadores, Lista).

jugadoresFaloperos([], _).
jugadoresFaloperos([Jugador|Jugadores], Lista) :-
    puedeSerSuspendido(Jugador),
    jugadoresFaloperos(Jugadores, [Jugador|Lista]).
jugadoresFaloperos([Jugador|Jugadores], Lista) :-
    not(puedeSerSuspendido(Jugador)),
    jugadoresFaloperos(Jugadores, Lista).