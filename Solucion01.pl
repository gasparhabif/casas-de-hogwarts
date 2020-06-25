
:- begin_tests(parrilla).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.
  
  % Test gustos de Jocelyn
  test(gustoJocelynMollejas, [nondet]) :- 
    gusto(jocelyn, Comida), 
    Comida == mollejas.
  test(gustoJocelynPapas, [nondet]) :- 
    gusto(jocelyn, Comida), 
    Comida == papaAlPlomo.
  test(gustoJocelynProvoleta, [nondet]) :- 
    gusto(jocelyn, Comida), 
    Comida == provoleta.

  % Test gustos de Jean Gourmet
  test(gustoJocelynAsado, [nondet]) :- 
    gusto(jeanGourmet, Comida), 
    Comida == asadoDeTira.
  test(gustoJocelynMollejas, [nondet]) :- 
    gusto(jeanGourmet, Comida),
    Comida == mollejas.
  test(gustoJocelynChinchu, [nondet]) :- 
    gusto(jeanGourmet, Comida), 
    Comida == chinchulines.
  test(gustoJocelynVacio, fail) :- 
    gusto(jeanGourmet, vacio).

:- end_tests(parrilla).

% comida/1
comida(chinchulines).
comida(mollejas).
comida(chorizo).
comida(morcilla).
comida(asadoDeTira).
comida(vacio).
comida(bondiola).
comida(papaAlPlomo).
comida(provoleta).

% veggy/1
veggy(papaAlPlomo).
veggy(provoleta).

% menuCaro/1
menuCaro(mollejas).
menuCaro(chinchulines).

% gusto/2
% Gustos de Jocelyn
gusto(jocelyn, mollejas).
gusto(jocelyn, Plato) :- veggy(Plato).

% Gustos de Jean Gourmet
gusto(jeanGourmet, asadoDeTira).
gusto(jeanGourmet, Plato):- menuCaro(Plato).

/* 
No es necesario modelar que Jean Gourmet no come vacío para satisfacer la consulta
ya que Prolog, al cumplir con el Principio de Universo Cerrado, considera a todo lo 
desconocido como Falso, por lo tanto al realizarse la consulta: gusto(jeanGourmet, vacio).
el resultado seria Falso, pues dicho gusto no existe en la base de conocimiento. 


Consultas realizadas para conocer los menúes que comerían Jocelyn y Jean Gourmet: 

gusto(jocelyn, Comida). 
Donde los valores que satisfacen son mollejas, papaAlPlomo y provoleta

gusto(jeanGourmet, Comida).
Donde los valores que satisfacen son asadoDeTira, mollejas y chinchilines 

*/
