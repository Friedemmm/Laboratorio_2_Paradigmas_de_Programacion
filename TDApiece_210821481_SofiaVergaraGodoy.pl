%---------------------SELECTORES-PIECE-----------------------%

getColorPieza(Color, Piece) :-
    piece(Color, Piece).

%-----------------RF-03-CONSTRUCTOR-PIECE---------------------%

% Descripcion: Predicado que crea una ficha de Conecta4.
% Dominio: color (string).
% Meta Principal: piece/2.
% Meta Secundaria:...

piece(Color, piece(Color)) :-
    % Verificacion.
    string(Color),
    (Color = "red" ; Color = "yellow").

