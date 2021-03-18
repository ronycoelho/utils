# https://www.youtube.com/watch?v=5_Ir8neyFf4

# https://www.youtube.com/watch?v=5_Ir8neyFf4

# https://basedosdados.org/

#coelhorgs@gmail.com

#------------------------------------------#
# Workshop: Base dos Dados no R
#------------------------------------------#

# PASSO 1: criar usuário e projeto no BigQuery
https://console.cloud.google.com/home/dashboard?project=kinetic-pilot-302617&organizationId=0


# PASSO 2: criar arquivo de credenciais e salvar numa pasta
# Substituir project ID pelo ID criado no projeto

# https://console.cloud.google.com/apis/credentials/serviceaccountkey?project=<project_id>

# service account name: admin
# role: project owner

#------------------------------------------------------------------------------#
# prefacio
#------------------------------------------------------------------------------#

rm(list = ls())

library(DBI)
library(bigrquery)
library(ggplot2)

# PASSO 3: apontar a autenticação para o arquivo json
bq_auth(path = "~/projeto teste-07cb9f54c282.json")

# PASSO 4: criar conexão com o BigQuery
con <- dbConnect(
  bigrquery::bigquery(),
  billing = "kinetic-pilot-302617",
  project = "basedosdados"
)

#------------------------------------------------------------------------------#
# Exemplo 1: baixando dados
#------------------------------------------------------------------------------#

#------------------------#
# a nível de município
#------------------------#

query = "SELECT * FROM `basedosdados.br_ms_sim.municipio`"

df.sim = dbGetQuery(con, query)

#------------------------#
# microdados
# 2010 em MG
#------------------------#

query = "SELECT *
         FROM `basedosdados.br_ms_sim.microdados`
         WHERE ano = 2010 AND estado_abrev = 'AC'"

df.sim.microdados = dbGetQuery(con, query)

#------------------------------------------------------------------------------#
# Exemplo 2: cruzando bases
#------------------------------------------------------------------------------#

#--------------#
# PIB p.c.
#--------------#

query.pib_pc = "SELECT 
    pib.id_municipio ,
    pop.ano, 
    pib.PIB / pop.populacao as pib_pc
FROM `basedosdados.br_ibge_pib.municipios` as pib
INNER JOIN `basedosdados.br_ibge_populacao.municipios` as pop
ON pib.id_municipio = pop.id_municipio AND pib.ano = pop.ano"

df.pib_pc = dbGetQuery(con, query.pib_pc)

#--------------#
# desmatamento
#--------------#

query_desm_tes <- "SELECT * FROM `basedosdados.br_inpe_prodes.desmatamento_municipios` LIMIT 100"

my_test <- dbGetQuery(con, query_desm_tes)


query = "SELECT * FROM `basedosdados.br_inpe_prodes.desmatamento_municipios`"

df.prodes = dbGetQuery(con, query)

#--------------#
# analise
#--------------#

df.analise = merge(df.pib_pc, df.prodes, on=c("id_municipio","ano"))
df.analise$ln_pib_pc = log(df.analise$pib_pc)

# scatter plot
plot(df.analise$ln_pib_pc, df.analise$desmatado, xlab="ln(PIB p.c. (R$))", ylab="Área Desmatada (km2)")

# regressao
modelo = lm(desmatado ~ ln_pib_pc + factor(ano), data = df.analise)
summary(modelo)$coefficients

#------------------------------------------------------------------------------#
# Exemplo 3: relacao entre populacao e numero de candidatos em eleicoes
#------------------------------------------------------------------------------#

# diretorio
query = "SELECT * FROM `basedosdados.br_bd_diretorios_brasil.municipio`"

df.diretorio = dbGetQuery(con, query)

# numero de candidatos
query = "SELECT ano, sigla_uf, cargo, SUM(1) AS n_candidatos
         FROM `basedosdados.br_tse_eleicoes.candidatos`
         GROUP BY ano, sigla_uf, cargo
         ORDER BY ano, sigla_uf, cargo ASC"

df.eleicoes = dbGetQuery(con, query)

# populacao
query = "SELECT pop.ano, munic.sigla_uf, SUM(pop.populacao) AS populacao
         FROM `basedosdados.br_ibge_populacao.municipios` AS pop
           INNER JOIN `basedosdados.br_bd_diretorios_brasil.municipio` AS munic
           ON munic.id_municipio = pop.id_municipio
         GROUP BY ano, sigla_uf
         ORDER BY ano, sigla_uf ASC"
df.populacao = dbGetQuery(con, query)

# merge
df.analise = merge(df.eleicoes, df.populacao, by=c("sigla_uf","ano"))

df.analise$ln_populacao = log(df.analise$populacao)

# regressao
modelo = lm(n_candidatos ~ ln_populacao + factor(ano),
            data = df.analise[df.analise$cargo=="vereador",])

summary(modelo)$coefficients

# grafico: numero de vereadores ao longo do tempo, por UF
ggplot(df.analise[df.analise$cargo=="vereador",], 
       aes(x=ano, y=n_candidatos, group=sigla_uf)) +
  geom_line()


########################################3333333
query = "SELECT * FROM `basedosdados.br_tse_eleicoes.candidatos` LIMIT 100"
query = "SELECT * FROM `basedosdados.br_tse_eleicoes.resultados_candidato` LIMIT 100"


df.dep2 = dbGetQuery(con, query)
