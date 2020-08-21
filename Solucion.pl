% Parte 1 - Sobrero Seleccionador

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