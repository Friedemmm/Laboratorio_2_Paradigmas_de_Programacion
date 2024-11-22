%----------------------SELECTORES-BOARD-----------------------%

% loQueBusco(dondeLoBusco, comoLeLlamoALoQueBusco) %

getFirst([First | _], First). 
getSecond([_, Second | _], Second).
getThird([_, _, Third | _], Third).
getFourth([_, _, _, Fourth | _], Fourth).
getFifth([_, _, _, _, Fifth | _], Fifth).
getSixth([_, _, _, _, _, Sixth | _], Sixth).
getSeventh([_, _, _, _, _, _, Seventh | _], Seventh).

% Caso base.
getElement(1, [Head | _], Head).
% Caso recursivo.
getElement(Index, [_ | Tail], Element) :-
    Index > 1,
    NextIndex is Index - 1,
    getElement(NextIndex, Tail, Element).

% Caso base.
myLength([], 0).
% Caso recursivo.
myLength([_ | Cola], Largo) :-
    list_length(Cola, LargoCola),
    Largo is LargoCola + 1.

% Caso base.
myAppend([], L, L).
% Caso recursivo.
myAppend([Cab|Cola], L2, [Cab|Resultado]) :-
    myAppend(Cola, L2, Resultado).

%----------------------CONSTRUCTOR-BOARD----------------------%

% Descripcion:  Predicado para crear un tablero de Conecta4.
% Dominio: No recibe parámetros de entrada.
% Estrategia: Creación sin backtracking.

% Predicado crear el tablero.
board(board(Board)) :-
    boardVacio(Board).

% Predicado auxiliar para crear las 6 filas.
boardVacio(Board) :-
    filaVacia(Fila),
    Board = [Fila, Fila, Fila, Fila, Fila, Fila].
    
% Predicado auxiliar para crear una fila de 7 elementos.
    filaVacia([0, 0, 0, 0, 0, 0, 0]).

%-------------------------OTROS-BOARD-------------------------%

% Descripcion: Predicado que permite verificar si se puede realizar más jugadas en el tablero.
% Dominio: board(Board).
% Estrategia: Verificación por recorrido de lista (fila superior; primera fila).

% Predicado verificar si se puede jugar.
can_play(Board) :-
    % Ver primera fila y buscar si hay espacio vacio.
    getFirst(Board, PrimeraFila),
    member(0, PrimeraFila).

%-------------------------------------------------------------%

% Descripcion: Predicado que permite jugar una ficha en el tablero.
% Dominio: Board (board) X Column (int) X Piece (piece) X NewBoard (board).
% Estrategia: *************

% Predicado jugar la ficha.
play_Piece(board(Filas), Columna, Piece, board(NuevasFilas)) :-
    Columna >= 1, 
    Columna =< 7,
    ponerPiece(Filas, Columna, Piece, NuevasFilas).


↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓      CAMBIAR      ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
% Predicado auxiliar para poner la ficha en el board.
ponerPiece(Filas, Columna, Piece, NuevasFilas) :-
    getColumna(Filas, ColAux, Columna),
    encontrarEspacio(Board, Columna, Filas),
    % Actualizar fila.
    getElement(Filas, Pos, FilaAnt),
    nuevaFila(FilaAnt, ColAux, Piece, FilaNueva),
    nuevaFila(Filas, Pos, FilaNueva, FilasNuevas).
    

% Predicado auxiliar para entrar en la columna.
% Caso Base.
get_column([], _, []).

% Caso Recursivo.
getColumna([Fila|Filas], ColAux, [Elemento|Resto]) :-
    getElement(Fila, ColAux, Elemento),
    getColumna(Filas, ColAux, Resto).
    

% Predicado auxiliar para encontrar en que fila de la columna especificada esta el primer 0.
encontrarEspacio(Board, Columna, FilaPosicion) :-
    encontrarEspacioAux(Board, Columna, 1, FilaPosicion).

% Caso Base.
encontrarEspacioAux([FilaActual | RestoFilas], Columna, FilaIndex, FilaIndex) :-
    getElement(FilaActual, Columna, 0).

% Caso recursivo.
encontrarEspacioAux([_ | RestoFilas], Columna, FilaIndex, FilaPosicion) :-
    NextIndex is FilaIndex + 1,
    encontrarEspacioAux(RestoFilas, Columna, NextIndex, FilaPosicion).
    

% Predicado auxiliar para sobreescribir la elemento.
nuevaFila(Lista, Pos, ElementoNuevo, NuevaLista) :-
    myLength(Lista, Len),
    Pos =< Len,
    myLength(Inicio, Pos),
    myAppend(Inicio, [_|Final], Lista),
    myAppend(Inicio, [ElementoNuevo|Final], NuevaLista).

%-------------------------------------------------------------%

% Descripcion: Predicado que permite verificar ganador que conecta 4 fichas de forma vertical.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical).
% Estrategia: 

% Predicado para verificar las conidiciones de win.
check_vertical_win(board(Board), Winner) :-
    Columnas = [1,2,3,4,5,6,7],
    checkColumna(Board, Columnas, Winner).

↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓      CAMBIAR      ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
% Predicado auxiliar para verificar cada columna.
% Caso base.
checkColumna(_, [], 0).

% Caso recursivo; con ganador.
checkColumna(Board, [Head|_], Winner) :-
    getColumna(Board, Head, ColumnaRevisar),
    checkConsecutivos(ColumnaRevisar, Winner),
    Winner \= 0.
    
% Caso recursivo; sin ganador.
checkColumna(Board, [Head|Cola], Winner) :-
    getColumna(Board, Head, ColumnaRevisar),
    checkConsecutivos(ColumnaRevisar, 0),
    checkColumna(Board, Cola, Winner).


% Predicado para ver si hay 4 consecutivos.
% Caso base.
checkConsecutivos([], 0).

% Caso base; no hay tantas piezas puestas.
checkConsecutivos(List, 0) :-
    myLength(List, Len),
    Len < 4.

% Caso base; no hay ganador.
checkConsecutivos([_ | Cola], Winner) :-
    checkConsecutivos(Cola, Winner).
    
% Caso recursivo.
checkConsecutivos([P1, P2, P3, P4 | _], Winner) :-
    P1 \= 0,  % No considerar espacios vacíos
    P1 = P2,
    P2 = P3,
    P3 = P4,
    Winner = P1.  % El ganador es el número del jugador (1 o 2).






