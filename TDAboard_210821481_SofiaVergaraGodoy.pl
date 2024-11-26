%----------------------SELECTORES-BOARD-----------------------%

% loQueBusco(dondeLoBusco, comoLeLlamoALoQueBusco) %

getFirst([First|_], First). 
getSecond([_, Second|_], Second).
getThird([_, _, Third|_], Third).
getFourth([_, _, _, Fourth|_], Fourth).
getFifth([_, _, _, _, Fifth|_], Fifth).
getSixth([_, _, _, _, _, Sixth|_], Sixth).
getSeventh([_, _, _, _, _, _, Seventh|_], Seventh).

% Caso base.
getElement(1, [Cab|_], Cab).
% Caso recursivo.
getElement(Index, [_|Cola], Elemento) :-
    Index > 1,
    NextIndex is Index - 1,
    getElement(NextIndex, Cola, Elemento).

% Caso base.
myMember(Elemento, [Elemento|_]).
% Caso recursivo.
myMember(Elemento, [_|Cola]) :-
    mymember(Elemento, Cola).

% Caso base.
myLength([], 0).
% Caso recursivo.
myLength([_|Cola], Largo) :-
    myLength(Cola, LargoCola),
    Largo is LargoCola + 1.

% Caso base.
myAppend([], L, L).
% Caso recursivo.
myAppend([Cab|Cola], L2, [Cab|Resultado]) :-
    myAppend(Cola, L2, Resultado).

%-----------------RF-04-CONSTRUCTOR-BOARD---------------------%

% Descripcion:  Predicado para crear un tablero de Conecta4.
% Dominio: No recibe parámetros de entrada.
% Meta Principal: board/1.
% Meta Secundaria: boardVacio/1, filaVacia/1.

% Predicado crear el tablero.
board(board(Board)) :-
    boardVacio(Board).

% Predicado auxiliar para crear las 6 filas.
boardVacio(Board) :-
    filaVacia(Fila),
    Board = [Fila, Fila, Fila, Fila, Fila, Fila].
    
% Predicado auxiliar para crear una fila de 7 elementos.
    filaVacia([0, 0, 0, 0, 0, 0, 0]).

%----------------------------RF-05----------------------------%

% Descripcion: Predicado que permite verificar si se puede realizar más jugadas en el tablero.
% Dominio: board(Board).
% Meta Principal: can_play/1.
% Meta Secundaria: getFirst/2, myMember/2.

% Predicado verificar si se puede jugar.
can_play(Board) :-
    % Ver primera fila y buscar si hay espacio vacio.
    getFirst(Board, PrimeraFila),
    myMember(0, PrimeraFila).

%----------------------------RF-06----------------------------%

% Descripcion: Predicado que permite jugar una ficha en el tablero.
% Dominio: Board (board) X Column (int) X Piece (piece) X NewBoard (board).
% Meta Principal: play_Piece/4.
% Meta Secundaria: ponerPiece/4, actualizarFila/4, getElement/3, get***/2 (cualquier get de posición).

% Predicado jugar la ficha.
play_Piece(board(Filas), Columna, Piece, board(NuevasFilas)) :-
    Columna >= 1, 
    Columna =< 7,
    ponerPiece(Filas, Columna, Piece, NuevasFilas).


% Predicado auxiliar para poner la ficha en el board.
ponerPiece([Fila, FilaSiguiente|Resto], Columna, Piece, [NuevaFila, FilaSiguiente|Resto]) :-
    getElement(FilaSiguiente, Columna, 0),
    getElement(Fila, Columna, 0),
    actualizarFila(Fila, Columna, Piece, NuevaFila).
    

% Predicador auxiliar para actualizar la fila seleccionada.
actualizarFila(Fila, 1, Piece, [Piece|Resto]) :-
    getSecond(Fila, Segundo),
    getThird(Fila, Tercero),
    getFourth(Fila, Cuarto),
    getFifth(Fila, Quinto),
    getSixth(Fila, Sexto),
    getSeventh(Fila, Septimo),
    Resto = [Segundo,Tercero,Cuarto,Quinto,Sexto,Septimo].
    
actualizarFila(Fila, 2, Piece, [Primero,Piece|Resto]) :-
    getFirst(Fila, Primero),
    getThird(Fila, Tercero),
    getFourth(Fila, Cuarto),
    getFifth(Fila, Quinto),
    getSixth(Fila, Sexto),
    getSeventh(Fila, Septimo),
    Resto = [Tercero,Cuarto,Quinto,Sexto,Septimo].

actualizarFila(Fila, 3, Piece, [Primero,Segundo,Piece|Resto]) :-
    getFirst(Fila, Primero),
    getSecond(Fila, Segundo),
    getFourth(Fila, Cuarto),
    getFifth(Fila, Quinto),
    getSixth(Fila, Sexto),
    getSeventh(Fila, Septimo),
    Resto = [Cuarto,Quinto,Sexto,Septimo].

actualizarFila(Fila, 4, Piece, [Primero,Segundo,Tercero,Piece|Resto]) :-
    getFirst(Fila, Primero),
    getSecond(Fila, Segundo),
    getThird(Fila, Tercero),
    getFifth(Fila, Quinto),
    getSixth(Fila, Sexto),
    getSeventh(Fila, Septimo),
    Resto = [Quinto,Sexto,Septimo].

actualizarFila(Fila, 5, Piece, [Primero,Segundo,Tercero,Cuarto,Piece|Resto]) :-
    getFirst(Fila, Primero),
    getSecond(Fila, Segundo),
    getThird(Fila, Tercero),
    getFourth(Fila, Cuarto),
    getSixth(Fila, Sexto),
    getSeventh(Fila, Septimo),
    Resto = [Sexto,Septimo].

actualizarFila(Fila, 6, Piece, [Primero,Segundo,Tercero,Cuarto,Quinto,Piece|Resto]) :-
    getFirst(Fila, Primero),
    getSecond(Fila, Segundo),
    getThird(Fila, Tercero),
    getFourth(Fila, Cuarto),
    getFifth(Fila, Quinto),
    getSeventh(Fila, Septimo),
    Resto = [Septimo].

actualizarFila(Fila, 7, Piece, [Primero,Segundo,Tercero,Cuarto,Quinto,Sexto,Piece]) :-
    getFirst(Fila, Primero),
    getSecond(Fila, Segundo),
    getThird(Fila, Tercero),
    getFourth(Fila, Cuarto),
    getFifth(Fila, Quinto),
    getSixth(Fila, Sexto).


%----------------------------RF-07----------------------------%

% Descripcion: Predicado que permite verificar ganador que conecta 4 fichas de forma vertical.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical).
% Meta Principal: check_vertical_win/1.
% Meta Secundaria: myMember/2, getColumnaElementos/3, cuatroConsecutivos/2, NumeroDeColor/2.

% Predicado para verificar las condiciones de win vertical.
% Caso Base.
check_vertical_win(_, 0).
% Caso Recursivo.
check_vertical_win(board(Board), Winner) :-
    myMember(Columna, [1,2,3,4,5,6,7]),
    getColumnaElementos(Board, Columna, ListaColumna),
    cuatroConsecutivos(ListaColumna, ColorWinner),
    ColorWinner \= 0,
    NumeroDeColor(ColorWinner, Winner), !. 


% Color es número del jugador.
NumeroDeColor(red, 1).
NumeroDeColor(yellow, 2).
NumeroDeColor(0, 0).


% Obtener los elementos de la columna.
% Caso base.
getColumnaElementos([], _, []).
% Caso recursivo.
getColumnaElementos([Fila|Resto], Columna, [Valor|ValoresAdd]) :-
    getValorColumnaEnFila(Fila, Columna, Valor),
    getColumnaElementos(Resto, Columna, ValoresAdd).


% Obtener valor de la posición de la columna en la fila.
getValorColumnaEnFila(Fila, 1, Valor) :-
    getFirst(Fila, Valor).
getValorColumnaEnFila(Fila, 2, Valor) :-
    getSecond(Fila, Valor).
getValorColumnaEnFila(Fila, 3, Valor) :-
    getThird(Fila, Valor).
getValorColumnaEnFila(Fila, 4, Valor) :-
    getFourth(Fila, Valor).
getValorColumnaEnFila(Fila, 5, Valor) :-
    getFifth(Fila, Valor).
getValorColumnaEnFila(Fila, 6, Valor) :-
    getSixth(Fila, Valor).
getValorColumnaEnFila(Fila, 7, Valor) :-
    getSeventh(Fila, Valor).


% Verificar 4 fichas consecutivas.
% Caso base.
cuatroConsecutivos(Column, 0) :-
    myLength(Columna, Largo),
    Largo < 4.
% Caso recursivo: verificar 4 consecutivos del mismo color.
cuatroConsecutivos([P1,P2,P3,P4|_], P1) :-
    P1 \= 0,
    P1 = P2,
    P2 = P3,
    P3 = P4.
% Caso recursivo: verificar resto de la columna.
cuatroConsecutivos([_|Resto], Winner) :-
    cuatroConsecutivos(Resto, Winner).

%----------------------------RF-08----------------------------%

% Descripcion: Predicado que permite verificar ganador que conecta 4 fichas de forma horizontal.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal).
% Meta Principal: check_horizontal_win/1.
% Meta Secundaria: myMember/2, cuatroConsecutivos/2, NumeroDeColor/2.

% Predicado para verificar las condiciones de win horizontal.
% Caso Base.
check_horizontal_win(_, 0).
% Caso Recursivo.
check_horizontal_win(board(Board), Winner) :-
    myMember(Fila, Board),
    cuatroConsecutivosHorizontal(Fila, ColorWinner),
    ColorWinner \= 0,
    NumeroDeColor(ColorWinner, Winner), !.


% Verificar 4 fichas consecutivas en una fila
% Caso base.
cuatroConsecutivosHorizontal(Fila, 0) :-
    myLength(Fila, Largo),
    Largo < 4.
% Caso recursivo: verificar 4 consecutivos del mismo color.
cuatroConsecutivosHorizontal([P1,P2,P3,P4|_], P1) :-
    P1 \= 0,
    P1 = P2,
    P2 = P3,
    P3 = P4.
% Caso recursivo: verificar resto de la fila.
cuatroConsecutivosHorizontal([_|Resto], Winner) :-
    cuatroConsecutivosHorizontal(Resto, Winner).

%----------------------------RF-08----------------------------%


















