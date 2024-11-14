%---------------CONSTRUCTOR-PIECE---------------%

% Descripcion: Predicado que crea una ficha de Conecta4.
% Dominio: color (string).
% Recorrido: piece (Color).
% Estrategia: Verificación sin backtracking.

piece(Color, piece(Color)) :-
    % Verificacion.
    string(Color),
    (Color = "red" ; Color = "yellow").
