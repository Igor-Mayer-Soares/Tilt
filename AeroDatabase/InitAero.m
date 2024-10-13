folderPath = [curr_dir '\AeroDatabase\CoefsDatabase']; % Substitua pelo caminho da sua pasta

% Listar todos os arquivos .mat na pasta
matFiles = dir(fullfile(folderPath, '*.mat'));

% Loop para carregar cada arquivo e colocar as variáveis no workspace
for cont = 1:length(matFiles)
    % Carregar o arquivo
    fileName = fullfile(folderPath, matFiles(cont).name);
    load(fileName);
end