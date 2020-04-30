
# carregando dados
setwd("C:/Users/diego/Desktop/Códigos R/DadosFilmes")
movies <- read.csv("AvaliaçãoDeFilmes.csv")
movies

colnames(movies) <- c("Film", "Genre", "CriticRating", 
                      "AudienceRating", "BudgetMillions", 
                      "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)

# Factor pra mudar a coluna year de int pra categorias
movies$Year <- factor(movies$Year)
summary(movies)


# ------------- Estética

library(ggplot2)

# aes basicamente cuida da estetica, do q vai aparecer no grafico
# geom_point define o tipo de grafico, com pontos
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + geom_point()

# adiciona cores
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre)) + geom_point()

# adicionar tamanho das bolinhas de acordo com o orçamento
ggplot(data=movies, aes(x=CriticRating, 
                        y=AudienceRating, 
                        colour=Genre,
                        size=BudgetMillions)) + geom_point()



# ----------- Camadas de plotagem

p <- ggplot(data=movies, aes(x=CriticRating, 
                        y=AudienceRating, 
                        colour=Genre,
                        size=BudgetMillions))

# grafico utilizando pontos
p + geom_point()

# grafico utilizano linhas
p + geomline()

# multiplas camadas no grafico
p + geom_line() + geom_point() 



# ----------- sobreescrevendo a estética

q <- ggplot(data=movies, aes(x=CriticRating, 
                             y=AudienceRating, 
                             colour=Genre,
                             size=BudgetMillions))

q + geom_point()


# sobreescrevendo o tamanho
q + geom_point(aes(size=CriticRating))

# sobrescrevendo a cor
q + geom_point(aes(colour=BudgetMillions))

# mantendo original
q + geom_point()

# sobrescrevendo o x
q + geom_point(aes(x=BudgetMillions)) + xlab("Orçamento em Milhões")

#reduzindo tamanho da linha (sem usar aes)
q + geom_line(size=1) + geom_point()

# a diferença entre usar ou não o aes é que se vc usar,
# estará mapeando (mapping), se não usar, estará setando (setting)


# ----------- Mapping vs Setting

r <- ggplot(data=movies, aes(x=CriticRating,
                             y=AudienceRating))
r + geom_point()

# adicionando cor com mapping
r + geom_point(aes(colour=Genre))
# adicionando cor com setting
r + geom_point(colour="DarkGreen")
# nao faria sentido passar um dado com aes, 
# que espera um vetor
r + geom_point(aes(colour="DarkGreen"))

# Mapping 
r + geom_point(aes(size=BudgetMillions))
# Setting 
r + geom_point(size=5)


# ----------- Histogramas e Gráficos de Densidade

s <- ggplot(data=movies, aes(BudgetMillions))
s + geom_histogram(binwidth = 10)

# adicionando cor
s + geom_histogram(binwidth = 10, aes(fill=Genre))
# adicionando borda
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour = "Black")


s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position ="stack")

# ----------- Mais criação de Gráficos

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, 
                   fill="white", 
                   colour='blue')

# ou... deixa mais abstrato pra especificar dps
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, aes(x=AudienceRating),
                                      fill= "white",
                                      colour = "blue")

t + geom_histogram(binwidth = 10, aes(x = CriticRating),
                                      fill = "white",
                                      colour = "blue")


# ----------- Transformações estatísticas

# geom_smooth = grafico que encontra tendencias, 
# dependencias e coorelacoes entre os dados
u <- ggplot(data=movies, aes(x=CriticRating, 
                            y=AudienceRating,
                            colour=Genre))
u + geom_point() + geom_smooth(fill=NA)

# boxplots
u + geom_boxplot()

u <- ggplot(data=movies, aes(x = Genre,
                             y = AudienceRating,
                             colour=Genre))
u + geom_boxplot(size = 1.2) + geom_point()

# dispersando mais os pontos
u + geom_boxplot(size = 1.2) + geom_jitter()

# ou, colocando os pontos por trás, numa camada anterior 
# ao boxplot, e adicionando transparencia
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)


# ----------- Usando facetas

v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, 
                   aes(fill=Genre),
                   colour="Black")

# separando cada genero em um grafico
v + geom_histogram(binwidth = 10, 
                   aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~.)

v + geom_histogram(binwidth = 10, 
                   aes(fill=Genre),
                   colour="Black") +
  facet_grid(.~Genre)

# ajustando as escalas pra que cada uma use a sua
v + geom_histogram(binwidth = 10, 
                   aes(fill=Genre),
                   colour="Black") +
  facet_grid(Genre~., scales = "free")

# outro grafico
w <- ggplot(data=movies, aes(x=CriticRating,
                             y=AudienceRating,
                             colour=Genre))
w + geom_point(size=3) +
  facet_grid(Genre~., scales="free")

w + geom_point(size=3) +
  facet_grid(.~Year, scales="free")

w + geom_point(aes(size=BudgetMillions)) +
  facet_grid(Genre~Year, scales="free")


# ----------- Limites e zoom

n <- ggplot(data=movies, aes(x=CriticRating,
                             y=AudienceRating,
                             size=BudgetMillions,
                             colour=Genre))
n + geom_point()

# limitando o grafico (nem sempre funciona)
n + geom_point() + xlim(50,100) + ylim(50,100)

n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth = 10, 
                   aes(fill=Genre),
                   colour="Black") + ylim(0,50)

# dessa forma, o zoom é uma melhor abordagem
n + geom_histogram(binwidth = 10, 
                   aes(fill=Genre),
                   colour="Black") + 
  coord_cartesian(ylim=c(0,50))

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year, scales="free") +
  coord_cartesian(ylim=c(0,100))


# -----------  Temas

o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10,
                   aes(fill=Genre),
                   colour="Black")

# Formatação das cores/tamanhos dos titulos e indices
h + xlab("Orçamento em milhões") +
    ylab("Número de filmes") +
    theme(axis.title.x = element_text(colour="DarkGreen", size=25),
          axis.title.y = element_text(colour="Red", size=25),
          axis.text.x = element_text(size=15),
          axis.text.y = element_text(size=15)
          )
# Formatação da legenda
h + xlab("Orçamento em milhões") +
  ylab("Número de filmes") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=25),
        axis.title.y = element_text(colour="Red", size=25),
        axis.text.x = element_text(size=15),
        axis.text.y = element_text(size=15),
        
        legend.title = element_text(size=20),
        legend.text = element_text(size=10),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(colour="DarkBlue",
                                  size=15,
                                  family = "Courier")
  )

