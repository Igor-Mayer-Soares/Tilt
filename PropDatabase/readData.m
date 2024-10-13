function [rpm_values,data_matrix] = readData(filename) 
% Abra o arquivo
fid = fopen(filename, 'r');
if fid == -1
    error('Não foi possível abrir o arquivo.');
end

% Inicializar variáveis
rpm_values = [];
data_matrix = [];

% Loop para ler o arquivo linha por linha
while ~feof(fid)
    % Ler a linha atual
    tline = fgetl(fid);
    
    % Verificar se a linha contém a informação de RPM
    if contains(tline, 'PROP RPM')
        % Extrair o valor de RPM
        rpm = sscanf(tline, '         PROP RPM =       %f');
        rpm_values = [rpm_values; rpm];
        
        % Pular duas linhas (cabeçalho das colunas)
        fgetl(fid);
        fgetl(fid);
        fgetl(fid);
        
        % Inicializar matriz temporária para este RPM
        temp_data = [];
        
        % Ler os dados numéricos associados a este RPM
        while true
            data_line = fgetl(fid);
            if ischar(data_line) % Verifica se a linha lida é um texto válido

                if isempty(data_line) || contains(data_line, 'PROP RPM')
                    break; % Quebrar o loop se encontrar uma nova seção de RPM
                end
                % Extrair valores das colunas: V, Thrust, Torque
                data = sscanf(data_line, '%f', [1, 13]);
    
                % Verifica se o tamanho de 'data' é menor que 13 e preenche com zeros
                if numel(data) < 13
                    data(numel(data)+1:13) = 0;  % Completa os valores restantes com zeros
                end
                J = data(2);       % Advanced Ratio
                CT = data(4);      % CT
                Torque = data(10); % Torque
                V = data(1);       % Airspeed
                
                % Adicionar os dados à matriz temporária
                temp_data = [temp_data; J, CT, Torque, V];
            else
                break;
            end
        end
        
        % Adicionar a matriz temporária à matriz 3D
        if isempty(data_matrix)
            data_matrix = temp_data;
        else
            data_matrix(:,:,end+1) = temp_data;
        end
    end
end

% Fechar o arquivo
fclose(fid);

% Resultado: data_matrix contém os dados em formato 3D, onde
% cada "página" corresponde a um RPM diferente
% rpm_values contém a lista de RPMs processados

% Remove os últimos dados para evitar zeros
data_matrix = data_matrix(1:end-4,:,:);

% Converte a velocidade de mph para m/s
data_matrix(:,4,:) = data_matrix(:,4,:)*0.44704; 



clc
disp('Matriz de dados processada com sucesso!');


% [numValoresDeV, ~, numValoresDeRPM] = size(data_matrix);
% 
% % Figura 1: V x Thrust
% figure;
% hold on;
% for i = 1:numValoresDeRPM
%     plot(data_matrix(:, 1, i), data_matrix(:, 2, i), 'LineWidth', 2);  % V x Thrust
% end
% title('J x C_T');
% xlabel('J');
% ylabel('C_T');
% legend(arrayfun(@(x) sprintf('RPM = %d', x), rpm_values, 'UniformOutput', false));
% grid on;
% hold off;
% 
% % Figura 2: V x Torque
% figure;
% hold on;
% for i = 1:numValoresDeRPM
%     plot(data_matrix(:, 1, i), data_matrix(:, 3, i), 'LineWidth', 2);  % V x Torque
% end
% title('J x Torque');
% xlabel('J');
% ylabel('Torque (Nm)');
% legend(arrayfun(@(x) sprintf('RPM = %d', x), rpm_values, 'UniformOutput', false));
% grid on;
% hold off;
% end