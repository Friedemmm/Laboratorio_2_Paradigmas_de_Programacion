%----------------------CONSTRUCTOR-GAME----------------------%

% Descripcion:  Predicado que permite crear una nueva partida.
% Dominio: player1 (player) X player2 (player) X board (board) X current-turn (int).
% Estrategia: Construcción directa de estructura.

% Función para crear compuesto o estructura.
game(Player1, Player2, Board, Turno, Game) :-
    Game = game(Player1, Player2, Board, Turno).

