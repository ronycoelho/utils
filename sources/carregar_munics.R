# A funcao carregar uma lista de dois objetos: 1 - O dicionário da Munic, contido na primeira aba do excel; 2 - Os dados das Munics contidos em todas as demais abas, unidos por "A1".
#O link vem de: ftp://ftp.ibge.gov.br/Perfil_Municipios/

carregar_munics <- function(link_da_munic, ano, cod_mun){
  # definir diretório e arquivo temporário
  library(readxl)
  wd_origin <- getwd()
  temp_dir <- tempdir()
  setwd(temp_dir)
  temp_file <- tempfile(tmpdir = temp_dir)
  # Criar lista para armazenar arquivos 
  Munic_list <- list()
  # Download da Munic
  download.file(url = link_da_munic, destfile = temp_file)
  # unizip
  unzip(temp_file)
  # remover temporário
  file.remove(temp_file)
  # selecionar o arquivo xls
  file.xls <- list.files(pattern = "xls")
  # Nome da Munic
  Munic <- paste0("Munic_", ano)
  # Carregar todas as abas do excel  
  Munic <- file.xls %>% 
    excel_sheets() %>% 
    set_names() %>% 
    map(read_excel, path = file.xls)
  # remover arquivo xls da pasta temporaria
  file.remove(file.xls)
  # Nome do dicionario
  dic <- paste0("dic_", ano)
  # selecionar dicionário
  dic <- Munic[[1]]
  # excluir dicionário
  Munic[[1]] <- NULL
  # Mesclar todas as abas do excel
  Munic <- Munic %>% 
    reduce(full_join, by = cod_mun)
  # Criar nome da lista 
  list <- paste0("list_", Munic)
  # criar lista com dicionário e Munic
  list <- list(dic, Munic)
  # retornar ao diretório orginal
  setwd(wd_origin)
  # retornar objeto list com dicionário e Munics
  return(list)
}