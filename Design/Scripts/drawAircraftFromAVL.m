function drawAircraftFromAVL()
    % Função para desenhar a aeronave com base no arquivo AVL
    
    % Definir parâmetros para cada superfície e seção
    surfaces = {
        'Wing',   [0 0 0], 1.0;    % Asa
        'HTail',  [1.060 0.000 0.240], 0.8;  % Estabilizador horizontal (HTail)
        'VTail',  [1.010 0.000 0.000], 0.6;  % Estabilizador vertical (VTail)
    };
    
    figure;
    hold on;
    grid on;
    xlabel('X [m]');
    ylabel('Y [m]');
    zlabel('Z [m]');
    axis equal;
    view(3); % Visão em 3D

    % Loop para desenhar cada superfície
    for i = 1:size(surfaces, 1)
        surfaceName = surfaces{i, 1};
        translate = surfaces{i, 2};
        scale = surfaces{i, 3};
        
        % Desenha a superfície com as seções correspondentes
        drawSurface(surfaceName, translate, scale);
    end

    hold off;
end

function drawSurface(surfaceName, translation, scale)
    % Função para desenhar cada superfície com base nas seções e perfis
    
    % Definir algumas seções básicas para cada superfície
    % Aqui usamos valores fictícios como exemplo, as seções reais vêm do arquivo
    if strcmp(surfaceName, 'Wing')
        sections = [
            0.0000, 0.0000, 0.0000, 0.3500;  % [X, Y, Z, Corda]
            0.0206, 0.5500, 0.0000, 0.2675;
            0.0375, 1.0000, 0.0000, 0.2000
        ];
    elseif strcmp(surfaceName, 'HTail')
        sections = [
            0.0000, 0.0000, 0.0000, 0.2000;
            0.0480, 0.3000, 0.0000, 0.1200
        ];
    elseif strcmp(surfaceName, 'VTail')
        sections = [
            0.0000, 0.0000, 0.0000, 0.2500;
            0.0600, 0.0000, 0.2400, 0.1500
        ];
    else
        sections = [];
    end
    
    % Ajusta as seções com base na escala e translação
    sections(:, 1:3) = sections(:, 1:3) * scale + translation;
    
    % Desenhar as seções como asas
    for i = 1:size(sections, 1) - 1
        p1 = sections(i, 1:3);     % Ponto inicial da seção
        p2 = sections(i + 1, 1:3); % Ponto final da seção
        plot3([p1(1), p2(1)], [p1(2), p2(2)], [p1(3), p2(3)], 'b-', 'LineWidth', 2);
        
        % Desenhar corda (relação com dimensão da superfície)
        plot3([p1(1), p1(1)], [p1(2), p1(2)], [p1(3), p1(3) + sections(i, 4)], 'k-', 'LineWidth', 1.5);
    end
end
