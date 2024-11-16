folderPath = [curr_dir '\AeroDatabase\CoefsDatabase']; % Substitua pelo caminho da sua pasta

% Listar todos os arquivos .mat na pasta
matFiles = dir(fullfile(folderPath, '*.mat'));

% Inicializar a estrutura aero
aero = struct();

% Loop para carregar cada arquivo e colocar as variáveis na estrutura
for cont = 1:length(matFiles)
    % Carregar o arquivo
    fileName = fullfile(folderPath, matFiles(cont).name);
    data = load(fileName);
    
    % Obter o nome do arquivo sem extensão para usar como campo da estrutura
    [~, fieldName] = fileparts(matFiles(cont).name);
    
    % Transferir o conteúdo da variável para o campo correspondente
    varNames = fieldnames(data); % Obter nomes das variáveis no arquivo
    if numel(varNames) == 1
        % Se houver apenas uma variável no arquivo, use ela diretamente
        aero.(fieldName) = data.(varNames{1});
    else
        % Caso contrário, armazene todas as variáveis do arquivo como uma subestrutura
        aero.(fieldName) = data;
    end
end
