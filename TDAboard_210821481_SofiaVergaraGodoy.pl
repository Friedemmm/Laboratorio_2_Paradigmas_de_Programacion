%----------------------SELECTORES-BOARD-----------------------%

% loQueBusco(dondeLoBusco, comoLeLlamoALoQueBusco) %

getFirst([First|_], First). 
getSecond([_, Second|_], Second).
getThird([_, _, Third|_], Third).
getFourth([_, _, _, Fourth|_], Fourth).
getFifth([_, _, _, _, Fifth|_], Fifth).
getSixth([_, _, _, _, _, Sixth|_], Sixth).
getSeventh([_, _, _, _, _, _, Seventh|_], Seventh).

colorPlayer("red", 1).
colorPlayer("yellow", 2).

% Obtener el valor del elemento en columna x fila.
getValorColumnaEnFila(Fila, Columna, Valor) :-
    enesimoElemento(Fila, Columna, Valor).

% Caso base.
myMember(Elemento, [Elemento|_]).
% Caso recursivo.
myMember(Elemento, [_|Cola]) :-
    myMember(Elemento, Cola).

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

% Caso base.
myReverse([], []).
% Caso recursivo.
myReverse([Cab|Resto], Invertida) :-
    myReverse(Resto, RestoInvertido), 
    myAppend(RestoInvertido, [Cab], Invertida). 

% Caso base.
enesimoElemento([Cab|_], 1, Cab).
% Caso recursivo.
enesimoElemento([_|Resto], N, Elemento) :-
    N > 1,
    N1 is N - 1,
    enesimoElemento(Resto, N1, Elemento).

%-----------------RF-04-CONSTRUCTOR-BOARD---------------------%

% Descripcion:  Predicado para crear un tablero de Conecta4.
% Dominio: No recibe parámetros de entrada.
% Meta Principal: board/1.
% Meta Secundaria: filaVacia/1.

% Predicado crear el tablero.
board(Board) :-
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
% Meta Secundaria: getColor/2, myReverse/2, ponerPiece/4.

% Predicado principal para colocar la pieza
play_piece(Board, Columna, Piece, NewBoard) :-
    Columna >= 1,
    Columna =< 7,
    myReverse(Board, BoardInvertido),
    ponerPiece(BoardInvertido, Columna, Piece, NewBoardInvertido),
    myReverse(NewBoardInvertido, NewBoard).

% Predicado auxiliar para colocar la pieza.
ponerPiece([Fila|Resto], Columna, Color, [NuevaFila|Resto]) :-
    getValorColumnaEnFila(Fila, Columna, 0), % Verifica que la columna está vacía
    actualizarFila(Fila, Columna, Color, NuevaFila), !.

ponerPiece([Fila|Resto], Columna, Color, [Fila|NuevoResto]) :-
    ponerPiece(Resto, Columna, Color, NuevoResto).

% Predicado auxiliar para actualizar la fila.
% Caso Base.
actualizarFila([_|Resto], 1, Color, [Color|Resto]).
% Caso Recursivo.
actualizarFila([Cabeza|Resto], Columna, Color, [Cabeza|NuevaFila]) :-
    Columna > 1,
    Columna1 is Columna - 1,
    actualizarFila(Resto, Columna1, Color, NuevaFila).

%----------------------------RF-07----------------------------%

% Descripcion: Predicado que permite verificar ganador que conecta 4 fichas de forma vertical.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical).
% Meta Principal: check_vertical_win/2.
% Meta Secundaria: checkColumna/3.

% Predicado principal para verificar victoria vertical.
check_vertical_win(Board, Winner) :- 
    checkColumna(Board, 1, Winner).

% Predicado auxiliar para verificar las columnas.
% Caso Base.
checkColumna(_, 8, 0).
% Caso Recursivo.
checkColumna(Board, Columna, Winner) :-
    Columna < 8,
    cuatroConsecutivasVertical(Board, Columna, 1, GanadorColumna),
    analisisColumna(Board, Columna, GanadorColumna, Winner).

% Predicado auxiliar para analizar columna si hay winner o no.
% Caso Base.
analisisColumna(_, _, Winner, Winner) :-
    Winner \= 0.
% Caso Recursivo.
analisisColumna(Board, Columna, 0, Winner) :-
    NextColumna is Columna + 1,
    checkColumna(Board, NextColumna, Winner).

% Predicado auxiliar para verifica si hay cuatro piezas consecutivas en una columna. 
% Caso base.
cuatroConsecutivasVertical(_, _, Fila, 0) :-
    Fila + 3 > 6.
% Caso Recursivo: Cuatro valores consecutivos desde una posición específica.
cuatroConsecutivasVertical(Board, Columna, Fila, Winner) :-
    Fila + 3 =< 6,
    obtenerValoresConsecutivosVertical(Board, Columna, Fila, Valores, Winner),
    procesarValoresVertical(Valores, Fila, Board, Columna, Winner).

% Predicado auxiliar para obtiene los 4 valores consecutivos en la columna.
obtenerValoresConsecutivosVertical(Board, Columna, Fila, [V1,V2,V3,V4], _) :-
    obtenerValorElemento(Board, Columna, Fila, V1),
    Fila2 is Fila + 1,
    obtenerValorElemento(Board, Columna, Fila2, V2),
    Fila3 is Fila + 2,
    obtenerValorElemento(Board, Columna, Fila3, V3),
    Fila4 is Fila + 3,
    obtenerValorElemento(Board, Columna, Fila4, V4).

% Predicado auxiliar para obtiene el valor de una elemento específico.
obtenerValorElemento(Board, Columna, Fila, Valor) :-
    enesimoElemento(Board, Fila, FilaActual),
    getValorColumnaEnFila(FilaActual, Columna, Valor).

% Predicado auxiliar para procesa los valores obtenidos para ver si hay un ganador.
procesarValoresVertical([V1,V2,V3,V4], _, _, _, Winner) :-
    V1 \= 0,
    V1 = V2,
    V2 = V3,
    V3 = V4,
   	colorPlayer(V1, Winner).
procesarValoresVertical(_, Fila, Board, Columna, Winner) :-
    Fila < 3,
    NextFila is Fila + 1,
    cuatroConsecutivasVertical(Board, Columna, NextFila, Winner).
procesarValoresVertical(_, Fila, _, _, 0) :-
    Fila >= 3.

%----------------------------RF-08----------------------------%

% Descripcion: Predicado que permite verificar ganador que conecta 4 fichas de forma horizontal.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal).
% Meta Principal: check_horizontal_win/2.
% Meta Secundaria: checkFila/3.

% Predicado principal para verificar victoria horizontal.
check_horizontal_win(Board, Winner) :- 
    checkFila(Board, 1, Winner).

% Predicado auxiliar para verificar las filas.
% Caso Base.
checkFila(_, 7, 0).
% Ccaso Recursivo.
checkFila(Board, Fila, Winner) :-
    Fila < 7,
    cuatroConsecutivasHorizontal(Board, Fila, 1, GanadorFila),
    analisisFila(Board, Fila, GanadorFila, Winner).

% Predicado auxiliar para analizar fila si hay winner o no.
% Caso Base.
analisisFila(_, _, Winner, Winner) :-
    Winner \= 0.
% Ccaso Recursivo.
analisisFila(Board, Fila, 0, Winner) :-
    NextFila is Fila + 1,
    checkFila(Board, NextFila, Winner).

% Predicado auxiliar para verifica si hay cuatro piezas consecutivas en una fila. 
% Caso Base.
cuatroConsecutivasHorizontal(_, _, Columna, 0) :-
    Columna + 3 > 7.
% Caso Recursivo: Cuatro valores consecutivos desde una posición específica.
cuatroConsecutivasHorizontal(Board, Fila, Columna, Winner) :-
    Columna + 3 =< 7,
    obtenerValoresConsecutivosHorizontal(Board, Fila, Columna, Valores, Winner),
    procesarValoresHorizontal(Valores, Columna, Board, Fila, Winner).

% Predicado auxiliar para obtiene los 4 valores consecutivos en la fila.
obtenerValoresConsecutivosHorizontal(Board, Fila, Columna, [V1,V2,V3,V4], _) :-
    enesimoElemento(Board, Fila, FilaActual),
    getValorColumnaEnFila(FilaActual, Columna, V1),
    Col2 is Columna + 1,
    getValorColumnaEnFila(FilaActual, Col2, V2),
    Col3 is Columna + 2,
    getValorColumnaEnFila(FilaActual, Col3, V3),
    Col4 is Columna + 3,
    getValorColumnaEnFila(FilaActual, Col4, V4).

% Predicado auxiliar para procesa los valores obtenidos para ver si hay un ganador.
procesarValoresHorizontal([V1,V2,V3,V4], _, _, _, Winner) :-
    V1 \= 0,
    V1 = V2,
    V2 = V3,
    V3 = V4,
    colorPlayer(V1, Winner).
procesarValoresHorizontal(_, Columna, Board, Fila, Winner) :-
    Columna < 4,
    NextColumna is Columna + 1,
    cuatroConsecutivasHorizontal(Board, Fila, NextColumna, Winner).
procesarValoresHorizontal(_, Columna, _, _, 0) :-
    Columna >= 4.


%----------------------------RF-09----------------------------%

% Descripcion: Predicado que permite verificar ganador que conecta 4 fichas de forma diagonal.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal).
% Meta Principal: check_diagonal_win/2.
% Meta Secundaria: checkDiagonal/3.

% Predicado principal para verificar victoria diagonal.
check_diagonal_win(Board, Winner) :- 
    checkDiagonal(Board, 1, Winner).

% Predicado auxiliar para verificar las diagonales.
% Caso Base.
checkDiagonal(_, 7, 0).
% Caso Recursivo.
checkDiagonal(Board, Fila, Winner) :-
    Fila < 7,
    cuatroConsecutivasDiagonal(Board, Fila, 1, GanadorDiagonal),
    analisisDiagonal(Board, Fila, GanadorDiagonal, Winner).

% Predicado auxiliar para analizar diagonal si hay winner o no.
% Caso Base.
analisisDiagonal(_, _, Winner, Winner) :-
    Winner \= 0.
% Caso Recursivo.
analisisDiagonal(Board, Fila, 0, Winner) :-
    NextFila is Fila + 1,
    checkDiagonal(Board, NextFila, Winner).

% Predicado auxiliar para verifica si hay cuatro piezas consecutivas en una diagonal. 
cuatroConsecutivasDiagonal(Board, Fila, Columna, Winner) :-
    verificarDirecciones(Board, Fila, Columna, Winner).

% Predicado auxiliar para verificar direcciones diagonales ascendentes y descendentes.
% Caso Base: Diagonal Ascendente.
verificarDirecciones(Board, Fila, Columna, Winner) :-
    checkAscendente(Board, Fila, Columna, Winner).
% Caso Base: Diagonal Descendente.
verificarDirecciones(Board, Fila, Columna, Winner) :-
    checkDescendente(Board, Fila, Columna, Winner).
% Caso Recursivo: No hay ganador, avanza a la siguiente columna.
verificarDirecciones(Board, Fila, Columna, Winner) :-
    Columna < 4,
    NextColumna is Columna + 1,
    cuatroConsecutivasDiagonal(Board, Fila, NextColumna, Winner).
% Caso: No hay ganador si se acabaron las columnas.
verificarDirecciones(_, _, _, 0).

% Predicado auxiliar para verificar diagonal ascendente.
checkAscendente(Board, Fila, Columna, Winner) :-
    validarLimitesAscendente(Fila, Columna),
    obtenerValoreAscendente(Board, Fila, Columna, Color),
    colorPlayer(Color, Winner).

% Predicado auxiliar para validar que la fila y columna estén dentro de los límites.
validarLimitesAscendente(Fila, Columna) :-
    Fila =< 3,
    Columna =< 4.

% Predicado auxiliar para obtener y verificar los valores de una diagonal ascendente.
obtenerValoreAscendente(Board, Fila, Columna, Color) :-
    obtenerValorElemento(Board, Fila, Columna, Color),
    Color \= 0,
    obtenerRestoValoresAscendente(Board, Fila, Columna, Color).

% Predicado auxiliar para verificar los valores consecutivos de la diagonal ascendente.
obtenerRestoValoresAscendente(Board, Fila, Columna, Color) :-
    Fila2 is Fila + 1, Col2 is Columna + 1,
    Fila3 is Fila + 2, Col3 is Columna + 2,
    Fila4 is Fila + 3, Col4 is Columna + 3,
    obtenerValorElemento(Board, Fila2, Col2, Color),
    obtenerValorElemento(Board, Fila3, Col3, Color),
    obtenerValorElemento(Board, Fila4, Col4, Color).

% Predicado auxiliar para verificar diagonal descendente.
checkDescendente(Board, Fila, Columna, Winner) :-
    validarLimitesDescendente(Fila, Columna),
    obtenerValoresDescendente(Board, Fila, Columna, Color),
    colorPlayer(Color, Winner).

% Predicado auxiliar para obtener y verificar los valores de una diagonal descendente.
validarLimitesDescendente(Fila, Columna) :-
    Fila >= 4,
    Columna =< 4.

% Predicado auxiliar para obtener y verificar los valores de una diagonal descendente.
obtenerValoresDescendente(Board, Fila, Columna, Color) :-
    obtenerValorElemento(Board, Fila, Columna, Color),
    Color \= 0,
    obtenerRestoValoresDescendente(Board, Fila, Columna, Color).

% Predicado auxiliar para verificar los valores consecutivos de la diagonal descendente.
obtenerRestoValoresDescendente(Board, Fila, Columna, Color) :-
    Fila2 is Fila - 1, Col2 is Columna + 1,
    Fila3 is Fila - 2, Col3 is Columna + 2,
    Fila4 is Fila - 3, Col4 is Columna + 3,
    obtenerValorElemento(Board, Fila2, Col2, Color),
    obtenerValorElemento(Board, Fila3, Col3, Color),
    obtenerValorElemento(Board, Fila4, Col4, Color).

%----------------------------RF-10----------------------------%

% Descripcion: Predicado que permite verificar cual es el ganador en cualquier tipo de win.
% Dominio: board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador).
% Meta Principal: who_is_winner/2.
% Meta Secundaria: check_vertical_win/2, check_horizontal_win/2, check_diagonal_win/2, revisarWin/4.

% Predicado principal para verificar victorias.
who_is_winner(Board, Winner) :-
    check_vertical_win(Board, VerticalWinner),
    check_horizontal_win(Board, HorizontalWinner),
    check_diagonal_win(Board, DiagonalWinner),
    revisarWin(VerticalWinner, HorizontalWinner, DiagonalWinner, Winner).

% Predicado auxiliar para revisar cada tipo de win.
revisarWin(VerticalWinner, _, _, VerticalWinner) :-
    VerticalWinner \= 0.
revisarWin(_, HorizontalWinner, _, HorizontalWinner) :-
    HorizontalWinner \= 0.
revisarWin(_, _, DiagonalWinner, DiagonalWinner) :-
    DiagonalWinner \= 0.
revisarWin(_, _, _, 0).







