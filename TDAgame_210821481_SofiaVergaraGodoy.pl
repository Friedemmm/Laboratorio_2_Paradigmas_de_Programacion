%-----------------RF-11-CONSTRUCTOR-GAME----------------------%

% Descripcion: Predicado que permite crear una nueva partida.
% Dominio: player1 (player) X player2 (player) X board (board) X current-turn (int).
% Meta Principal: game/5.
% Meta Secundaria: ...

% Predicado para crear un game.
game(Player1, Player2, Board, CurrentTurn, NewGame) :-
    NewGame = [Player1, Player2, Board, CurrentTurn, _].

%----------------------------RF-12----------------------------%

% Descripcion: Predicado que genera un historial de movimientos de la partida.
% Dominio: game (game).
% Meta Principal: game_history/2.
% Meta Secundaria: ...

% Predicado para crear un historial.
game_history(Game, HistoryCronology) :-
    (Game = [_, _, _, _, History] -> 
        myReverse(History, HistoryCronology)
    ;   
        HistoryCronology = []
    ).


%----------------------------RF-13----------------------------%

% Descripcion: Predicado que verifica si el estado actual del juego es empate.
% Dominio: game (game).
% Meta Principal: is_draw/1.
% Meta Secundaria: getThird/2, getFirst/2, getSecond/2, can_play/1, game_has_winner/1, playersNoPieces/2.

% Predicado para verificar si el juego es empate.
is_draw(Game) :-
    getThird(Game, Board),
    getFirst(Game, Player1),
    getSecond(Game, Player2),
    can_play(Board),
    \+ game_has_winner(Game),
    playersNoPieces(Player1, Player2).

% Verificar si ambos jugadores no tienen fichas.
playersNoPieces(Player1, Player2) :-
    playersNoPieces(Player1),
    playersNoPieces(Player2).

% Verificar si un jugador no tiene fichas.
playersNoPieces(Player) :-
    getPiece(Player, RemainingPieces),
    RemainingPieces =:= 0.

%----------------------------RF-14----------------------------%

% Descripcion: Predicado que actualiza las estadísticas del jugador, ya sea victoria, derrotas o empates.
% Dominio: Game X EstadisticasPrevias X NuevasEstadisticas.
% Meta Principal: player_update_stats/3.
% Meta Secundaria: ...

% Predicado para actualizar estadísticas del jugador.
update_stats(Player, Result, UpdatedPlayer) :-
    Player = [ID, Name, Color, Wins, Losses, Draws, RemainingPieces],
    (Result = win ->
        NewWins is Wins + 1,
        UpdatedPlayer = [ID, Name, Color, NewWins, Losses, Draws, RemainingPieces]
    ; Result = loss ->
        NewLosses is Losses + 1,
        UpdatedPlayer = [ID, Name, Color, Wins, NewLosses, Draws, RemainingPieces]
    ; Result = draw ->
        NewDraws is Draws + 1,
        UpdatedPlayer = [ID, Name, Color, Wins, Losses, NewDraws, RemainingPieces]
    ;
        UpdatedPlayer = Player
    ).


%----------------------------RF-15----------------------------%

% Descripcion: Predicado que obtiene el jugador cuyo turno está en curso.
% Dominio: game (game).
% Meta Principal: get_current_player/2.
% Meta Secundaria: getFourth/2.

% Predicado para obtener el jugador actual.
get_current_player(Game, CurrentPlayer) :-
    getFourth(Game, CurrentTurn),
    (CurrentTurn mod 2 =:= 1 -> 
    	getFirst(Game, CurrentPlayer)
        ;  
    	getSecond(Game, CurrentPlayer)
    ).

%----------------------------RF-16----------------------------%

% Descripcion: Predicado que entrega por pantalla el estado actual del tablero en el juego.
% Dominio: game X board.
% Meta Principal: game_get_board/2.
% Meta Secundaria: ...

game_get_board([_,_,Board,_,_], Board).

%----------------------------RF-17----------------------------%

% Descripcion: Predicado finaliza el juego actualizando las estadísticas de los jugadores según el resultado.
% Dominio: game (game) X game.
% Meta Principal: end_game/2.
% Meta Secundaria: getFirst/2, getSecond/2, getThird/2, getFourth/2, getFifth/2, getThird/2, colorPlayer/2.

% Predicado para finalizar el juego y actualizar estadísticas
end_game(Game, EndedGame) :-
    getFirst(Game, Player1),
    getSecond(Game, Player2),
    getThird(Game, Board),
    getFourth(Game, CurrentTurn),
    getFifth(Game, History),
    
    % Obtener número de jugador para Player1
    getThird(Player1, Color1),
    colorPlayer(Color1, PlayerNum1),
    
    (game_has_winner(Game) ->
        who_is_winner(Board, Winner),
        (Winner = PlayerNum1 ->
            update_stats(Player1, win, NewPlayer1),
            update_stats(Player2, loss, NewPlayer2)
        ;
            update_stats(Player1, loss, NewPlayer1),
            update_stats(Player2, win, NewPlayer2)
        )
    ;
        update_stats(Player1, draw, NewPlayer1),
        update_stats(Player2, draw, NewPlayer2)
    ),
    EndedGame = [NewPlayer1, NewPlayer2, Board, CurrentTurn, History].

%----------------------------RF-18----------------------------%

% Descripcion: Predicado que realiza un movimiento.
% Dominio: game (game) X player (player) X column (int).
% Meta Principal: player_play/4.
% Meta Secundaria: gameEnded/1, get_current_player/2, getID/2, getID/2, getThird/2, getFirst/2, getSecond/2, getID/2.

% Predicado principal para realizar un movimiento del jugador
player_play(Game, Player, Column, NewGame) :-
    \+ gameEnded(Game),
    get_current_player(Game, CurrentPlayer),
    getID(Player, ID),
    getID(CurrentPlayer, CurrentID),
    ID = CurrentID,
    getThird(Game, Board),
    % Ver que jugador es el Player.
    getFirst(Game, Player1),
    getSecond(Game, Player2),
    getID(Player1, ID1),
    (ID = ID1 ->  
    	RealPlayer = Player1
    ;   
    	RealPlayer = Player2
    ),
    getPiece(RealPlayer, RemainingPieces),
    RemainingPieces > 0,
    getColor(RealPlayer, Color),
    play_piece(Board, Column, Color, NewBoard),
    updatePieces(RealPlayer, UpdatedPlayer),
    updateGame(Game, UpdatedPlayer, NewBoard, NewGame, Color, Column).

% Insertar elemento al inicio de una lista
insertarInicio(Element, [], [Element]).
insertarInicio(Element, List, [Element | List]).

% Actualizar el estado del juego después de un movimiento.
updateGame(Game, UpdatedPlayer, NewBoard, NewGame, Color, Column) :-
    [P1, P2, _, Turn, History] = Game,
    [ID | _] = UpdatedPlayer,
    [P1ID | _] = P1,
    NextTurn is Turn + 1,
    myAppend([Column, Color], History, NewHistory),
    (ID = P1ID ->
        NewGame = [UpdatedPlayer, P2, NewBoard, NextTurn, NewHistory]
    ;
        NewGame = [P1, UpdatedPlayer, NewBoard, NextTurn, NewHistory]
    ).

% Restar una pieza al jugador si es el que realizó el movimiento
updatePieces(Player, UpdatedPlayer) :-
    Player = [ID, Name, Color, Wins, Losses, Draws, RemainingPieces],
    NewRemainingPieces is RemainingPieces - 1,
    NewRemainingPieces >= 0,
    UpdatedPlayer = [ID, Name, Color, Wins, Losses, Draws, NewRemainingPieces].

% Verificar si el juego ya terminó
gameEnded(Game) :-
    is_draw(Game) ; game_has_winner(Game).

% Verificar si hay un ganador en el tablero
game_has_winner(Game) :-
    getThird(Game, Board),
    who_is_winner(Board, Winner),
    Winner \= 0.
