clear all
close all

alpha_vec = -10:1:12;
beta_vec = -5:1:5;

for cont1 = 1:length(alpha_vec)
    for cont = 1:length(beta_vec)
        avl_run('tilt',alpha_vec(cont1),beta_vec(cont))
    end
end

% Pasta onde estão os arquivos .st
folderPath = 'Database';

% Lista todos os arquivos .st no diretório
files = dir(fullfile(folderPath, '*.st'));

% Coeficientes de interesse
coefNames = {'CLa', 'Cma', 'CYb', 'Clb', 'Cnb', 'CYp', 'Clp', 'Cnp', ...
    'CLq', 'Cmq', 'CYr', 'Clr', 'Cnr', 'CYd01', 'Cld01', 'Cnd01', ...
    'CLd02', 'Cmd02', 'CYd03', 'Cld03', 'Cnd03'};

% Inicializa tabelas para armazenar os coeficientes com alpha e beta
coefData = struct();

% Inicializa cada tabela para cada coeficiente
for cont = 1:length(coefNames)
    coefData.(coefNames{cont}) = table();
end

% Loop para processar cada arquivo
for fileIdx = 1:length(files)
    % Nome do arquivo
    filePath = fullfile(folderPath, files(fileIdx).name);
    
    % Abre o arquivo .st
    fileID = fopen(filePath, 'r');
    fileText = fread(fileID, '*char')';
    fclose(fileID);
    
    % Extrai Alpha e Beta
    alpha = regexp(fileText, 'Alpha\s*=\s*([-+]?\d*\.\d+|\d+)', 'tokens');
    alpha = str2double(alpha{1}{1});
    
    beta = regexp(fileText, 'Beta\s*=\s*([-+]?\d*\.\d+|\d+)', 'tokens');
    beta = str2double(beta{1}{1});
    
    % Extrai os coeficientes de interesse
    for cont = 1:length(coefNames)
        coefPattern = strcat(coefNames{cont});
        coefValue = regexp(fileText, [coefPattern , '\s*=\s*([-+]?\d*\.\d+|\d+)'], 'tokens');
        coefValue = str2double(coefValue{1}{1});
        
        % Adiciona os dados na tabela correspondente
        coefData.(coefNames{cont}) = [coefData.(coefNames{cont}); table(alpha, beta, coefValue)];
    end
end

% Salva cada tabela com o nome do coeficiente
for i = 1:length(coefNames)
    writetable(coefData.(coefNames{i}), strcat(coefNames{i}, '_table.csv'));
end

% Obtem os nomes das tabelas dentro da estrutura coefData
tableNames = fieldnames(coefData);

% Loop através de cada tabela dentro de coefData
for cont = 1:length(tableNames)
    % Nome atual da tabela
    tableName = tableNames{cont};
    
    % Obtém a tabela atual (por exemplo, coefData.CLa)
    currentTable = coefData.(tableName);
    
    % Identifica os valores únicos de alpha e beta
    alphaValues = unique(currentTable(:, 1));  % Valores únicos de alpha
    betaValues = unique(currentTable(:, 2));   % Valores únicos de beta

    % Inicializa a matriz 3D para o coeficiente atual: Alpha x coefValue x Beta
    numAlpha = length(alphaValues.alpha);
    numBeta = length(betaValues.beta);
    matrix3D = NaN(numAlpha, 1, numBeta);  % Inicializa a matriz

    % Preenche a matriz 3D com os coefValues da tabela
    for cont1 = 1:size(currentTable, 1)
        % Obtém alpha, beta, coefValue da tabela
        alpha = currentTable(cont1, 1);
        beta = currentTable(cont1, 2);
        coefValue = currentTable(cont1, 3);

        % Índices correspondentes para alpha e beta
        alphaIdx = find(alphaValues.alpha == alpha.alpha);
        betaIdx = find(betaValues.beta == beta.beta);

        % Preenche a matriz 3D com coefValue
        matrix3D(alphaIdx, 1, betaIdx) = coefValue.coefValue;
    end

    % Cria uma variável na workspace com o nome da tabela e atribui a matriz 3D
    assignin('base', tableName, matrix3D);
    save(['CoefsDatabase/' tableName],tableName);
end