%---------------CONSTRUCTOR-BOARD---------------%

% Descripcion:  Predicado para crear un tablero de Conecta4.
% Dominio: No recibe parámetros de entrada.
% Recorrido: board(Board).
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
