%---------------CONSTRUCTOR-PLAYER---------------%

% Descripcion: Predicado que permite crear un jugador.
% Dominio: id (int) X name (string) X color (string) X wins (int) X
% losses (int) X draws (int) X remaining_pieces (int) X Player.
% Estrategia: Verificación directa de condiciones (sin backtracking)
%

player(ID, Name, Color, Wins, Losses, Draws, RemainingPieces, player(ID, Name, Color, Wins, Losses, Draws, RemainingPieces)) :-
    % Verificaciones.
    integer(ID),
    ID > 0,
    string(Name),
    string(Color),
    integer(Wins),
    Wins >= 0,
    integer(Losses),
    Losses >= 0,
    integer(Draws),
    Draws >= 0,
    integer(RemainingPieces),
    RemainingPieces >= 4,
    RemainingPieces =< 21.
