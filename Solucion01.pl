
:- begin_tests(parrilla).

  test(fakeTest):-
    A is 1 + 2,
    A =:= 3.

:- end_tests(parrilla).