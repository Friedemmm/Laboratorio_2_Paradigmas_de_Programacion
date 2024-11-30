%---------------------SELECTORES-PLAYER-----------------------%

getID(Player, ID) :-
    player(ID, _, _, _, _, _, _, Player).
getName(Player, Name) :-
    player(_, Name, _, _, _, _, _, Player).
getColor(Player, Color) :-
    player(_, _, Color, _, _, _, _, Player).
getWin(Player, Win) :-
    player(_, _, _, Win, _, _, _, Player).
getLoss(Player, Loss) :-
    player(_, _, _, _, Loss, _, _, Player).
getDraw(Player, Draw) :-
    player(_, _, _, _, _, Draw, _, Player).
getPiece(Player, Piece) :- 
    player(_, _, _, _, _, _, Piece, Player).


%-----------------RF-02-CONSTRUCTOR-PLAYER--------------------%

% Descripcion: Predicado que permite crear un jugador.
% Dominio: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining_pieces (int) X Player.
% Meta Principal: player/8.
% Meta Secundaria:...

player(ID, Name, Color, Wins, Losses, Draws, RemainingPieces, [ID, Name, Color, Wins, Losses, Draws, RemainingPieces]) :-
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
