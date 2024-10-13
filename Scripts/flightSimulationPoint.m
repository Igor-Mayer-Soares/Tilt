function flightSimulationPoint()
    % Simulação de voo simples no espaço 3D com a aeronave sendo representada por um ponto
    
    % Desenha o ponto representando a aeronave
    hAircraft = drawPointAircraft();
    
    % Inicializa a posição
    position = [0, 0, 0];  % Posição inicial [x, y, z]
    
    % Configuração de voo: duração e intervalo de tempo
    t_total = 10;  % Duração do voo em segundos
    dt = 0.05;     % Intervalo de tempo (50 ms)
    
    % Loop de simulação de voo
    for t = 0:dt:t_total
        % Atualiza a posição (trajetória em espiral crescente)
        position(1) = 5 * cos(t);  % Movimento em X (espiral)
        position(2) = 5 * sin(t);  % Movimento em Y (espiral)
        position(3) = t;           % Movimento em Z (subida linear)
        
        % Atualiza a posição da aeronave no gráfico
        updatePointAircraftPosition(hAircraft, position);
        
        % Pausa para controle do tempo
        pause(dt);
    end
end
