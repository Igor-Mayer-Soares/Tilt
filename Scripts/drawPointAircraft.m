function hAircraft = drawPointAircraft()
    % Desenho inicial da aeronave como um ponto no espaço 3D
    position = [0, 0, 0]; % Posição inicial no espaço
    hAircraft = plot3(position(1), position(2), position(3), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    hold on;
    
    % Ajusta o gráfico
    axis([-10 10 -10 10 0 10]); % Define os limites dos eixos
    grid on;
    xlabel('X [m]');
    ylabel('Y [m]');
    zlabel('Z [m]');
    view(3); % Visão 3D
end
