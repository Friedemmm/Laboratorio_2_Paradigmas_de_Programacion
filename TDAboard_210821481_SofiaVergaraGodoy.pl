%---------------CONSTRUCTOR-BOARD---------------%

% Descripcion:  Predicado para crear un tablero de Conecta4.
% Dominio: No recibe parámetros de entrada.
% Estrategia: Creación sin backtracking.

% Crear una columna vacía de 6 elementos.
columnaVacia([0, 0, 0, 0, 0, 0]).

% Crear las 7 columnas.
boardVacio(Board) :-
    columnaVacia(Columna),
    Board = [Columna, Columna, Columna, Columna, Columna, Columna, Columna].

% Crear el tablero.
board(board(Board)) :-
    boardVacio(Board).

%---------------OTROS-BOARD---------------%

% Descripcion: Predicado que permite verificar si se puede realizar más jugadas en el tablero.
% Dominio: board(Board).
% Estrategia: Verificación por recorrido de lista (fila superior; primera fila).

can_play(Board) :-
    % Ver la cabeza del board; o sea, la primera fila.
    Board = board([primeraFila|_]),
    member(0, primeraFila).


playPiece(board(Rows), Column, Piece, board(NewRows)) :-
    % Verifica que la columna sea válida (entre 1 y 7)
    Column >= 1, Column =< 7,
    % Coloca la pieza y obtiene el nuevo tablero
    place_in_column(Rows, Column, Piece, NewRows).
