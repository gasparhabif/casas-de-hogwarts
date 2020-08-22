% Parte 1 - Sombrero Seleccionador

% mago(Nombre, Sangre, Caracteristicas, CasaQueOdia)/4
mago(harry, mestiza, [corajudo, amistoso, orgulloso, inteligente], slytherin).
mago(draco, pura, [inteligente, orgulloso], hufflepuff). 
mago(hermione, impura, [inteligente, orgulloso, responsable], _).

caracteristicasPorCasa(gryffindor, [corajudo]).
caracteristicasPorCasa(slytherin, [orgulloso, inteligencia]).
caracteristicasPorCasa(ravenclaw, [inteligente, responsable]).
caracteristicasPorCasa(hufflepuff, [amistoso]).

% 1
permiteEntrar(Casa, Mago) :- 
    mago(Mago,_, _, _), 
    Casa \= slytherin.
permiteEntrar(slytherin, Mago) :-
    mago(Mago, Sangre, _, _),
    Sangre \= impura.

% 2
caracterApropiado(Casa, Mago) :- 
    mago(Mago, _, CaracteristicasMago, _),
    caracteristicasPorCasa(Casa, CaracteristicasCasa),
    forall(member(CaractCasa, CaracteristicasCasa), member(CaractCasa, CaracteristicasMago)).
% 3
determinarCasa(Mago, Casa) :-
    mago(Mago, _, _, CasaQueOdia),
    caracterApropiado(Casa, Mago),
    permiteEntrar(Casa, Mago),
    CasaQueOdia \= Casa.
determinarCasa(hermione, gryffindor).

% 4       
cadenaDeAmistades(Amigos) :-
    podrianSerAmigos(Amigos).

podrianSerAmigos([_]).
podrianSerAmigos([Mago, MagoSiguiente|Magos]) :-
    esAmistoso(Mago),
    compartenCasa(Mago, MagoSiguiente),
    podrianSerAmigos([MagoSiguiente | Magos]).

esAmistoso(Mago) :-
    mago(Mago, _, Caracteristicas, _),
    member(amistoso, Caracteristicas).

compartenCasa(UnMago, OtroMago) :-
    determinarCasa(UnMago, Casa),
    determinarCasa(OtroMago, Casa).

% Parte 2 - La copa de las casas
% accion(Mago, QueHizo)/2
accion(harry,fueraDeCama).      % -50
accion(hermione, tercerPiso).   % -75
accion(hermione, biblioteca).   % -10
accion(harry, bosque).          % -50
accion(harry, tercerPiso).      % -75
accion(draco, mazmorras).
accion(ron, ganarAjedrez).      %+50
accion(hermione, salvarAmigos). %+50
accion(harry, ganarVoldemort).  %+60

queHizo(mazmorras, 0).
queHizo(biblioteca, -10).
queHizo(fueraDeCama, -50).
queHizo(bosque, -50).
queHizo(tercerPiso, -75).
queHizo(ganarAjedrez, 50).
queHizo(salvarAmigos, 50).
queHizo(ganarVoldemort, 60).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% 1.a
esBuenAlumno(Mago) :-
    accion(Mago, UnaAccion),
    queHizo(UnaAccion, Puntaje),
    Puntaje > 0,
    forall(accion(Mago, Accion), (queHizo(Accion, Puntos), Puntos >= 0)).
% 1.b
esAccionRecurrente(Accion) :-
    findall(Mago, accion(Mago, Accion), Magos),
    length(Magos, Cantidad),
    Cantidad > 1.
    
% 2
puntajeTotalCasa(Casa, Puntos) :-
    caracteristicasPorCasa(Casa, _),
    findall(Mago, esDe(Mago, Casa), Magos),
    maplist(puntajeMago, Magos, PuntosPorMago),
    sum_list(PuntosPorMago, Puntos).
% Se agrega este puntaje para testeo
puntajeTotalCasa(hufflepuff, 100).

puntajeMago(Mago, Puntos) :-
    findall(Puntaje, (accion(Mago, QueHizo), queHizo(QueHizo, Puntaje)), Puntuacion),
    sum_list(Puntuacion, Puntos).
    
% 3

casaGanadora(CasaGanadora) :-
    puntajeTotalCasa(CasaGanadora, PuntajeGanador),
    forall((puntajeTotalCasa(OtraCasa, PuntajePerdedor), CasaGanadora \= OtraCasa),
            PuntajeGanador > PuntajePerdedor).

% 4
% respuesta(Pregunta, Dificultad, Profesor)

respuesta(dondeBezoar, 20, snape).
respuesta(levitarPluma, 25, flitwick).

:- discontiguous accion/2.
accion(hermione, dondeBezoar).
accion(hermione, levitarPluma).

:- discontiguous queHizo/2.
queHizo(dondeBezoar, Puntos) :- 
    respuesta(dondeBezoar, Puntaje, snape),
    Puntos is Puntaje / 2.
queHizo(leivtarPluma, Puntos) :-
    respuesta(leivtarPluma, Puntos, _).
