function updatePointAircraftPosition(hAircraft, position)
    % Atualiza a posição do ponto representando a aeronave e os limites dos eixos
    % hAircraft: handle do ponto da aeronave no gráfico
    % position: [x, y, z] posição inercial da aeronave
    
    % Atualiza as coordenadas do ponto
    set(hAircraft, 'XData', position(1));
    set(hAircraft, 'YData', position(2));
    set(hAircraft, 'ZData', position(3));
    
    % Mantém a câmera focada na aeronave
    camtarget(position);
    
    % Define os limites dos eixos com 10 metros de margem em torno da aeronave
    xlim([position(1) - 10, position(1) + 10]);
    ylim([position(2) - 10, position(2) + 10]);
    zlim([position(3) - 10, position(3) + 10]);
    
    drawnow; % Atualiza o gráfico
end
