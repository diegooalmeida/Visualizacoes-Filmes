#Importando os dados
getwd()
setwd("C:/Users/diego/Desktop/Códigos R/DadosFilmes")
mov <- read.csv("AvaliaçãoDeFilmesExercicio.csv")

#Explorando os dados
head(mov) 
summary(mov) 
str(mov) 

#Ativar GGPlot2
library(ggplot2)

#Filtrar os dados pra deixar apenas os Generos e Estúdios 
#nos quais estamos interessados.
#Começando com o Genero, e usando o operador OU pra selecionar
#os diferentes generos.
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Agora o mesmo pra os Estúdios
filt2 <- (mov$Studio == "Buena Vista Studios") | (mov$Studio == "WB") | (mov$Studio == "Fox") | (mov$Studio == "Universal") | (mov$Studio == "Sony") | (mov$Studio == "Paramount Pictures")
  
#Aplicando os filtros ao DataFrame
mov2 <- mov[filt & filt2,]

#Preparando os dados de plotagem e as camadas aes
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))

#Adicionando geometria
p + geom_boxplot()

#Adicionando pontos
p + 
  geom_jitter(aes(size=Budget...mill., colour=Studio)) +
  geom_boxplot(alpha=0.7, outlier.color = NA)


# Salvando numa variável
q <- p + 
  geom_jitter(aes(size=Budget...mill., colour=Studio)) +
  geom_boxplot(alpha=0.7, outlier.color = NA)


# Alterando rótulos
q <- q +
  xlab("Genre") + 
  ylab("Gross % US") + 
  ggtitle("Domestic Gross % by Genre") 


#Theme
q <- q + 
  theme(
    # Alterando todos os elementos de texto
    text = element_text(family="Comic Sans MS"),
    
    #Títulos dos eixos:
    axis.title.x = element_text(colour="Blue", size=30),
    axis.title.y = element_text(colour="Blue", size=30),
    
    #Textos dos eixos:
    axis.text.x = element_text(size=20),
    axis.text.y = element_text(size=20),  
    
    #Título do gráfico:
    plot.title = element_text(colour="Black",
                              size=40),
    
    #Título da legenda:
    legend.title = element_text(size=20),
    
    #Texto da legenda
    legend.text  = element_text(size=12)
  )


q$labels$size = "Budget $M"
q
